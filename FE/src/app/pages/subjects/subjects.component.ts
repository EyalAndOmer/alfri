import {Component, inject, OnDestroy, OnInit} from '@angular/core';
import {
  catchError,
  debounceTime,
  distinctUntilChanged,
  Observable,
  of,
  Subject,
  switchMap,
  takeUntil,
  tap,
} from 'rxjs';
import { StudyProgramService } from '@services/study-program.service';
import { CommonModule } from '@angular/common';
import { PageEvent } from '@angular/material/paginator';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatOptionModule } from '@angular/material/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { SubjectsTableComponent } from '@components/subjects-table/subjects-table.component';
import { Page, StudyProgramDto, SubjectDto } from '../../types';
import { MatCard, MatCardContent, MatCardHeader } from '@angular/material/card';
import { SubjectService } from '@services/subject.service';
import { MatTableDataSource } from '@angular/material/table';
import { MatInput } from '@angular/material/input';
import { MatIcon } from '@angular/material/icon';

@Component({
  selector: 'app-subjects',
  standalone: true,
  imports: [
    CommonModule,
    MatSelectModule,
    MatFormFieldModule,
    MatOptionModule,
    FormsModule,
    ReactiveFormsModule,
    SubjectsTableComponent,
    MatCard,
    MatCardContent,
    MatInput,
    MatIcon,
  ],
  templateUrl: './subjects.component.html',
  styleUrls: ['./subjects.component.scss'],
})
export class SubjectsComponent implements OnInit, OnDestroy {
  private readonly _destroy$: Subject<void> = new Subject();
  private readonly _searchTerm$: Subject<string> = new Subject();
  dataSource = new MatTableDataSource<SubjectDto>([]);
  private _studyPrograms$!: Observable<StudyProgramDto[]>;
  private _selectedStudyProgramId!: number;
  filterForm: FormGroup;
  isLoading = false;
  searchTerm: string = '';

  readonly pageData: Page<SubjectDto> = {
    content: [],
    totalElements: 0,
    size: 10,
    number: 0,
    pageable: {
      sort: {
        sorted: false,
        unsorted: false,
        empty: false,
      },
      offset: 0,
      pageNumber: 0,
      pageSize: 0,
      paged: false,
      unpaged: false,
    },
    last: false,
    totalPages: 0,
    sort: {
      sorted: false,
      unsorted: false,
      empty: false,
    },
    first: false,
    numberOfElements: 0,
    empty: false,
  };

  get studyPrograms$(): Observable<StudyProgramDto[]> {
    return this._studyPrograms$;
  }

  get selectedStudyProgramId(): number {
    return this._selectedStudyProgramId;
  }

  set selectedStudyProgramId(selected: number) {
    this._selectedStudyProgramId = selected;
  }

  private readonly subjectService = inject(SubjectService);
  private readonly studyProgramService = inject(StudyProgramService);
  private readonly formBuilder = inject(FormBuilder);
  private readonly router = inject(Router);
  private readonly activatedRoute = inject(ActivatedRoute);

  constructor() {
    this.filterForm = this.formBuilder.group({
      subjectForm: ['', [Validators.required]],
    });
  }

  ngOnInit() {
    this.init();
  }

  private init(): void {
    this._studyPrograms$ = this.studyProgramService
      .getAll()
      .pipe(takeUntil(this._destroy$));

    this._selectedStudyProgramId = 3;
    this.filterForm.patchValue({ subjectForm: this._selectedStudyProgramId });

    this.setupSearchSubscription();
    this.getSubjects(0, 10, this._selectedStudyProgramId);
  }

