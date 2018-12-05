import {throwError} from 'rxjs';
import {catchError} from 'rxjs/internal/operators';
import {HttpHeaders, HttpClient} from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Report } from './models/report';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ReportService {


  //// FIELDS

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/reports';

  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type':  'application/json'

    })
  };
  constructor(private http: HttpClient) { }

  //// FUNCTIONS
    //// GRAB ALL REPORTS
  public index() {
    return this.http.get<Report[]>(this.url)
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('COULD NOT GET REPORT LIST');
      })
    );
  }
    //// GET REPORTS BY USER ID
    public findReportsByUserId(id) {
      return this.http.get<Report[]>(this.url + '/user/' + id)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('COULD NOT FIND USER REPORT LIST');
        })
      );

    }

    /// GET REPORTS BY MOUNTAIN ID
    public findReportsByMTNId( id ) {
      return this.http.get<Report[]>(this.url + '/mountains/' + id)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('COULD NOT FIND MTN REPORT LIST');
        })
      );
    }

    /// GET REPORTS BY TRAIL ID
    public findReportsByTrailId( id ) {
      return this.http.get<Report[]>(this.url + '/trails/' + id)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('COULD NOT FIND TRAIL REPORT LIST');
        })
      );
    }

     /// GET REPORT BY  ID
     public findReportById( id ) {
      return this.http.get<Report>(this.url + '/' + id)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('COULD NOT FIND  REPORT ');
        })
      );
    }

    //// CREATE NEW REPORT ON A TRAIL
    public createReportTrail(report: Report, trailId ) {
      console.log('ReportService createReport(): report= ' + report);
      console.log('ReportService createReport(): trailId = ' + trailId);
      return this.http.post<Report>(this.url + '/trails/' + trailId, report, this.httpOptions)
      .pipe(catchError((err: any) => {
        console.log(err);
        return throwError('COULD NOT CREATE TRAIL REPORT');
        })
      );
    }

    //// CREATE NEW REPORT ON A MTN
    public createReportMountain(report: Report, mtnId ) {

      return this.http.post<Report>(this.url + '/trails/' + mtnId, report, this.httpOptions)
      .pipe(catchError((err: any) => {
        console.log(err);
        return throwError('COULD NOT CREATE MOUNTAIN REPORT');
        })
      );
    }

     //// UPDATE REPORT
     public updateReport(report: Report, rId ) {

      return this.http.post<Report>(this.url + '/' + rId, report, this.httpOptions)
      .pipe(catchError((err: any) => {
        console.log(err);
        return throwError('COULD NOT UPDATE REPORT');
        })
      );
    }

    //// DELETE REPORT
    public delete ( id ) {
      return this.http.delete<Report>( this.url + '/' + id)
      .pipe(
        catchError((err: any) => {
        console.log(err);
        return throwError('DID NOT DELETE REPORT');
        })
      );
    }

}
