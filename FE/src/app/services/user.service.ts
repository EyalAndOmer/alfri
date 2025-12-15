import { inject, Injectable, signal } from '@angular/core';
import { JwtHelperService } from '@auth0/angular-jwt';
import { HttpClient } from '@angular/common/http';
import { Observable, take } from 'rxjs';
import { Role, UserDto } from '../types';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  readonly userData = signal<UserDto | undefined>(undefined);

  userId: number | undefined;

  private readonly BE_URL = `${environment.API_URL}/user`;

  private readonly http = inject(HttpClient);
  public readonly jwtHelper = inject(JwtHelperService);
  constructor() {
    this.loadUserData();
  }

  public loadUserData() {
    this.loadUserInfo()
      .pipe(take(1))
      .subscribe({
        next: (userData: UserDto) => {
          this.userData.set(userData);
        },
        error: () => {
          this.userData.set(undefined);
        },
      });
  }

  saveUserId(userId: number) {
    this.userId = userId;
  }

  loggedIn = () => {
    const expired = this.jwtHelper.isTokenExpired();
    return !expired;
  };

  loadUserInfo(): Observable<UserDto> {
    return this.http.get<UserDto>(`${this.BE_URL}/profile`);
  }

  public getRoles(): Observable<Role[]> {
    return this.http.get<Role[]>(`${this.BE_URL}/roles`);
  }
}
