import { MountainService } from './../mountain.service';
import { AuthService } from './../auth.service';
import { Component, OnInit } from '@angular/core';
import { Mountain } from '../models/mountain';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {
  mountains: Mountain[] = [];
  public isCollapsed = false;
  selectedMTN: Mountain = new Mountain();
  mtnId;


  constructor(private authService: AuthService, private mtnServ: MountainService, private route: Router) { }

  ngOnInit() {
    this.loadMountains();
  }

  checkLogin() {


    return this.authService.checkLogin();
  }

  checkAdmin() {


    return this.authService.checkAdmin();
  }

  loadMountains() {
    this.mtnServ.index().subscribe(
      mountains => {
        this.mountains = mountains;
      },
      err => {
        console.error('Observer got error: ' + err);
      }
    );

}

selectMountain( id ) {
  console.log(id);


  this.mtnServ.show(id).subscribe(
    mountain => {
    this.selectedMTN = mountain;
    this.route.navigateByUrl('/mountain/' + id);

    },
    err => {
      console.error('Observer got error: ' + err);
    }
  );

  }

}
