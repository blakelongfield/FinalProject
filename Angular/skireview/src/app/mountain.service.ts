import { AuthService } from './auth.service';
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

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/mountains';
  private adminUrl = this.baseUrl + 'api/admin/mountains';
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json',
      'Authorization': `Basic ${this.authService.getToken()}`,
      'X-Requested-With': 'XMLHttpRequest'
    })
  };

  constructor(private http: HttpClient, private authService: AuthService) { }

  public index() {
    return this.http.get<Mountain[]>(this.url).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.index(): Error getting index');
      })
    );
  }

  public show(mountainId: number) {
    return this.http.get<Mountain>(this.url + `/${mountainId}`).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.show(): Error getting mountain');
      })
    );
  }

  public create(mountain: Mountain) {
    return this.http.post<Mountain>(this.adminUrl + `/resorts/${mountain.resort}`, mountain, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.create(): Error creating mountain');
      })
    );
  }

  public patch(patch: Mountain) {
    return this.http.patch<Mountain>(this.adminUrl + `/${patch.id}`, patch, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.patch(): Error patching mountain');
      })
    );
  }

  public disable(id: number) {
    return this.http.delete(this.adminUrl + `/disable/${id}`).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.disable(): Error disabling mountain');
      })
    );
  }

  public delete(id: number) {
    return this.http.delete(this.adminUrl  + `/${id}`).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('mountainService.delete(): Error deleting mountain');
      })
    );
  }

}
