import { Component, OnInit } from '@angular/core';
import { TrailDetailsService } from '../trail-details.service';
import { Trail } from '../models/trail';
import { ReportService } from '../report.service';
import { Report } from '../models/report';
import { CommentService } from '../comment.service';
import { ActivatedRoute } from '@angular/router';
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
  selected = null;
  trails: Trail[] = [];
  reports: Report[] = [];
  comments: any = [];
  comment = null;
  newReport = new Report();
  newCommentOnReport = new Comment();
  commentHolder = new Comment();
  commentTextBox = false;
  reportIdHolder;
  trailId;
  reportId;
  votes = 0;

  // tslint:disable-next-line:max-line-length
  constructor(private trailDetailsService: TrailDetailsService, private reportService: ReportService, private commentService: CommentService, private activeRouter: ActivatedRoute) { }

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
               this.commentsOnReport(this.reports[i].id);
        }
      },
      err => {
        console.error('trail-details.component.reportsOnTrail(): Error retreiving reports on trail');
      }
    );
  }

  public commentsOnReport(id) {
    console.log(id);
    this.commentService.findCommentsByReportId(id).subscribe(
      data => {
        this.comments = data;
        console.log(this.comments);
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

  public createReportOnTrail() {
    this.trailId = this.activeRouter.snapshot.paramMap.get('id');
    this.reportService.createReportTrail(this.newReport, this.trailId).subscribe(
      data => {
        console.log('creating a report on a trail');
        this.ngOnInit();
      },
      err => {
        console.error('trail-details.component.createReportOnTrail(): Error creating report');
        console.error(err);
      }
    );
  }

  public createCommentOnReport() {
    console.log(this.newCommentOnReport);
    console.log(this.reportIdHolder);
    this.commentService.createCommentOnReport(this.newCommentOnReport, this.reportIdHolder).subscribe(
      data => {
        console.log('creating a comment on a report');
        this.ngOnInit();
      },
      err => {
        console.error('trail-details.component.createCommentOnReport(): Error creating a comment on a report');
        console.error(err);
      }
    );
  }

  public showTextBox(reportId) {
    this.commentTextBox = true;
    this.reportIdHolder = reportId;
  }

  public reportHelpful(report, reportId) {
    console.log(report);
    report.votes += 1;
    console.log('report Helpful?' + report.user.username);
    console.log('report helpful? ' + reportId);
    console.log(report.votes);
    this.reportService.updateReport(report, reportId).subscribe(
      data => {
        report.votes = data;
        console.log(report.vote);
        this.ngOnInit();
      },
      err => {
        console.error('Error in trail-details.component reportNotHelpful(): Error downvoting');
        console.error(err);
      }
    );
  }

  public reportNotHelpful(report, reportId) {
    report.votes -= 1;
    console.log('report not helpful?' + report.reportText);
    console.log('report not helpful?' + report.reportText);
    console.log(report.vote);
    this.reportService.updateReport(report, reportId).subscribe(
      data => {
        report.votes = data;
        this.ngOnInit();
      },
      err => {
        console.error('Error in trail-details.component reportNotHelpful(): Error downvoting');
        console.error(err);
      }
    );
  }
}
