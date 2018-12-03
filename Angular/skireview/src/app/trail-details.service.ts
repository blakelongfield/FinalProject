import {catchError} from 'rxjs/internal/operators';
import { Injectable } from '@angular/core';
import { Trail } from './models/trail';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class TrailDetailsService {
  private trails: Trail[] = [];
  private url = environment.baseUrl + 'api/trails';
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json'
    })
  };

  constructor(private http: HttpClient) { }

  public index() {
    return this.http.get<Trail[]>(this.url).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.service index(): Error getting index');
      })
    );
  }

  public createTrail(trail: Trail) {
    return this.http.post<Trail>(this.url, trail).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.createTrail(): Error creating new trail');
      })
    );
  }

  public updateTrail(trail: Trail) {
    return this.http.put<Trail>(this.url, trail).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.updateTrail(): Error updating trail');
      })
    );
  }

  public deleteTrail(id: number) {
    return this.http.delete<Trail>(this.url).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.deleteTrail(): Error deleting trail');
      })
    );
  }


}
