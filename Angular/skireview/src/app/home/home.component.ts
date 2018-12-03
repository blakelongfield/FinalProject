import { UserService } from './../user.service';

import { ReportService } from '../report.service';
import { Component, OnInit } from '@angular/core';
import { Report } from '../models/report';
import { User } from '../models/user';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  // FIELDS

  reports: Report [] = [];






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









  // CONSTRUCTOR & INIT

  constructor(private reportServ: ReportService, private userServ: UserService) { }

  ngOnInit() {
    this.loadReports();

  }

}
