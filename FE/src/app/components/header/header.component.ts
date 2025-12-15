import { Component, computed, effect, inject, ViewChild } from '@angular/core';
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
import { filter } from 'rxjs';
import { FormDataService } from '@services/form-data.service';
import { toSignal } from '@angular/core/rxjs-interop';

interface MenuItem {
  label: string;
  icon: string;
  route: string;
  action?: () => void;
}

interface MenuGroup {
  label: string;
  icon: string;
  items: MenuItem[];
}

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
    MatMenu,
    MatMenuItem,
    MatMenuTrigger,
    MatExpansionPanel,
    MatExpansionPanelTitle,
    MatExpansionPanelHeader,
    HasRoleDirective,
  ],
})
export class HeaderComponent {
  readonly AuthRole = AuthRole;
  @ViewChild('drawer') drawer!: MatSidenav;

  readonly userService = inject(UserService);
  protected readonly authService = inject(AuthService);
  private readonly router = inject(Router);
  private readonly notificationService = inject(NotificationService);
  private readonly formDataService = inject(FormDataService);

  // Signals
  readonly formData = toSignal(this.formDataService.formData$);
  readonly loggedIn = this.userService.loggedIn;

  // Computed signals
  readonly canAccessSubjects = computed(
    () =>
      !!this.formData() ||
      this.authService.hasRole([AuthRole.ADMIN, AuthRole.TEACHER]),
  );

  readonly canAccessReports = computed(
    () =>
      !!this.formData() ||
      this.authService.hasRole([
        AuthRole.VEDENIE,
        AuthRole.ADMIN,
        AuthRole.TEACHER,
      ]),
  );

  readonly userInitial = computed(() => {
    const userData = this.userService.userData();
    return userData?.firstName.at(0)?.toUpperCase() ?? '';
  });

  // Menu configuration
  readonly subjectMenuItems: MenuItem[] = [
    { label: 'Prehľad predmetov', icon: 'list_view', route: 'subjects' },
    { label: 'Zaujímavé predmety', icon: 'interests', route: 'recommendation' },
    { label: 'Podobné predmety', icon: 'bubble_chart', route: 'clustering' },
    {
      label: 'Predikcia absolvovania',
      icon: 'check_circle',
      route: 'passing-prediction',
    },
  ];

  readonly reportMenuItems: MenuItem[] = [
    {
      label: 'Predmety podľa známok',
      icon: 'summarize',
      route: 'subject-reports',
    },
    {
      label: 'Korelačná analýza známok',
      icon: 'query_stats',
      route: 'subjects-grades-correlation',
    },
    { label: 'Reporty údajov', icon: 'analytics', route: 'data-report' },
    { label: 'Kľúčové slová', icon: 'vpn_key', route: 'keywords' },
  ];

  readonly userMenuItems: MenuItem[] = [
    { label: 'Profil', icon: 'account_circle', route: 'profile' },
    {
      label: 'Odhlásiť sa',
      icon: 'logout',
      route: '',
      action: () => this.logOut(),
    },
  ];

  readonly menuGroups: MenuGroup[] = [
    {
      label: 'Predmety',
      icon: 'book',
      items: this.subjectMenuItems,
    },
    {
      label: 'Analýzy a Reporty',
      icon: 'bar_chart',
      items: this.reportMenuItems,
    },
  ];

  constructor() {
    // Fetch form data on init
    this.formDataService.fetchFormData();

    // Auto-close drawer on navigation
    effect(
      () => {
        this.router.events
          .pipe(filter((event) => event instanceof NavigationEnd))
          .subscribe(() => {
            if (this.drawer?.opened) {
              this.drawer.close();
            }
          });
      },
      { allowSignalWrites: false },
    );
  }

  logOut() {
    this.authService.logOut().then(() => {
      this.router.navigate(['login']);
    });
  }

  navigate(route: string) {
    this.router.navigate([route]);
  }

  navigateToHome() {
    this.router.navigate(['home']);
  }

  navigateToAdminPage() {
    this.router.navigate(['admin-page']);
  }

  openDrawer() {
    this.drawer.toggle();
    this.notificationService.hideSnackbar();
  }

  handleMenuItemClick(item: MenuItem) {
    if (item.action) {
      item.action();
    } else {
      this.navigate(item.route);
    }
  }
}
