import { Injectable } from '@angular/core';
import { Resort } from './models/resort';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ResortService {
  private resorts: Resort[] = [];
  private url = environment.baseUrl + 'api/trails';
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json'
    })
  };

  constructor(private http: HttpClient) { }

  public index() {
    return this.http.get<Resort[]>(this.url).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - resort.service index(): Error getting index');
      })
    );
  }

  public findResortById(id: number) {
    return this.http.get<Resort>(this.url + '/' + id).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - resort.service findResortById(): Error finding a resort by ID');
      })
    );
  }

  public createResort(resort: Resort) {
    return this.http.post<Resort>(this.url, resort).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - resort.service createResort(): Error creating new resort');
      })
    );
  }

  public putResort(resort: Resort) {
    return this.http.put<Resort>(this.url + '/' + resort.id, resort).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - resort.service putResort(): Error updating resort');
      })
    );
  }

  public deleteResort(id: number) {
    return this.http.delete<Resort>(this.url).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - resort.service deleteResort(): Error deleting resort');
      })
    );
  }
}
