import {
  Component,
  inject,
  OnDestroy,
  OnInit,
  ViewChild,
  signal,
  computed,
} from '@angular/core';
import { SubjectsTableComponent } from '@components/subjects-table/subjects-table.component';
import {
  catchError,
  debounceTime,
  distinctUntilChanged,
  finalize,
  Observable,
  of,
  shareReplay,
  Subject,
  switchMap,
  takeUntil,
  tap,
} from 'rxjs';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { HttpErrorResponse } from '@angular/common/http';
import { StudentService } from '@services//student.service';
import { NotificationService } from '@services//notification.service';
import { MatButton } from '@angular/material/button';
import { MatIcon } from '@angular/material/icon';
import { MatProgressBar } from '@angular/material/progress-bar';
import {
  Page,
  StudyProgramDto,
  SubjectDto,
  SubjectExtendedDto,
} from '../../types';
import {
  MatCard,
  MatCardContent,
  MatCardHeader,
  MatCardTitle,
} from '@angular/material/card';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { SubjectService } from '@services/subject.service';
import { MatTableDataSource } from '@angular/material/table';
import { MatStepper, MatStepperModule } from '@angular/material/stepper';
import {
  MatFormField,
  MatLabel,
  MatSuffix,
} from '@angular/material/form-field';
import { MatInput } from '@angular/material/input';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-subjects-clustering',
  standalone: true,
  imports: [
    SubjectsTableComponent,
    MatButton,
    MatIcon,
    MatProgressBar,
    MatCard,
    MatCardHeader,
    MatCardContent,
    MatCardTitle,
    NgxSkeletonLoaderModule,
    MatStepperModule,
    MatFormField,
    MatLabel,
    MatInput,
    FormsModule,
    MatSuffix,
  ],
  templateUrl: './subjects-clustering.component.html',
  styleUrls: ['./subjects-clustering.component.scss'],
})
export class SubjectsClusteringComponent implements OnInit, OnDestroy {
  @ViewChild('stepper') stepper!: MatStepper;

  private readonly _destroy$: Subject<void> = new Subject();
  private readonly _searchTerm$: Subject<string> = new Subject();
  dataSource = new MatTableDataSource<SubjectDto>([]);
  private _userStudyProgramId!: number;
  searchTerm: string = '';

  // Signals for reactive state management
  private readonly _selectedSubjects = signal<SubjectExtendedDto[]>([]);
  private readonly _recommendedSubjects = signal<SubjectDto[]>([]);
  readonly isLoadingAllSubjects = signal<boolean>(false);
  readonly isLoadingRecommendetSubjects = signal<boolean>(false);