  private setupSearchSubscription(): void {
    this._searchTerm$
      .pipe(
        debounceTime(300),
        distinctUntilChanged(),
        tap(() => (this.isLoading = true)),
        switchMap((searchTerm: string) => {
          const searchParam = `id.studyProgramId:${this._selectedStudyProgramId},subject.name~${searchTerm}`
          return this.getSubjectsWithSearch(0, this.pageData.size || 10, searchParam);
        }),
        catchError(() => {
          this.isLoading = false;
          return of({
            content: [],
            totalElements: 0,
            size: 10,
            number: 0,
            pageable: {
              sort: { sorted: false, unsorted: false, empty: false },
              offset: 0,
              pageNumber: 0,
              pageSize: 0,
              paged: false,
              unpaged: false,
            },
            last: false,
            totalPages: 0,
            sort: { sorted: false, unsorted: false, empty: false },
            first: false,
            numberOfElements: 0,
            empty: true,
          });
        }),
        takeUntil(this._destroy$)
      )
      .subscribe((page) => {
        this.dataSource.data = page.content;
        Object.assign(this.pageData, {
          size: page.size,
          totalElements: page.totalElements,
          number: page.number,
          content: page.content,
          totalPages: page.totalPages,
          last: page.last,
          first: page.first,
          numberOfElements: page.numberOfElements,
          empty: page.empty
        });
        this.isLoading = false;
      });
  }

  onSearchChange(searchTerm: string): void {
    this._searchTerm$.next(searchTerm);
  }

  private getSubjects(
    pageNumber: number,
    pageSize: number,
    studyProgramId: number,
  ): void {
    this.subjectService
      .getSubjectsWithFocusByStudyProgramId(
        studyProgramId,
        pageNumber,
        pageSize,
      )
      .pipe(
        tap((page: Page<SubjectDto>) => {
          this.dataSource.data = page.content;
          Object.assign(this.pageData, {
            size: page.size,
            totalElements: page.totalElements,
            number: page.number,
            content: page.content,
            totalPages: page.totalPages,
            last: page.last,
            first: page.first,
            numberOfElements: page.numberOfElements,
            empty: page.empty
          });
          this.isLoading = false;
        }),
        takeUntil(this._destroy$),
        catchError(() => {
          this.isLoading = false;
          return of();
        }),
      )
      .subscribe();
  }

  private getSubjectsWithSearch(
    pageNumber: number,
    pageSize: number,
    searchParam: string,
  ): Observable<Page<SubjectDto>> {
    return this.subjectService
      .getSubjectsWithFocusByStudyProgramIdAndSearch(
        pageNumber,
        pageSize,
        searchParam,
      )
      .pipe(
        takeUntil(this._destroy$),
        catchError(() => {
          return of();
        }),
      );
  }

  studyProgramChanged() {
    this.isLoading = true;
    this.searchTerm = '';
    this.getSubjects(
      0,
      this.pageData.size,
      this._selectedStudyProgramId,
    );
  }

  onPageChange(event: PageEvent) {
    this.isLoading = true;

    if (this.searchTerm.trim()) {
      const searchParam = `id.studyProgramId:${this._selectedStudyProgramId},subject.name~${this.searchTerm}`;
      this.getSubjectsWithSearch(event.pageIndex, event.pageSize, searchParam)
        .pipe(
          tap((page: Page<SubjectDto>) => {
            this.dataSource.data = page.content;
            Object.assign(this.pageData, {
              size: page.size,
              totalElements: page.totalElements,
              number: page.number,
              content: page.content,
              totalPages: page.totalPages,
              last: page.last,
              first: page.first,
              numberOfElements: page.numberOfElements,
              empty: page.empty
            });
            this.isLoading = false;
          }),
          catchError(() => {
            this.isLoading = false;
            return of();
          }),
        )
        .subscribe();
    } else {
      this.getSubjects(
        event.pageIndex,
        event.pageSize,
        this._selectedStudyProgramId,
      );
    }
  }

  ngOnDestroy() {
    this._destroy$.next();
    this._destroy$.complete();
  }

  navigateToSubjectDetail(code: string) {
    this.router.navigate([code], { relativeTo: this.activatedRoute });
  }
}
