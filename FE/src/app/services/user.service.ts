import {inject, Injectable} from '@angular/core';
import { JwtHelperService } from '@auth0/angular-jwt';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable, take } from 'rxjs';
import { Role, UserDto } from '../types';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  get userData(): UserDto {
    const value = this._userData.getValue();
    if (!value) {
      throw new Error('User data is not available');
    }

    return value;
  }

  userId: number | undefined;

  private readonly _userData: BehaviorSubject<UserDto | undefined> = new BehaviorSubject<UserDto | undefined>(undefined);
  private readonly BE_URL = `${environment.API_URL}/user`;

  private readonly http = inject(HttpClient);
  public jwtHelper = inject(JwtHelperService);

  constructor() {
    this.loadUserData();
  }

  public loadUserData() {
    this.loadUserInfo()
      .pipe(take(1))
      .subscribe({
        next: (userData: UserDto) => {
          this._userData.next(userData);
        },
        error: () => {this._userData.next(undefined)}
      });
  }

  saveUserId(userId: number) {
    this.userId = userId;
  }

  loggedIn() {
    const expired = this.jwtHelper.isTokenExpired();
    return !expired
  }

  loadUserInfo(): Observable<UserDto> {
    return this.http.get<UserDto>(`${this.BE_URL}/profile`);
  }

  public getRoles(): Observable<Role[]> {
    return this.http.get<Role[]>(`${this.BE_URL}/roles`);
  }
}
