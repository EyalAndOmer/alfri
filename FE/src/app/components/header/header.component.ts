import { Component, OnInit, ViewChild } from '@angular/core';
import { NgIf } from '@angular/common';
import {Component, inject, OnInit, ViewChild} from '@angular/core';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenav, MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { UserService } from '@services/user.service';
import { AuthService } from '@services/auth.service';
import { NavigationEnd, Router } from '@angular/router';
import { MatMenu, MatMenuItem, MatMenuTrigger } from '@angular/material/menu';
import {
  MatExpansionPanel,
  MatExpansionPanelHeader,
  MatExpansionPanelTitle,
} from '@angular/material/expansion';
import { HasRoleDirective } from '@directives/auth.directive';
import { AuthRole } from '@enums/auth-role';
import { NotificationService } from '@services/notification.service';
import { filter, Subscription } from 'rxjs';
import { FormDataService } from '@services/form-data.service';
import { AnsweredForm } from '../../types';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrl: './header.component.scss',
  standalone: true,
  imports: [
    MatToolbarModule,
    MatButtonModule,
    MatSidenavModule,
    MatListModule,
    MatIconModule,
    NgIf,
    MatMenu,
    MatMenuItem,
    MatMenuTrigger,
    MatExpansionPanel,
    MatExpansionPanelTitle,
    MatExpansionPanelHeader,
    HasRoleDirective
],
})
export class HeaderComponent implements OnInit {
  readonly AuthRole = AuthRole;
  @ViewChild('drawer') drawer!: MatSidenav;
  routerSubscription!: Subscription;
  formData: AnsweredForm | undefined;

  constructor(
    readonly userService: UserService,
    protected readonly authService: AuthService,
    private readonly router: Router,
    private readonly notificationService: NotificationService,
    private readonly formDataService: FormDataService,
  ) {}
  private readonly userService = inject(UserService);
  protected readonly authService = inject(AuthService);
  private readonly router = inject(Router);
  private readonly notificationService = inject(NotificationService);
  private readonly formDataService = inject(FormDataService);

  ngOnInit() {
    // Subscribe to router events
    this.routerSubscription = this.router.events
      .pipe(filter((event) => event instanceof NavigationEnd)) // Listen only for NavigationEnd events
      .subscribe(() => {
        if (this.drawer?.opened) {
          this.drawer.close(); // Close the drawer if it's open
        }
      });

    this.formDataService.fetchFormData();
    this.formDataService.formData$.subscribe((data) => {
      this.formData = data;
    });
  }

  loggedIn() {
    return this.userService.loggedIn();
  }

  logOut() {
    this.authService.logOut().then(() => {
      this.router.navigate(['login']);
    });
  }

  navigateToSubjects() {
    this.router.navigate(['subjects']);
  }

  navigateToPrediction() {
    this.router.navigate(['recommendation']);
  }

  navigateToProfile() {
    this.router.navigate(['profile']);
  }

  navigateToHome() {
    this.router.navigate(['home']);
  }

  navigateToSubjectChances() {
    this.router.navigate(['subjects-chance']);
  }

  public navigateToSubjectsClustering() {
    this.router.navigate(['clustering']);
  }

  navigateToPassingPrediction() {
    this.router.navigate(['passing-prediction']);
  }

  navigateToSubjectsReports() {
    this.router.navigate(['subject-reports']);
  }

  navigateToSubjectGradeCorrelation() {
    this.router.navigate(['subjects-grades-correlation']);
  }

  navigateToAdminPage() {
    this.router.navigate(['admin-page']);
  }

  navigateToKeywords() {
    this.router.navigate(['keywords']);
  }

  openDrawer() {
    this.drawer.toggle();
    this.notificationService.hideSnackbar();
  }
}
