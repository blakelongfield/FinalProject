import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { User } from './models/user';
import { environment } from 'src/environments/environment';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private url = environment.baseUrl + 'api/users';

  private users: User[] = [];

  constructor(private http: HttpClient) { }

  private httpOptions = {
    headers: new HttpHeaders ({
      'Content-Type' : 'application/json'
    })
  };

  // show all users
  index() {
return this.http.get<User[]>(this.url + '?sortedtrue')
.pipe(
  catchError((err: any) => {
    console.error(err);
    return throwError('Error listing users');
      })
    );
  }

// creates a new user

public create(user: User) {
  return this.http.post<User>(this.url, user, this.httpOptions)
  .pipe(
    catchError((err: any) => {
      console.error(err);
      return throwError('Error creating new user');
    })
  );
}
// updates a user
public update(user: User) {
  return this.http.patch<User>(this.url + '/' + user.id, user, this.httpOptions)
  .pipe(
    catchError((err: any) => {
      console.error(err);
      return throwError('Error updating user');
    })
  );
}

// deletes a user
public destroy(id: number) {
return this.http.delete(this.url + '/' + id, this.httpOptions )
  .pipe(
    catchError((err: any) => {
      console.error(err);
      return throwError('Error deleting user');
    })
  );
}



}
