import { Comment } from './../models/comment';
import { Component, OnInit } from '@angular/core';
import { TrailDetailsService } from '../trail-details.service';
import { Trail } from '../models/trail';
import { ReportService } from '../report.service';
import { Report } from '../models/report';
import { CommentService } from '../comment.service';
import { ActivatedRoute, Router } from '@angular/router';
import { forEach } from '@angular/router/src/utils/collection';

@Component({
  selector: 'app-trail-details',
  templateUrl: './trail-details.component.html',
  styleUrls: ['./trail-details.component.css']
})
export class TrailDetailsComponent implements OnInit {
  trail = new Trail();
  newTrail = null;
  editTrail = null;
  selected = new Trail();
  trails: Trail[] = [];
  reports: Report[] = [];
  newReport = new Report();
  newReportValue = null;
  theReport =  null;
  newCommentOnReport = new Comment();
  newCommentValue = null;
  commentHolder = new Comment();
  commentTextBox = false;
  trailId;
  reportId;
  commentId;

  rating1 = 1;
  rating2 = 2;
  rating3 = 3;
  rating4 = 4;
  rating5 = 5;


  // tslint:disable-next-line:max-line-length
  constructor(private trailDetailsService: TrailDetailsService, private reportService: ReportService, private commentService: CommentService, private activeRouter: ActivatedRoute, private route: Router) { }

  ngOnInit() {
    this.trailId = this.activeRouter.snapshot.paramMap.get('id');
    this.reload();
    this.displayTrail(this.trailId);
    this.reportsOnTrail(this.trailId);

  }

  public reload() {
    this.trailDetailsService.index().subscribe(
      data => {
        this.trails = data;
       },
      err => {
        console.error('trail-details.component.reload(): Error retreiving trails');
        console.error(err);
      }
    );
  }

  public reportsOnTrail(id) {
    console.log(id);
    console.log(this.trailId);
    this.reportService.findReportsByTrailId(id).subscribe(
      data => {
        this.reports = data;
        console.log(this.reports[1].comment);
        for (let i = 0; i < this.reports.length; i++) {
               this.commentsOnReport(this.reports[i]);
        }
      },
      err => {
        console.error('trail-details.component.reportsOnTrail(): Error retreiving reports on trail');
      }
    );
  }

  public overallRating() {
    const ratingReports = this.reports;
    let counter = 0;
    let reportRating = 0;
    for (let i = 0; i < ratingReports.length; i++) {
      if (ratingReports[i].rating !== null) {
        counter += 1;
      }
        const overallRating = ratingReports[i].rating;
        reportRating = reportRating + overallRating;
    }
    reportRating = reportRating / counter;
    return reportRating;
  }

  public commentsOnReport(report: Report) {
    console.log(report.id);
    this.commentService.findCommentsByReportId(report.id).subscribe(
      results => {
        console.log('TrailDetailsComponent.commentsOnReport');
        console.log(results);
        report.comment = results;
      },
      err => {
        console.error('trail-details.component.commentsOnreport(): Error retreving comments on report');
      }
    );
  }

  public deleteComment(id) {
    this.commentService.delete(id).subscribe(
      data => {
      console.log('deleted');
      },
      err => {
        console.error('trail-details.component.deleteComment(): Error deleteing comment');
      }
    );
  }

  public deleteReport(id) {
    this.reportService.delete(id).subscribe(
      data => {
        console.log('deleted');
      },
      err => {
        console.error('trail-details.component.deleteReport(): Error deleting report');
      }
    );
  }

  public show(id) {
    this.trailDetailsService.findTrailById(id).subscribe(
      data => {
        this.trail = data;
        console.log(this.trail);
      },
      err => {
        console.error('trail-details.component.show(): Error retreiving trial by id');
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
        console.error(err);
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
        console.error(err);
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
        console.error(err);
      }
    );
  }

  public delete(trailId) {
    this.trailDetailsService.disableTrail(trailId).subscribe(
      data => {
        console.log('successfully deleted a trail');
        this.reload();
      },
      err => {
        console.error('trail-details.component.delete(): Error deleteing trail');
        console.error(err);
      }
    );
  }

  public displayTrail(id) {
    console.log(id);
    this.trailDetailsService.findTrailById(id).subscribe(
      data => {
        console.log('in displayTrail - finding trail by id');
        this.selected = data;
      }
    );
  }
// CREATE NEW REPORT ON TRAIL
  public createReportOnTrail() {
    this.trailId = this.activeRouter.snapshot.paramMap.get('id');
    console.log(this.newReport);
    console.log('FOO****' + this.newReport.votes);
    this.reportService.createReportTrail(this.newReport, this.trailId).subscribe(
      data => {
        console.log('creating a report on a trail');
        console.log(data);
        if (! data.comment) {
          data.comment = [];
        }
        this.reports.push(data);
        this.newReportValue = '';
      },
      err => {
        console.error('trail-details.component.createReportOnTrail(): Error creating report');
        console.error(err);
      }
    );
  }
// CREATE COMMENT ON A REPORT
  public createCommentOnReport() {
    this.commentService.createCommentOnReport(this.newCommentOnReport, this.theReport.id).subscribe(
      data => {
        this.theReport.comment.push(data);
        console.log('comment created');
        this.newCommentValue = '';

      },
      err => {
        console.error('trail-details.component.createCommentOnReport(): Error creating a comment on a report');
        console.error(err);
      }
    );
    this.selectAReport(this.theReport);
  }

  public showTextBox(reportId) {
    this.commentTextBox = true;
  }
    // DOWN VOTE -1
  public reportHelpful(report, reportId) {
    console.log(report);
    report.votes += 1;
    console.log('report Helpful?' + report.user.username);
    console.log('report helpful? ' + reportId);
    console.log(report.votes);
    this.reportService.updateReport(report, reportId).subscribe(
      data => {
        console.log(report.vote);
      },
      err => {
        console.error('Error in trail-details.component reportNotHelpful(): Error downvoting');
        console.error(err);
      }
    );
  }
    // UP VOTE +1
  public reportNotHelpful(report, reportId) {
    report.votes -= 1;
    console.log('report not helpful?' + report.reportText);
    console.log('report not helpful?' + report.reportText);
    console.log(report.votes);
    this.reportService.updateReport(report, reportId).subscribe(
      data => {
      },
      err => {
        console.error('Error in trail-details.component reportNotHelpful(): Error downvoting');
        console.error(err);
      }
    );
  }
  //// SELECT A REPORT AND SEE COMMENTS
  public selectAReport(report) {
    this.theReport = report;

    console.log( this.theReport.id );
    console.log( this.theReport );
    console.log(this.theReport.comment);
  }




  // RATING SYSTEM
  public ratingsubmit1() {
    if ( this.rating1 === 1 ) {
      this.rating1 = 0;
      this.newReport.rating = 1;
        console.log(1);

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

}


