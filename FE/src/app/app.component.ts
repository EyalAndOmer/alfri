import { Component, inject } from '@angular/core';
import { NavigationEnd, Router, RouterOutlet } from '@angular/router';
import { FooterComponent } from '@components/footer/footer.component';

import { HeaderComponent } from '@components/header/header.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, FooterComponent, HeaderComponent],
  templateUrl: './app.component.html',
})
export class AppComponent {
  title = 'Alfri';
  public showFooter = false;
  noFooterRoutes = ['login', 'register', '404'];

  private readonly router = inject(Router);
  constructor() {
    this.router.events.subscribe((event) => {
      if (event instanceof NavigationEnd) {
        this.showFooter = !this.noFooterRoutes.includes(
          event.url.split('/')[1],
        );
      }
    });
  }
}
