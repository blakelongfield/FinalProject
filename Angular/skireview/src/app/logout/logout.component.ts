import { HomeComponent } from './../home/home.component';
import { Router } from '@angular/router';
import { AuthService } from './../auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {

  constructor(
    private authService: AuthService,
    private router: Router,
    // private homeComponent: HomeComponent

    ) { }

  ngOnInit() {
  }

  public logout() {
    this.authService.logout();
    this.router.navigateByUrl('home');
  }

}
