import { UserService } from './../user.service';
import { AuthService } from './../auth.service';

import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { Router } from '@angular/router';

@Component ( {
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  newUser: User = new User();

  constructor(private router: Router,
    private authService: AuthService, private userService: UserService) { }

  ngOnInit() {
  }
// registers a new user (create)
  public register() {

    // use during auth service
    // this.authService.register(newUser).subscribe(
    // data => {
    //   this.router.navigateByUrl('home');
    // },
    // err => {
    //   console.error('Error creating new User');
    //   console.error(err);
    // }
    // );

    // this.newUser.active = true;
    // this.newUser.role = 'Standard';

    this.authService.register(this.newUser).subscribe(
      data => {
        console.log('inside register calling home nav');
        this.authService.login(this.newUser.username, this.newUser.password).subscribe(
          loggedin => {
            console.log(loggedin);
            this.router.navigateByUrl('home');
          }
        );

      },
      err => {
        console.error('Error creating new user');
        console.error(err);
      }
    );


  }

}
