import { Component, inject, OnDestroy, OnInit, signal } from '@angular/core';
import { Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';
import { Page, SubjectGradesDto } from '../../types';
import {
  MatCard,
  MatCardContent,
  MatCardHeader,
  MatCardTitle,
} from '@angular/material/card';
import { SubjectService } from '@services/subject.service';
import {
  GenericTableComponent,
  TableConfig,
  TextCellRendererComponent,
  NumberCellRendererComponent,
  PercentageCellRendererComponent,
} from '@components/generic-table';
import { GenericTableUtils } from '@components/generic-table/generic-table.utils';

@Component({
  selector: 'app-subject-reports',
  templateUrl: './subject-reports.component.html',
  standalone: true,
  styleUrls: ['./subject-reports.component.scss'],
  imports: [
    MatCard,
    MatCardHeader,
    MatCardTitle,
    MatCardContent,
    GenericTableComponent,
  ],
})
export class SubjectReportsComponent implements OnInit, OnDestroy {
  private readonly _destroy$: Subject<void> = new Subject();
  private readonly subjectsService = inject(SubjectService);
  private readonly router = inject(Router);

  // Signals for reactive state management
  subjectsData = signal<Page<SubjectGradesDto & { id: number }>>(GenericTableUtils.EMPTY_PAGE);
  isLoading = signal<boolean>(false);

  // Generic table configuration
  tableConfig: TableConfig<SubjectGradesDto & { id: number }> = {
    columns: [
      {
        id: 'name',
        header: 'Názov',
        field: 'subject.name',
        sortable: true,
        cellRenderer: TextCellRendererComponent,
        width: 'auto',
      },
      {
        id: 'code',
        header: 'Kód predmetu',
        field: 'subject.code',
        sortable: true,
        cellRenderer: TextCellRendererComponent,
        width: '150px',
        align: 'center',
      },
      {
        id: 'studentsCount',
        header: 'Počet študentov',
        field: 'studentsCount',
        sortable: true,
        cellRenderer: NumberCellRendererComponent,
        width: '150px',
        align: 'center',
      },
      {
        id: 'averageScore',
        header: 'Priemerná známka',
        field: 'gradeAverage',
        sortable: true,
        cellRenderer: NumberCellRendererComponent,
        width: '150px',
        align: 'center',
      },
      {
        id: 'gradeA',
        header: 'A',
        field: 'gradeA',
        sortable: true,
        cellRenderer: PercentageCellRendererComponent,
        width: '100px',
        align: 'center',
      },
      {
        id: 'gradeB',
        header: 'B',
        field: 'gradeB',
        sortable: true,
        cellRenderer: PercentageCellRendererComponent,
        width: '100px',
        align: 'center',
      },
      {
        id: 'gradeC',
        header: 'C',
        field: 'gradeC',
        sortable: true,
        cellRenderer: PercentageCellRendererComponent,
        width: '100px',
        align: 'center',
      },
      {
        id: 'gradeD',
        header: 'D',
        field: 'gradeD',
        sortable: true,
        cellRenderer: PercentageCellRendererComponent,
        width: '100px',
        align: 'center',
      },
      {
        id: 'gradeE',
        header: 'E',
        field: 'gradeE',
        sortable: true,
        cellRenderer: PercentageCellRendererComponent,
        width: '100px',
        align: 'center',
      },
      {
        id: 'gradeFx',
        header: 'FX',
        field: 'gradeFx',
        sortable: true,
        cellRenderer: PercentageCellRendererComponent,
        width: '100px',
        align: 'center',
      },
    ],
    serverSide: false, // Using client-side since we're getting all data at once
    enableSorting: true, // Enable client-side sorting
    enablePagination: true,
    pageSize: 10,
    pageSizeOptions: [5, 10, 20, 50],
    enableRowClick: true,
    stickyHeader: true,
    header: {
      show: true,
      enableSearch: true,
      searchPlaceholder: 'Vyhľadať predmet...',
    },
    filterPredicate: (data: SubjectGradesDto & { id: number }, filter: string): boolean => {
      const normalizedFilter = filter.toLowerCase();
      const subjectName = data.subject.name?.toLowerCase() || '';
      return subjectName.includes(normalizedFilter);
    },
  };

  ngOnInit(): void {
    this.fetchFilteredSubjects();
  }

  ngOnDestroy(): void {
    this._destroy$.next();
    this._destroy$.complete();
  }

  fetchFilteredSubjects(): void {
    this.isLoading.set(true);

    // Fetch all subjects for client-side pagination and sorting
    this.subjectsService
      .getFilteredSubjects('lowestAverage', 1000) // Fetch all subjects
      .pipe(takeUntil(this._destroy$))
      .subscribe({
        next: (data) => {
          // Convert array response to Page format and add id property
          const pageData: Page<SubjectGradesDto & { id: number }> = {
            content: data.map((item, index) => ({
              ...item,
              id: item.subject.id || index, // Use subject id or fallback to index
            })),
            totalElements: data.length,
            totalPages: Math.ceil(data.length / this.tableConfig.pageSize!),
            size: this.tableConfig.pageSize!,
            number: 0,
            pageable: {
              sort: { sorted: false, unsorted: true, empty: true },
              offset: 0,
              pageNumber: 0,
              pageSize: this.tableConfig.pageSize!,
              paged: true,
              unpaged: false,
            },
            last: data.length <= this.tableConfig.pageSize!,
            sort: { sorted: false, unsorted: true, empty: true },
            first: true,
            numberOfElements: Math.min(data.length, this.tableConfig.pageSize!),
            empty: data.length === 0,
          };

          this.subjectsData.set(pageData);
          this.isLoading.set(false);
        },
        error: (error) => {
          console.error('Error fetching subjects:', error);
          this.isLoading.set(false);
        },
      });
  }


  onRowClick(event: { row: SubjectGradesDto & { id: number }; event: MouseEvent }): void {
    this.router.navigate(['/subjects', event.row.subject.code]);
  }
}
