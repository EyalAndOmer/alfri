import {Component, inject, OnDestroy, OnInit} from '@angular/core';
import {
  catchError,
  Observable,
  of,
  Subject,
  takeUntil,
  tap,
} from 'rxjs';
import { SubjectService } from '@services/subject.service';
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
import { MatCard, MatCardContent } from '@angular/material/card';
import { MatTableDataSource } from '@angular/material/table';

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
  ],
  templateUrl: './subjects.component.html',
  styleUrls: ['./subjects.component.scss'],
})
export class SubjectsComponent implements OnInit, OnDestroy {
  private readonly _destroy$: Subject<void> = new Subject();
  public dataSource = new MatTableDataSource<SubjectDto>([]);
  private _studyPrograms$!: Observable<StudyProgramDto[]>;
  private _selectedStudyProgramId!: number;
  public filterForm: FormGroup;

  public readonly pageData: Page<SubjectDto> = {
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

  public isLoading = false;


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

    this.getSubjects(0, 10, this._selectedStudyProgramId);
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

  public studyProgramChanged() {
    this.isLoading = true;
    this.getSubjects(
      0,
      this.pageData.size,
      this._selectedStudyProgramId,
    );
  }

  public onPageChange(event: PageEvent) {
    this.isLoading = true;
    this.getSubjects(
      event.pageIndex,
      event.pageSize,
      this._selectedStudyProgramId,
    );
  }

  ngOnDestroy() {
    this._destroy$.next();
    this._destroy$.complete();
  }

  navigateToSubjectDetail(code: string) {
    this.router.navigate([code], { relativeTo: this.activatedRoute });
  }
}
