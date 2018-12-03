import { Component, OnInit } from '@angular/core';
import { TrailDetailsService } from '../trail-details.service';
import { Trail } from '../models/trail';

@Component({
  selector: 'app-trail-details',
  templateUrl: './trail-details.component.html',
  styleUrls: ['./trail-details.component.css']
})
export class TrailDetailsComponent implements OnInit {
  newTrail = null;
  editTrail = null;
  trails: Trail[] = [];

  constructor(private trailDetailsService: TrailDetailsService) { }

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

  public update() {
    this.trailDetailsService.updateTrail(this.editTrail).subscribe(
      data => {
        this.reload();
        this.editTrail = null;
      },
      err => {
        console.error('trail-details.component.update(): Error updating trail');
        console.log(err);
      }
    );
  }

  public delete(trailId) {
    this.trailDetailsService.deleteTrail(trailId).subscribe(
      data => {
        console.log('deleted');
        this.reload();
      },
      err => {
        console.error('trail-details.component.delete(): Error deleteing trail');
        console.log(err);
      }
    );
  }

  public displayTrail() {

  }

}
