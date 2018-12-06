import { AuthService } from './../auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginUser: User = new User();

  constructor(private authService: AuthService, private router: Router) { }

  ngOnInit() {
  }

  login(loginUser: NgForm) {
    const user = loginUser.value;
    console.log(loginUser);
    this.authService.login(user.username, user.password).subscribe(
      loggedIn => {
        console.log(loggedIn);
      },
      error => {
        console.error('login.login(): Error logging in');
        console.error(error);
      }
    );
  }

}
