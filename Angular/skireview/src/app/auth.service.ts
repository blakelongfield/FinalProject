import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { tap, catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private url = environment.baseUrl;

  constructor(private http: HttpClient) { }

  login(username, password) {
    // Make token
    const credentials = this.generateBasicAuthToken(username, password);
    // Send token as Authorization header (this is spring security convention for basic auth)
    const headers = new HttpHeaders()
      .set('Authorization', `Basic ${credentials}`);

    // create request to authenticate credentials
    return this.http
      .get(this.url + 'authenticate', {headers}).pipe(
        tap((res) => {
          localStorage.setItem('credentials' , credentials);
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
    return this.http.post(this.url + 'register', user)
    .pipe(
        tap((res) => {  // create a user and then upon success, log them in
          this.login(user.username, user.password);
        }),
        catchError((error: any) => {
          console.error(error);
          return throwError('authService.register(): Error registering');
        })
      );
  }

  logout() {
    localStorage.removeItem('credentials');
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
}
