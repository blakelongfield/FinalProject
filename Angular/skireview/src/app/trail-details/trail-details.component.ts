import { Component, OnInit } from '@angular/core';
import { TrailDetailsService } from '../trail-details.service';
import { Trail } from '../models/trail';
import { ReportService } from '../report.service';
import { Report } from '../models/report';
import { CommentService } from '../comment.service';

@Component({
  selector: 'app-trail-details',
  templateUrl: './trail-details.component.html',
  styleUrls: ['./trail-details.component.css']
})
export class TrailDetailsComponent implements OnInit {
  newTrail = null;
  editTrail = null;
  selected = null;
  trails: Trail[] = [];
  reports: Report[] = [];
  comments: Comment[] = [];

  // tslint:disable-next-line:max-line-length
  constructor(private trailDetailsService: TrailDetailsService, private reportService: ReportService, private commentService: CommentService) { }

  ngOnInit() {
    this.reload();
  }

  public reload() {
    this.trailDetailsService.index().subscribe(
      data => {
        this.trails = data;
       },
      err => {
        console.error('trail-details.component.reload(): Error retreiving trails');
        console.log(err);
      }
    );
  }

  public reportsOnTrail(id) {
    this.reportService.findReportsByTrailId(id).subscribe(
      data => {
        this.reports = data;
      },
      err => {
        console.error('trail-details.component.reportsOnTrail(): Error retreiving reports on trail');
      }
    );
  }

  public commentsOnReport(id) {
    this.commentService.findCommentsByReportId(id).subscribe(
      data => {
        console.log(data);
        console.log('***********************');
        this.comments = data;
      },
      err => {
        console.error('trail-details.component.commentsOnreport(): Error retreving comments on report');
      }
    );
  }

  public create(newTrail) {
    this.trailDetailsService.createTrail(this.newTrail).subscribe(
      data => {
        this.newTrail = new Trail();
        this.reload();
        console.log('successfully created a new trail');
      },
      err => {
        console.error('trail-details.component.create(): Error creating new trail');
        console.log(err);
      }
    );
  }

  public updatePut(id) {
    this.trailDetailsService.putTrail(this.editTrail).subscribe(
      data => {
        this.reload();
        this.editTrail = null;
        console.log('successfully updated(put) a trail');
      },
      err => {
        console.error('trail-details.component.updatePut(): Error updating trail');
        console.log(err);
      }
    );
  }

  public updatePatch() {
    this.trailDetailsService.patchTrail(this.editTrail).subscribe(
      data => {
        this.reload();
        this.editTrail = null;
        console.log('successfully updated(patch) a trail');
      },
      err => {
        console.error('trail-details.component.updatePatch(): Error updating trail');
        console.log(err);
      }
    );
  }

  public delete(trailId) {
    this.trailDetailsService.deleteTrail(trailId).subscribe(
      data => {
        console.log('successfully deleted a trail');
        this.reload();
      },
      err => {
        console.error('trail-details.component.delete(): Error deleteing trail');
        console.log(err);
      }
    );
  }

  public displayTrail(trail) {
    console.log('you are now viewing a specific trail');
    console.log('******************************************');
    this.selected = trail;
    console.log(this.selected);
    this.reportsOnTrail(trail.id);
  }
}
