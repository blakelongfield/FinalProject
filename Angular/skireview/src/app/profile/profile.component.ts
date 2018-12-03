import { Router } from '@angular/router';
import { UserService } from './../user.service';
import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  updateUser: User = null;
  user = new User();
  selected = null;
  editedUser: User = null;


  constructor(private userService: UserService, private router: Router) { }

  ngOnInit() {
    this.userById();
  }



userById() {
  // HArded coded user ID with 1
  this.userService.showById('1').subscribe(
    data => {
      this.user = data;
      console.log(data);
    },
    err => {
      console.error(err);
      return throwError('Unable to load User');
    }
  );
}

  update() {
    console.log('Inside component update');
console.log(this.editedUser);

    console.log(this.updateUser);
    this.userService.update(this.editedUser).subscribe(

      updated => {
        console.log('Updated User: ' + this.editedUser );
        this.router.navigateByUrl('home');

      },
      err => {
        console.error(err);
         console.error('Error updating user');
      }
    );
  }

  cancel () {
    this.updateUser = null;
  }

  selectedUser(user) {
    this.selected = user;
  }

  editUser() {
    this.editedUser = new User();
  }

}
