import {
  Component,
  input,
  output,
  computed,
  signal,
  effect,
  viewChild,
} from '@angular/core';
import { Observable } from 'rxjs';
import { Page, SubjectDto } from '../../types';
import { MatPaginator, MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { CommonModule } from '@angular/common';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';

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
  dataSourceInput = input<SubjectDto[] | MatTableDataSource<SubjectDto> | Observable<SubjectDto[]>>();
  legacyDataSource$ = input<SubjectDto[] | MatTableDataSource<SubjectDto> | Observable<SubjectDto[]>>({ alias: 'dataSource$' });
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

  // ViewChild as signal
  paginator = viewChild(MatPaginator);

  // Internal signals
  private readonly internalDataSource = signal<MatTableDataSource<SubjectDto>>(new MatTableDataSource<SubjectDto>([]));
  private readonly selectedSubjectsMap = signal<Map<string, SubjectDto>>(new Map());

  // Computed: list of columns
  columnsToDisplay = computed(() => {
    const full = this.displayFullInfo();
    const selectable = this.isSelectable();
    const cols = full
      ? ['name', 'code', 'abbreviation', 'obligation', 'recommendedYear', 'semester']
      : ['name', 'abbreviation', 'obligation'];
    if (selectable) {
      cols.unshift('select');
    }
    return cols;
  });

  // Computed: selected subjects array & count
  selectedSubjectsList = computed(() => Array.from(this.selectedSubjectsMap().values()));
  selectedSubjectsCount = computed(() => this.selectedSubjectsMap().size);

  constructor() {
    // Effect: resolve provided dataSource input into a MatTableDataSource
    effect((onCleanup) => {
      const primary = this.dataSourceInput();
      const legacy = this.legacyDataSource$();
      const ds = primary ?? legacy;
      if (!ds) {
        return;
      }
      if (ds instanceof MatTableDataSource) {
        this.internalDataSource.set(ds);
      } else if (Array.isArray(ds)) {
        // Replace data while preserving same instance for table reference stability
        const current = this.internalDataSource();
        current.data = ds;
        this.internalDataSource.set(current);
      } else {
        // Observable: subscribe and update
        const sub = (ds as Observable<SubjectDto[]>)
          .pipe(takeUntilDestroyed())
          .subscribe((arr) => {
            const current = this.internalDataSource();
            current.data = arr || [];
            this.internalDataSource.set(current);
          });
        onCleanup(() => sub.unsubscribe());
      }
    });

    // Effect: attach paginator when available
    effect(() => {
      const paginatorInstance = this.paginator();
      const table = this.internalDataSource();
      if (paginatorInstance) {
        table.paginator = paginatorInstance;
      }
    });

    // Effect: emit selected subjects whenever list changes
    effect(() => {
      this.selectedSubjects.emit(this.selectedSubjectsList());
    });

    // Effect: prune selections if subjects disappear from datasource
    effect(() => {
      const data = this.internalDataSource().data;
      const codes = new Set(data.map((s) => s.code));
      this.selectedSubjectsMap.update((map) => {
        let mutated = false;
        for (const code of [...map.keys()]) {
          if (!codes.has(code)) {
            map.delete(code);
            mutated = true;
          }
        }
        return mutated ? new Map(map) : map;
      });
    });
  }

  // Exposed getter for template binding to table data source
  get resolvedDataSource(): MatTableDataSource<SubjectDto> {
    return this.internalDataSource();
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

  clearSelection(): void {
    this.selectedSubjectsMap.set(new Map());
  }

  trackByCode = (_: number, item: SubjectDto) => item.code;
}
