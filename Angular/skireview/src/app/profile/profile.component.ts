import { UserService } from './../user.service';
import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  updateUser: User = null;

  constructor(private userService: UserService) { }

  ngOnInit() {
  }

  update() {
    this.userService.update(this.updateUser).subscribe(
      updated => {
        console.log('Updated User: ' + updated );

      },
      err => {
        console.error(err);
         console.error('Error updating user');
      }
    );
  }

}
