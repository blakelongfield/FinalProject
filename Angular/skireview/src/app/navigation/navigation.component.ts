import { AuthService } from './../auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

  public isCollapsed = false;
  constructor(private authService: AuthService) { }

  ngOnInit() {
  }

  checkLogin() {


    return this.authService.checkLogin();
  }

  checkAdmin() {


    return this.authService.checkAdmin();
  }

}
