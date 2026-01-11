import { Component, inject, OnInit } from '@angular/core';
import { MatButton } from '@angular/material/button';
import { NgOptimizedImage } from '@angular/common';
import { UserFormResultsComponent } from '@components/user-form-results/user-form-results.component';
import { USER_FORM_ID } from '../home.component';
import { Router } from '@angular/router';
import { FormService } from '@services/form.service';
import { AnsweredForm } from '../../../types';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { FormDataService } from '@services/form-data.service';
import { MatCard, MatCardContent, MatCardHeader } from '@angular/material/card';

@Component({
  selector: 'app-user-home',
  standalone: true,
  imports: [
    MatButton,
    NgOptimizedImage,
    UserFormResultsComponent,
    NgxSkeletonLoaderModule,
    MatCard,
    MatCardContent,
    MatCardHeader,
  ],
  templateUrl: './user-home.component.html',
  styleUrl: './user-home.component.scss',
})
export class UserHomeComponent implements OnInit {
  loading = true;
  formData: AnsweredForm | undefined;
  private readonly router = inject(Router);
  private readonly formService = inject(FormService);
  private readonly formDataService = inject(FormDataService);

  ngOnInit() {
    this.formService.getExistingFormAnswers(USER_FORM_ID).subscribe({
      next: (data: AnsweredForm) => {
        this.formDataService.setFormData(data);
        this.formData = data;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  redirectToUserForm() {
    this.router.navigate(['/grade-form']);
  }
}
