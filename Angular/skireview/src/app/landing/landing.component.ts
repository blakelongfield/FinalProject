import { Component, OnInit } from '@angular/core';
import { MountainService } from '../mountain.service';
import { Mountain } from '../models/mountain';
import { Report } from '../models/report';
import { ReportService } from '../report.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingComponent implements OnInit {

  mountains: Mountain[] = [];
  selectedMTN: Mountain = new Mountain();
  mtnId;
  reports: Report [] = [];

  constructor( private mtnServ: MountainService,
    private reportServ: ReportService, private route: Router ) { }

  ngOnInit() {
    this.loadMountains();
    this.loadReports();
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

}
