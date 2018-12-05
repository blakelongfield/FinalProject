import { Comment } from './models/comment';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Report } from './models/report';

@Injectable({
  providedIn: 'root'
})
export class CommentService {
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/comments';
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-type': 'application/json'
    })
  };

  constructor(private http: HttpClient) { }

  public index() {
    return this.http.get<Comment[]>(this.url).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('commentService.index(): Error getting index');
      })
    );
  }

  public findCommentsByReportId(id: number) {
    return this.http.get<Comment>(this.url + '/reports/' + id).pipe(
      catchError((error: any) => {
        console.log(error);
        return throwError('ERROR - trail-details.findCommentsByReportId(): Error finding comments on the report');
      })
    );
  }

  public show(id: number) {
    return this.http.get<Comment>(this.url + '/' + id).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('commentService.show(): Error getting comment');
      })
    );
  }

  public create(comment: Comment) {
    return this.http.post<Comment>(this.url + '/comments/' + comment.id, comment, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('commentService.create(): Error creating comment on a comment');
      })
    );
  }

  public createCommentOnReport(comment, reportId) {
    console.log(comment.commentText + 'comment in the commentService');
    console.log(reportId + 'reportID in the commentService');
    return this.http.post<Comment>(this.url + '/reports/' + reportId, comment, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('commentService.createCommentOnReport(): Error creating comment on report');
      })
    );
  }

  public put(comment: Comment) {
    return this.http.patch<Comment>(this.url + comment.id, comment, this.httpOptions).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('commentService.patch(): Error replacing comment');
      })
    );
  }

  public delete(id: number) {
    console.log(id);
    return this.http.delete(this.url + '/' + id).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError('commentService.delete(): Error deleting comment');
      })
    );
  }

}
