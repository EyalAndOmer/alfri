import { Component, inject, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { UserService } from '@services/user.service';

import { AuthService } from '@services/auth.service';
import { MatFormField, MatLabel } from '@angular/material/form-field';
import { MatInput } from '@angular/material/input';
import { MatButton } from '@angular/material/button';
import { NotificationService } from '@services/notification.service';
import { Router } from '@angular/router';
import { UserFormResultsComponent } from '@components/user-form-results/user-form-results.component';
import { USER_FORM_ID } from '@pages/home/home.component';
import { FormService } from '@services/form.service';
import { HasRoleDirective } from '@directives/auth.directive';
import { AnsweredForm, ChangePasswordDto, UserDto } from '../../types';
import { AuthRole } from '@enums/auth-role';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  standalone: true,
  imports: [
    ReactiveFormsModule,
    MatLabel,
    MatFormField,
    MatInput,
    MatButton,
    UserFormResultsComponent,
    HasRoleDirective
],
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  protected readonly AuthRole = AuthRole;
  formData: AnsweredForm | undefined;
  _userData: UserDto | undefined;
  isLoading = true;
  profileForm: FormGroup;

  private readonly formBuilder = inject(FormBuilder);
  readonly userService = inject(UserService);
  private readonly authService = inject(AuthService);
  private readonly notificationService = inject(NotificationService);
  private readonly router = inject(Router);
  private readonly formService =inject(FormService);
  constructor(
  ) {
    this.profileForm = this.formBuilder.group({
      currentPassword: ['', Validators.required],
      newPassword: ['', Validators.required],
      confirmNewPassword: ['', Validators.required],
    });
  }

  ngOnInit() {
    if (this.authService.hasRole([AuthRole.STUDENT])) {
      this.formService.getExistingFormAnswers(USER_FORM_ID).subscribe({
        next: (data: AnsweredForm) => {
          this.formData = data;
        },
        error: () => {},
      });
    }
  }

  mustMatch(controlName: string, matchingControlName: string) {
    return (formGroup: FormGroup) => {
      const control = formGroup.controls[controlName];
      const matchingControl = formGroup.controls[matchingControlName];

      if (matchingControl.errors && !matchingControl.errors['mustMatch']) {
        return;
      }

      if (control.value !== matchingControl.value) {
        matchingControl.setErrors({ mustMatch: true });
      } else {
        matchingControl.setErrors(null);
      }
    };
  }

  changePassword() {
    if (this.profileForm.valid) {
      const passwordData: ChangePasswordDto = {
        email: this.userService.userData.email,
        oldPassword: this.profileForm.value.currentPassword,
        newPassword: this.profileForm.value.newPassword,
      };
      this.authService.changePassword(passwordData).subscribe();
      this.profileForm.reset();
      this.notificationService.showError(
        'Heslo bolo úspešne zmenené!',
        '',
        3000,
      );
      this.router.navigate(['/home']);
    }
  }

  redirectToUserForm() {
    this.router.navigate(['/grade-form']);
  }

  get userData(): UserDto {
    return <UserDto>this._userData;
  }
}
