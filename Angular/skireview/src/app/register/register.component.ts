import { UserService } from './../user.service';
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

  constructor(private userService: UserService, private router: Router) { }

  ngOnInit() {
  }
// registers a new user (create)
  public register(newUser) {
    this.userService.create(newUser).subscribe(
    data => {
      this.router.navigateByUrl('blank');
    },
    err => {
      console.error('Error creating new User');
      console.error(err);
    }
    );
  }

}
