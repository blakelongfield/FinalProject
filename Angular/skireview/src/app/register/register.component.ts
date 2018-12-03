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
    private authService: AuthService) { }

  ngOnInit() {
  }
// registers a new user (create)
  public register(newUser) {
    this.authService.register(newUser).subscribe(
    data => {
      this.router.navigateByUrl('home');
    },
    err => {
      console.error('Error creating new User');
      console.error(err);
    }
    );
  }

}
