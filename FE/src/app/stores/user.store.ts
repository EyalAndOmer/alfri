import { computed, inject } from '@angular/core';
import {
  patchState,
  signalStore,
  withComputed,
  withMethods,
  withState,
} from '@ngrx/signals';
import { rxMethod } from '@ngrx/signals/rxjs-interop';
import { HttpClient } from '@angular/common/http';
import { JwtHelperService } from '@auth0/angular-jwt';
import { pipe, switchMap, tap } from 'rxjs';
import { Role, UserDto } from '../types';
import { environment } from '../../environments/environment';

type UserState = {
  userData: UserDto | undefined;
  userId: number | undefined;
  isLoading: boolean;
};

const initialState: UserState = {
  userData: undefined,
  userId: undefined,
  isLoading: false,
};

export const UserStore = signalStore(
  { providedIn: 'root' },
  withState(initialState),
  withComputed(() => {
    const jwtHelper = inject(JwtHelperService);

    return {
      loggedIn: computed(() => !jwtHelper.isTokenExpired()),
    };
  }),
  withMethods((store) => {
    const http = inject(HttpClient);
    const BE_URL = `${environment.API_URL}/user`;

    return {
      loadUserData: rxMethod<void>(
        pipe(
          tap(() => patchState(store, { isLoading: true })),
          switchMap(() =>
            http.get<UserDto>(`${BE_URL}/profile`).pipe(
              tap({
                next: (userData: UserDto) =>
                  patchState(store, { userData, isLoading: false }),
                error: () =>
                  patchState(store, { userData: undefined, isLoading: false }),
              }),
            ),
          ),
        ),
      ),
      loadUserInfo: () => {
        return http.get<UserDto>(`${BE_URL}/profile`);
      },
      getRoles: () => {
        return http.get<Role[]>(`${BE_URL}/roles`);
      },
      saveUserId: (userId: number) => {
        patchState(store, { userId });
      },
      setUserData: (userData: UserDto | undefined) => {
        patchState(store, { userData });
      },
      clearUserData: () => {
        patchState(store, { userData: undefined, userId: undefined });
      },
    };
  }),
);
