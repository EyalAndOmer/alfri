import { Component, inject, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatProgressBarModule } from '@angular/material/progress-bar';

import { Router } from '@angular/router';
import { MatRadioButton, MatRadioGroup } from '@angular/material/radio';
import { Subject, takeUntil } from 'rxjs';
import { FormsModule } from '@angular/forms';
import { SubjectGradesDto } from '../../types';
import {
  MatCard,
  MatCardContent,
  MatCardHeader,
  MatCardTitle,
} from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { SubjectService } from '@services/subject.service';

@Component({
  selector: 'app-subject-reports',
  templateUrl: './subject-reports.component.html',
  standalone: true,
  styleUrls: ['./subject-reports.component.scss'],
  imports: [
    MatTableModule,
    MatProgressBarModule,
    MatRadioButton,
    MatRadioGroup,
    FormsModule,
    MatCard,
    MatCardHeader,
    MatCardTitle,
    MatCardContent,
    MatFormFieldModule,
    MatSelectModule,
    MatPaginatorModule,
  ],
})
export class SubjectReportsComponent implements OnInit, OnDestroy {
  private readonly _destroy$: Subject<void> = new Subject();
  private readonly subjectsService = inject(SubjectService);
  private readonly router = inject(Router);

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  dataSource = new MatTableDataSource<SubjectGradesDto>([]);
  isLoading = false;

  sortCriteria = 'lowestAverage';

  public readonly columnsToDisplay: string[] = [
    'name',
    'code',
    'studentsCount',
    'averageScore',
    'gradeA',
    'gradeB',
    'gradeC',
    'gradeD',
    'gradeE',
    'gradeFx',
  ];

  ngOnInit(): void {
    this.fetchFilteredSubjects();
  }

  ngAfterViewInit(): void {
    this.dataSource.paginator = this.paginator;
  }

  ngOnDestroy(): void {
    this._destroy$.next();
    this._destroy$.complete();
  }

  fetchFilteredSubjects(): void {
    this.isLoading = true;

    // Fetch a large number to get all subjects for client-side pagination
    this.subjectsService
      .getFilteredSubjects(this.sortCriteria, 100)
      .pipe(takeUntil(this._destroy$))
      .subscribe({
        next: (data) => {
          this.dataSource.data = data;
          this.isLoading = false;
        },
        error: (error) => {
          console.error('Error fetching subjects:', error);
          this.isLoading = false;
        },
      });
  }

  public navigateToSubjectDetail(code: string): void {
    this.router.navigate(['/subjects/', code]);
  }

  onSortChange(): void {
    this.fetchFilteredSubjects();
  }
}
