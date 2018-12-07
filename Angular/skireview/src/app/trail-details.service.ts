import { AuthService } from './auth.service';
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
  private adminUrl = environment.baseUrl + 'api/admin/trails';

  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
      'Authorization': `Basic ${this.authService.getToken()}`,
      'X-Requested-With': 'XMLHttpRequest'
    })
  };

  constructor(private http: HttpClient, private authService: AuthService) { }

  public index() {
    return this.http.get<Trail[]>(this.url).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.service index(): Error getting index');
      })
    );
  }

  public findTrailById(id: number) {
    return this.http.get<Trail>(this.url + '/' + id).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.findTrailById(): Error finding a trail by ID');
      })
    );
  }

  public createTrail(trail: Trail) {
    console.log('Inside create trail');
    console.log(trail);
    console.log(this.adminUrl + `/mountains/${trail.mountain}`);
    console.log(this.httpOptions);

    return this.http.post<Trail>(this.adminUrl + `/mountains/${trail.mountain}`, trail, this.httpOptions).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.createTrail(): Error creating new trail');
      })
    );
  }

  public putTrail(trail: Trail) {
    return this.http.put<Trail>(this.adminUrl + '/' + trail.id, trail).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.putTrail(): Error updating trail');
      })
    );
  }

  public patchTrail(trail: Trail) {
    return this.http.put<Trail>(this.adminUrl + '/' + trail.id, trail).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.patchTrail(): Error updating trail');
      })
    );
  }


  public disableTrail(id: number) {
    return this.http.delete<Trail>(this.adminUrl + `/${id}`).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.deleteTrail(): Error deleting trail');
      })
    );
  }

  // SORT TRAIL BY TRAIL NAME
  public sortTrailByName( search, mid ) {
    return this.http.get<Trail[]>(this.url + '/sort/' + mid + '/' + search)
    .pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - COULD NOT GET SORTED TRAIL LIST');
      })
    );
  }


}
