import { forEach } from '@angular/router/src/utils/collection';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { tap, catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Authorities } from './models/authorities';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private url = environment.baseUrl;

  constructor(private http: HttpClient) { }

  login(username, password) {
    // Make token
    const credentials = this.generateBasicAuthToken(username, password);
    console.log(credentials);

    // Send token as Authorization header (this is spring security convention for basic auth)
    const headers = new HttpHeaders()
      .set('Authorization', `Basic ${credentials}`);
    console.log(headers);

    // create request to authenticate credentials
    return this.http.get<Authorities>(this.url + 'authenticate', {headers}).pipe(
        tap((res) => {
          console.log('login saving creds');
          console.log(res);
          console.log(res.authorities[0].authority);

          // this.findAdmin();
          localStorage.setItem('credentials' , credentials);
          if (res.authorities[0].authority === 'Admin' ||
          res.authorities[0].authority === 'ROLE_Admin' ) {
            localStorage.setItem('Admin', 'true');

          } else {
            localStorage.removeItem('Admin');
          }
          return res;
        }),
        catchError((err: any) => {
          console.log(err);
          return throwError('authService.login(): Error logging in');
        })
      );
  }

  register(user) {
    // create request to register a new account
    return this.http.post(this.url + 'register', user).pipe(
        tap((res) => {  // create a user and then upon success, log them in
          console.log('register calling login');

          // return this.login(user.username, user.password);
        }),
        catchError((error: any) => {
          console.error(error);
          return throwError('authService.register(): Error registering');
        })
      );
  }

  logout() {
    localStorage.removeItem('credentials');
    localStorage.removeItem('Admin');
  }

  checkLogin() {
    if (localStorage.getItem('credentials')) {
      return true;
    }
    return false;
  }

  generateBasicAuthToken(username, password) {
    return btoa(`${username}:${password}`);
  }

  getToken() {
    return localStorage.getItem('credentials');
  }


  checkAdmin() {
    if (localStorage.getItem('Admin')) {
      return true;
    }
    return false;
  }
}
