import {Component, inject, OnDestroy, OnInit} from '@angular/core';
import { Router } from '@angular/router';
import { HttpErrorResponse } from '@angular/common/http';
import { NotificationService } from '@services/notification.service';
import { StudentService } from '@services/student.service';
import { Observable, of, Subject } from 'rxjs';
import { catchError, switchMap, takeUntil, tap } from 'rxjs/operators';
import { SubjectsTableComponent } from '@components/subjects-table/subjects-table.component';
import { Page, StudyProgramDto, SubjectDto } from '../../types';
import { MatTableDataSource } from '@angular/material/table';
import {
  MatCard,
  MatCardHeader,
  MatCardSubtitle,
  MatCardTitle,
} from '@angular/material/card';
import { SubjectService } from '@services/subject.service';
import { PageEvent } from '@angular/material/paginator';

@Component({
  selector: 'app-recommendation',
  templateUrl: './recommendation.component.html',
  standalone: true,
  imports: [
    SubjectsTableComponent,
    MatCard,
    MatCardHeader,
    MatCardSubtitle,
    MatCardTitle,
  ],
  styleUrls: ['./recommendation.component.scss'],
})
export class RecommendationComponent implements OnInit, OnDestroy {
  private readonly _destroy$: Subject<void> = new Subject();

  readonly dataSource$ = new MatTableDataSource<SubjectDto>([]);


  public pageData: Page<SubjectDto> = {
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
      paged: true,
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
  };

  public isLoading = false;

  private readonly subjectService = inject(SubjectService);
  private readonly studentService = inject(StudentService);
  private readonly errorService = inject(NotificationService);
  private readonly router = inject(Router);

  ngOnInit() {
    this.init();
  }

  private init(): void {
    this.studentService
      .getStudyProgramOfCurrentUser()
      .pipe(
        switchMap((studyProgram: StudyProgramDto) => {
          // this._userStudyProgramId = studyProgram.id;
          return this.getSubjects();
        }),
        catchError((error: HttpErrorResponse) => {
          this.errorService.showError(error.error);
          return of([]);
        }),
      )
      .subscribe((page) => {
        if (Array.isArray(page)) {
          return;
        }

        this.dataSource$.data = page.content;
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
      });
  }

  private getSubjects(): Observable<Page<SubjectDto> | never []> {
    this.isLoading = true;
    return this.subjectService.getSubjectFocusPrediction(this.pageData.number, this.pageData.size).pipe(
      tap((page: Page<SubjectDto>) => {
        this.isLoading = false;
        return page;
      }),
      takeUntil(this._destroy$),
      catchError((error: HttpErrorResponse) => {
        this.isLoading = false;
        this.errorService.showError(error.error.detail);
        return of([]);
      }),
    );
  }

  ngOnDestroy() {
    this._destroy$.next();
    this._destroy$.complete();
  }

  public navigateToSubjectDetail(code: string) {
    this.router.navigate(['/subjects/' + code]);
  }

  public onPageChange(event: PageEvent): void {
    this.pageData.number = event.pageIndex;
    this.pageData.size = event.pageSize;

    this.getSubjects().subscribe((page) => {
      if (Array.isArray(page)) {
        return;
      }

      this.dataSource$.data = page.content;
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
    });
  }
}
