import { Mountain } from './models/mountain';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { Route } from '@angular/router';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MountainService {

  private url = environment.baseUrl + 'api/mountains';
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-type': 'application/json'
    })
  };

  constructor(private http: HttpClient, private router: Route) { }

  public index() {
    return this.http.get<Mountain[]>(this.url).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.index(): Error getting index');
      })
    );
  }

  public show() {
    return this.http.get<Mountain>(this.url).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.show(): Error getting mountain');
      })
    );
  }
  public create(mountain: Mountain) {
    return this.http.post<Mountain>(this.url, mountain, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.show(): Error getting mountain');
      })
    );
  }

}