  readonly allSubjectsPageData: Page<SubjectExtendedDto> = {
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

  // Computed signals for reactive page data
  readonly selectedSubjects = computed(() => this._selectedSubjects());

  readonly selectedSubjectsPageData = computed<Page<SubjectExtendedDto>>(() => {
    const subjects = this._selectedSubjects();
    return {
      content: subjects,
      totalElements: subjects.length,
      size: subjects.length,
      number: 0,
      pageable: {
        sort: { sorted: false, unsorted: true, empty: true },
        offset: 0,
        pageNumber: 0,
        pageSize: subjects.length,
        paged: false,
        unpaged: true,
      },
      last: true,
      totalPages: 1,
      sort: { sorted: false, unsorted: true, empty: true },
      first: true,
      numberOfElements: subjects.length,
      empty: subjects.length === 0,
    };
  });

  readonly recommendedSubjectsPageDataComputed = computed<Page<SubjectDto>>(
    () => {
      const subjects = this._recommendedSubjects();
      return {
        content: subjects,
        totalElements: subjects.length,
        size: subjects.length,
        number: 0,
        pageable: {
          sort: { sorted: false, unsorted: true, empty: true },
          offset: 0,
          pageNumber: 0,
          pageSize: subjects.length,
          paged: false,
          unpaged: true,
        },
        last: true,
        totalPages: 1,
        sort: { sorted: false, unsorted: true, empty: true },
        first: true,
        numberOfElements: subjects.length,
        empty: subjects.length === 0,
      };
    },
  );

  private readonly subjectService = inject(SubjectService);
  private readonly studentService = inject(StudentService);
  private readonly errorService = inject(NotificationService);
  private readonly router = inject(Router);

  ngOnInit() {
    this.init();
    this.setupSearchSubscription();
  }

  private init(): void {
    this.getStudentsStudyProgramAndItsSubjects();
    this._recommendedSubjects.set([]);
  }

  private setupSearchSubscription(): void {
    this._searchTerm$
      .pipe(
        debounceTime(300),
        distinctUntilChanged(),
        tap(() => this.isLoadingAllSubjects.set(true)),
        switchMap((searchTerm: string) => {
          const searchParam = searchTerm.trim()
            ? `id.studyProgramId:${this._userStudyProgramId},subject.name~${searchTerm}`
            : `id.studyProgramId:${this._userStudyProgramId}`;
          return this.getAllSubjectsWithSearch(0, 10, searchParam);
        }),
        catchError((error: HttpErrorResponse) => {
          this.errorService.showError(error.error);
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
        takeUntil(this._destroy$),
      )
      .subscribe((page) => {
        this.dataSource.data = page.content;
        Object.assign(this.allSubjectsPageData, {
          size: page.size,
          totalElements: page.totalElements,
          number: page.number,
          content: page.content,
          totalPages: page.totalPages,
          last: page.last,
          first: page.first,
          numberOfElements: page.numberOfElements,
          empty: page.empty,
        });
        this.isLoadingAllSubjects.set(false);
      });
  }

  onSearchChange(searchTerm: string): void {
    this._searchTerm$.next(searchTerm);
  }

  private getStudentsStudyProgramAndItsSubjects() {
    this.studentService
      .getStudyProgramOfCurrentUser()
      .pipe(
        switchMap((studyProgram: StudyProgramDto) => {
          this._userStudyProgramId = studyProgram.id;
          return this.getAllSubjects(0, 10, this._userStudyProgramId);
        }),
        catchError((error: HttpErrorResponse) => {
          this.errorService.showError(error.error);
          return of({
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
            empty: true,
          });
        }),
      )
      .subscribe((page) => {
        this.dataSource.data = page.content;
        Object.assign(this.allSubjectsPageData, {
          size: page.size,
          totalElements: page.totalElements,
          number: page.number,
          content: page.content,
          totalPages: page.totalPages,
          last: page.last,
          first: page.first,
          numberOfElements: page.numberOfElements,
          empty: page.empty,
        });
        this.isLoadingAllSubjects.set(false);
      });
  }

  private getAllSubjects(
    pageNumber: number,
    pageSize: number,
    studyProgramId: number,
  ): Observable<Page<SubjectExtendedDto>> {
    return this.subjectService
      .getSubjectsWithFocusByStudyProgramId(
        studyProgramId,
        pageNumber,
        pageSize,
      )
      .pipe(
        takeUntil(this._destroy$),
        catchError(() => {
          return of();
        }),
        shareReplay(1),
      );
  }

  private getAllSubjectsWithSearch(
    pageNumber: number,
    pageSize: number,
    searchParam: string,
  ): Observable<Page<SubjectExtendedDto>> {
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
        shareReplay(1),
      );
  }

  onPageChangeAllSubjects(event: PageEvent) {
    this.isLoadingAllSubjects.set(true);

    this.getAllSubjects(
      event.pageIndex,
      event.pageSize,
      this._userStudyProgramId,
    )
      .pipe(
        catchError((error: HttpErrorResponse) => {
          this.errorService.showError(error.error);
          return of({
            content: [],
            totalElements: 0,
            size: event.pageSize,
            number: event.pageIndex,
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
            empty: true,
          });
        }),
      )
      .subscribe((page) => {
        this.dataSource.data = page.content;
        Object.assign(this.allSubjectsPageData, {
          size: page.size,
          totalElements: page.totalElements,
          number: page.number,
          content: page.content,
          totalPages: page.totalPages,
          last: page.last,
          first: page.first,
          numberOfElements: page.numberOfElements,
          empty: page.empty,
        });
        this.isLoadingAllSubjects.set(false);
      });
  }

  ngOnDestroy() {
    this._destroy$.next();
    this._destroy$.complete();
  }

  navigateToSubjectDetail(code: string) {
    this.router.navigate(['/subjects/' + code]);
  }

  getSimilarSubjects() {
    this.isLoadingRecommendetSubjects.set(true);

    this.subjectService
      .getSimilarSubjects(this._selectedSubjects())
      .pipe(
        tap((subjects: SubjectDto[]) => {
          // Update signal with recommended subjects
          this._recommendedSubjects.set(subjects);
        }),
        finalize(() => {
          this.isLoadingRecommendetSubjects.set(false);
          // Move to next step after loading is complete
          setTimeout(() => {
            if (this.stepper) {
              this.stepper.next();
            }
          }, 100);
        }),
        takeUntil(this._destroy$),
      )
      .subscribe();
  }

  onSelectedSubjectsChanged($event: SubjectDto[]) {
    this._selectedSubjects.set($event as SubjectExtendedDto[]);
  }
}
