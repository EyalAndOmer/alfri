import {Component, computed, effect, input, output, signal, viewChild} from '@angular/core';
import {Observable} from 'rxjs';
import {Page, SubjectDto} from '../../types';
import {MatPaginator, MatPaginatorModule, PageEvent} from '@angular/material/paginator';
import {MatTableDataSource, MatTableModule} from '@angular/material/table';
import {MatProgressBarModule} from '@angular/material/progress-bar';
import {MatCheckboxModule} from '@angular/material/checkbox';
import {CommonModule} from '@angular/common';

@Component({
  selector: 'app-subjects-table',
  standalone: true,
  imports: [
    CommonModule,
    MatTableModule,
    MatProgressBarModule,
    MatPaginatorModule,
    MatCheckboxModule,
  ],
  templateUrl: './subjects-table.component.html',
  styleUrls: ['./subjects-table.component.scss'],
})
export class SubjectsTableComponent {
  // Inputs (signal-based)
  dataSourceInput = input<MatTableDataSource<SubjectDto>>();
  legacyDataSource$ = input<SubjectDto[] | MatTableDataSource<SubjectDto> | Observable<SubjectDto[]>>(); // legacy binding support
  pageData = input.required<Page<SubjectDto>>();
  isLoading = input<boolean>(true);
  displayFullInfo = input<boolean>(true);
  isSelectable = input<boolean>(false);
  maxSelectableSubjects = input<number>(Infinity);
  isPageable = input<boolean>(true);
  isScrollable = input<boolean>(false);

  // Outputs (signal-based) - still EventEmitter under the hood but created via output()
  pageChange = output<PageEvent>();
  subjectDetailNavigate = output<string>();
  selectedSubjects = output<SubjectDto[]>();

  // Internal signals
  readonly internalDataSource = signal<MatTableDataSource<SubjectDto>>(new MatTableDataSource<SubjectDto>([]));
  private readonly selectedSubjectsMap = signal<Map<string, SubjectDto>>(new Map());

  // Computed: list of columns
  columnsToDisplay = computed(() => {
    const full = this.displayFullInfo();
    return full
      ? ['select', 'name', 'code', 'abbreviation', 'obligation', 'recommendedYear', 'semester']
      : ['select', 'name', 'abbreviation', 'obligation'];
  });

  // Computed: selected subjects array & count
  selectedSubjectsList = computed(() => Array.from(this.selectedSubjectsMap().values()));
  selectedSubjectsCount = computed(() => this.selectedSubjectsMap().size);

  constructor() {
    // Effect: sync dataSourceInput with internalDataSource
    effect(() => {
      const input = this.dataSourceInput();
      if (input) {
        this.internalDataSource.set(input);
      }
    });


    // Effect: emit selected subjects whenever list changes
    effect(() => {
      this.selectedSubjects.emit(this.selectedSubjectsList());
    });
  }


  onPageChange(event: PageEvent) {
    if (!this.isPageable()) {
      return;
    }
    this.pageChange.emit(event);
  }

  navigateToSubjectDetail(code: string) {
    this.subjectDetailNavigate.emit(code);
  }

  toggleSelection(subject: SubjectDto): void {
    this.selectedSubjectsMap.update((map) => {
      const has = map.has(subject.code);
      if (has) {
        map.delete(subject.code);
        return new Map(map);
      }
      // Add new if below maximum
      if (this.selectedSubjectsCount() < this.maxSelectableSubjects()) {
        map.set(subject.code, subject);
      }
      return new Map(map);
    });
  }

  isDisabled(subject: SubjectDto): boolean {
    return (
      !this.selectedSubjectsMap().has(subject.code) &&
      this.selectedSubjectsCount() >= this.maxSelectableSubjects()
    );
  }

  isSelected(subject: SubjectDto): boolean {
    return this.selectedSubjectsMap().has(subject.code);
  }

  trackByCode = (_: number, item: SubjectDto) => item.code;
}
