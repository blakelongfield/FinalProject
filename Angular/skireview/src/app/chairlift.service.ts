import { AuthService } from './auth.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Chairlift } from './models/chairlift';

@Injectable({
  providedIn: 'root'
})
export class ChairliftService {
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/chairlifts';
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
      'Authorization': `Basic ${this.authService.getToken()}`,
      'X-Requested-With': 'XMLHttpRequest'
    })
  };

  constructor(private http: HttpClient, private authService: AuthService) { }

  public index() {
    console.log('this sucks');
    return this.http.get<Chairlift[]>(this.url).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('chairliftService.index(): Error getting index');
      })
    );
  }

  public show(id: number) {
    return this.http.get<Chairlift>(this.url + `/${id}`).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('chairliftService.show(): Error getting chairlift');
      })
    );
  }

  public create(chairlift: Chairlift) {
    return this.http.post<Chairlift>(this.url, chairlift, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('chairliftService.create(): Error creating chairlift');
      })
    );
  }

  public update(chairlift: Chairlift) {
    return this.http.patch<Chairlift>(this.url + chairlift.id, chairlift, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('chairliftService.update(): Error updating chairlift');
      })
    );
  }

  public delete(id: number) {
    return this.http.delete(this.url + `/${id}`).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('chairliftService.delete(): Error deleting chairlift');
      })
    );
  }
}
