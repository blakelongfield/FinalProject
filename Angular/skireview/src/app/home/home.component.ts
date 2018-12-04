import { FormControl } from '@angular/forms';
import { MountainService } from './../mountain.service';
import { UserService } from './../user.service';

import { ReportService } from '../report.service';
import { Component, OnInit } from '@angular/core';
import { Report } from '../models/report';
import { User } from '../models/user';
import { Mountain } from '../models/mountain';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  // FIELDS

  reports: Report [] = [];
  mReports: Report [] = [];
  users: User [] = [];
  mountains: Mountain [] = [];
  mountFormControl = new FormControl();
  selectedMTN: Mountain = null;
  mountain: Mountain = new Mountain();
  mtnId;





  // FUNCTIONS
  // LOAD ALL REPORTS
  loadReports() {
    this.reportServ.index().subscribe(
      reports => {
        this.reports = reports;
      },
      err => {
        console.error('Observer got error: ' + err);
      }
    );
  }

  // GET REPORTS BY MOUNTAIN ID
  mountainReports( id ) {
    this.reportServ.findReportsByMTNId( id ).subscribe(
      reports => {
        this.mReports = reports;
      },
      err => {
        console.error('Observer got error: ' + err);
      }
    );
  }

  // LOAD ALL USERS
  loadUsers() {
    this.userServ.index().subscribe(
      users => {
        this.users = users;
      },
      err => {
        console.error('Observer got error: ' + err);
      }
    );
  }

  // LOAD ALL MOUNTAINS
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

  // SELECT MOUTAIN AND SHOW REPORTS
  selectMountain( id ) {
    console.log(id);


    this.mtnServ.show(id).subscribe(
      mountain => {
      this.selectedMTN = mountain;
      },
      err => {
        console.error('Observer got error: ' + err);
      }
    );
    this.mountainReports(id);

  }









  // CONSTRUCTOR & INIT

  constructor(private reportServ: ReportService, private userServ: UserService, private mtnServ: MountainService) { }

  ngOnInit() {
    this.loadReports();
    this.loadUsers();
    this.loadMountains();

  }

}
