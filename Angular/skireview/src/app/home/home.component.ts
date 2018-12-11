import { AuthService } from './../auth.service';
import { TrailDetailsService } from './../trail-details.service';
import { FormControl } from '@angular/forms';
import { MountainService } from './../mountain.service';
import { UserService } from './../user.service';

import { ReportService } from '../report.service';
import { Component, OnInit } from '@angular/core';
import { Report } from '../models/report';
import { User } from '../models/user';
import { Mountain } from '../models/mountain';

import { Router, ActivatedRoute } from '@angular/router';
import { Trail } from '../models/trail';
import { formArrayNameProvider } from '@angular/forms/src/directives/reactive_directives/form_group_name';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  // FIELDS

  reports: Report [] = [];
  mReports: Report [] = [];
  newReport = null;
  sortedTrails: Trail [] = [];
  users: User [] = [];
  mountains: Mountain [] = [];
  mountFormControl = new FormControl();
  selectedMTN: Mountain = null;
  mountain: Mountain = new Mountain();
  trailSelected = null;
  mtnId;
  searchBy;
  reverse = 1;
  reverse1 = 1;
  reverse2 = 1;
  showTrailMap = false;
  rating1 = 1;
  rating2 = 2;
  rating3 = 3;
  rating4 = 4;
  rating5 = 5;

  // FUNCTIONS
  // LOAD ALL REPORTS
  loadReports() {
    this.reportServ.index().subscribe(
      reports => {
        console.log('hiiiiasdfoasdf');
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
  //// REVRSE SORT BY LIST
  public reverseNameList() {

    if ( this.reverse === 1) {
      this.sortedTrails.reverse();
      this.reverse = 0;
    } else if ( this.reverse === 0 ) {
      this.sortedTrails.reverse();
      this.reverse = 1;
    }

  }
  public reverseDiffList() {

    if ( this.reverse1 === 1) {
      this.sortedTrails.reverse();
      this.reverse1 = 0;
    } else if ( this.reverse1 === 0 ) {
      this.sortedTrails.reverse();
      this.reverse1 = 1;
    }

  }
  public reverseFeatList() {

    if ( this.reverse2 === 1) {
      this.sortedTrails.reverse();
      this.reverse2 = 0;
    } else if ( this.reverse2 === 0 ) {
      this.sortedTrails.reverse();
      this.reverse2 = 1;
    }

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
    console.log('new mountaind id' + id);


    this.mtnServ.show(id).subscribe(
      mountain => {
      this.selectedMTN = mountain;
      console.log(mountain.averageAnnualSnowfall);
      console.log(this.selectedMTN.id + '&************');
      this.sortedTrails = this.selectedMTN.trails;
      },
      err => {
        console.error('Observer got error: ' + err);
      }
    );

    this.mountainReports(id);

  }
  //// SELECTS TRAIL AND MOVES TO TRAIL DETAIL PAGE
  public selectedTrail(id) {
    console.log('selected trail with id of' + id);
    this.trailServ.findTrailById(id).subscribe(
      data => {
        this.trailSelected = data;
        console.log(data + ' %%%%%%%%%%%%%%%%%%%%%%%%');
        this.route.navigateByUrl('/trail/' + id);
      },
      err => {
        console.log('ERROR in home.component selectedTrail()');
      }
    );
  }
  //// SORTS TRAILS BY TRAIL NAME
  public sortTrailByName( search ) {
    console.log( this.searchBy);
    console.log('SEARCH*******------' + search);
    this.trailServ.sortTrailByName( search, this.mtnId ).subscribe(
      trails => {
        this.sortedTrails = trails;
      },
      err => {
        console.log('ERROR in sorted trails');
      }
    );
    }
    //// OPEN REPORT TEXT BOX, NEWREPORT TO NOT NULL
    public reportToNotNUll() {
      this.newReport = new Report();
    }

    //// CREATE NEW REPORT ON MTN
    public createReportOnMTN() {

      console.log('***** REPORT *****' + this.newReport);
      console.log(this.mtnId);
      this.reportServ.createReportMountain(this.newReport, this.mtnId).subscribe(
        data => {
          console.log('***** REPORT *****' + this.newReport);
          console.log(this.mtnId);
          this.mReports.push(this.newReport);
          this.mountainReports(this.mtnId);
        },
        err => {
          console.log(this.newReport);
          console.log(this.mtnId);
          console.error('ERROR on creating report on MTN');
          console.log(err);
        }

      );
        this.rating1 = 1;
        this.rating2 = 2;
        this.rating3 = 3;
        this.rating4 = 4;
        this.rating5 = 5;

      this.newReport = null;
    }

    // RATING SYSTEM
    public ratingsubmit1() {
      if ( this.rating1 === 1 ) {
        this.rating1 = 0;
          console.log(1);
          this.newReport.rating = 1;
      } else {
        this.rating2 = 2;
        this.rating3 = 3;
        this.rating4 = 4;
        this.rating5 = 5;
        this.newReport.rating = 1;
        console.log(1);
      }
    }
    public ratingsubmit2 () {
      if ( this.rating2 === 2 ) {
        this.rating1 = 0;
        this.rating2 = 0;
        this.newReport.rating = 2;

          console.log(2);
      } else {
        this.rating3 = 3;
        this.rating4 = 4;
        this.rating5 = 5;
        this.newReport.rating = 2;
        console.log(2);
      }
    }
    public ratingsubmit3 () {
      if ( this.rating3 === 3 ) {
        this.rating1 = 0;
        this.rating2 = 0;
        this.rating3 = 0;
        this.newReport.rating = 3;
          console.log(3);
      } else {
        this.rating4 = 4;
        this.rating5 = 5;
        this.newReport.rating = 3;
        console.log(3);
      }
    }
    public ratingsubmit4 () {
      if ( this.rating4 === 4 ) {
        this.rating1 = 0;
        this.rating2 = 0;
        this.rating3 = 0;
        this.rating4 = 0;
        this.newReport.rating = 4;
          console.log(4);
      } else {
        this.rating5 = 5;
        this.newReport.rating = 4;
        console.log(4);
      }
    }
    public ratingsubmit5 () {
      if ( this.rating5 === 5 ) {
        this.rating1 = 0;
        this.rating2 = 0;
        this.rating3 = 0;
        this.rating4 = 0;
        this.rating5 = 0;
        this.newReport.rating = 5;
          console.log(5);
      }
    }


    checkLogin() {
      return this.authService.checkLogin();
    }












  // CONSTRUCTOR & INIT

  // tslint:disable-next-line:max-line-length
  constructor(
    private reportServ: ReportService,
    private userServ: UserService,
    private mtnServ: MountainService,
    private trailServ: TrailDetailsService,
    private route: Router,
    private repotServ: ReportService,
    private authService: AuthService,
    private activeRouter: ActivatedRoute
    ) { }

  ngOnInit() {
    this.mtnId = this.activeRouter.snapshot.paramMap.get('id');
    this.selectMountain( this.mtnId);
    this.loadReports();
    this.loadUsers();
    this.loadMountains();
  }

  public showMap() {
    if (this.selectedMTN.id === 1) {
  window.open('https://skimap.org/data/513/2200/1533603005.jpg', '_blank');
    }
    if (this.selectedMTN.id === 2) {
      window.open('https://images.ski.com/docs/trail-maps/vail-frontside_trail-map.pdf', '_blank');
    }

  //   if (this.showTrailMap === true) {
  //   this.showTrailMap = false;
  // } else if ( this.showTrailMap === false) {
  //   this.showTrailMap = true;
  // }

  }

}

