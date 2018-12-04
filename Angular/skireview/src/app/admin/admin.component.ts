import { TrailDetailsService } from './../trail-details.service';
import { MountainService } from './../mountain.service';
import { Mountain } from './../models/mountain';
import { Component, OnInit } from '@angular/core';
import { Trail } from '../models/trail';
import { ResortService } from '../resort.service';
import { Resort } from '../models/resort';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  // title information
  title = 'Admin';
  mainTitle = 'Admin';

  // mountain variables
  addMountain: Mountain = null;
  updateMountain: Mountain = null;
  mountain: Mountain = new Mountain();
  mountainList: Mountain[] = [];
  mountainToUpdate: Mountain = null;
  mountainToDelete: Mountain = null;
  deleteMountain: boolean = null;
  tempMountain = false;

  // trail variables
  addTrail: Trail = null;
  updateTrail: Trail = null;
  trailList: Trail[] = [];
  trailToUpdate: Trail = null;
  trailToDelete: Trail = null;
  deleteTrail: boolean = null;
  tempTrail = false;

  // resort variables
  addResort: Resort = null;
  updateResort: Resort = null;
  resortList: Resort[] = [];
  resortToUpdate: Resort = null;
  resortToDelete: Rerort = null;
  deleteResort: boolean = null;
  tempResort = false;

  // constructor
  constructor(
    private mountainService: MountainService,
    private trailService: TrailDetailsService,
    private resortService: ResortService
  ) { }

  // nothing happeing on init
  ngOnInit() {
  }

  // button click event that shows the add mountain form
  addMountainForm() {
    this.title = 'Add Mountain';
    this.addMountain = new Mountain();
    this.findAllResorts();
  }

  // button click event that shows the update mountain form
  updateMountainForm() {
    this.title = 'Update Mountain';
    this.updateMountain = new Mountain();
    this.findAllMountains();
  }

  // button click event that shows the delete mountain form
  deleteMountainForm() {
    this.title = 'Delete Mountain';
    this.mountainToDelete = new Mountain();
    this.deleteMountain = true;
    this.findAllMountains();
  }

  // button click event that shows the add trail form
  addTrailForm() {
    this.title = 'Add Trail';
    this.addTrail = new Trail;
  }

  // button click event that shows the update trail form
  updateTrailForm() {
    this.title = 'Update Trail';
    this.updateTrail = new Trail();
    this.findAllTrails();
  }

  // button click event that shows the delete trail form
  deleteTrailForm() {
    this.title = 'Delete Trail';
    this.deleteTrail = true;
  }

  // button click event that shows the add resort form
  addResortForm() {
    this.title = 'Add Resort';
    this.addResort = new Resort;
  }

  // button click event that shows the update resort form
  updateResortForm() {
    this.title = 'Update Resort';
    this.updateResort = new Resort();
    this.findAllResorts();
  }

  // button click event that shows the delete resort form
  deleteResortForm() {
    this.title = 'Delete Resort';
    this.deleteResort = true;
  }

  // button click event that returns back to initial buttons
  cancelMountain() {
    this.title = this.mainTitle;
    this.addMountain = null;
    this.updateMountain = null;
    this.mountainList = [];
    this.mountainToUpdate = null;
    this.deleteMountain = null;
    this.tempMountain = false;
    this.mountainToDelete = null;
  }
  // button click event that returns back to initial buttons
  cancelTrail() {
    this.title = this.mainTitle;
    this.addTrail = null;
    this.updateTrail = null;
    this.trailList = [];
    this.trailToUpdate = null;
    this.deleteTrail = null;
  }

  // button click event that returns back to initial buttons
  cancelResort() {
    this.title = this.mainTitle;
    this.addResort = null;
    this.updateResort = null;
    this.resortList = [];
    this.resortToUpdate = null;
    this.deleteResort = null;
    this.tempResort = false;
    this.resortToDelete = null;
  }

  // add new mountain
  submitNewMountain() {
    this.mountainService.create(this.addMountain).subscribe(
      created => {
        console.log(created);
        this.cancelMountain();
      },
      error => {
        console.error('admin.submitNewMountain(): Error creating Mountain');
        console.error(error);
      }
    );
  }

  // update mountain
  submitUpdatedMountain() {
    this.updateMountain.id = this.mountainToUpdate.id;
    this.mountainService.patch(this.updateMountain).subscribe(
      updated => {
        console.log(updated);
        this.cancelMountain();
      },
      error => {
        console.error('admin.submitUpdatedMountain(): Error updating Mountain');
        console.error(error);
      }
    );
  }

  // find add mountains
  findAllMountains() {
    this.mountainService.index().subscribe(
      mountainIndex => {
        console.log(mountainIndex);
        this.mountainList = mountainIndex;
      },
      error => {
        console.error('admin.findAllMountains(): Error finding all Mountains');
        console.error(error);
      }
    );
  }

  // find single mountain
  findSingleMountain(mountainId: number) {
    this.mountainService.show(mountainId).subscribe(
      singleMountain => {
        this.updateMountain = singleMountain;
        this.mountainToUpdate = singleMountain;
        this.tempMountain = true;
        console.log(singleMountain);
      },
      error => {
        console.error('admin.findSingleMountain(): Error finding Mountain');
        console.error(error);
      }
    );
  }

  // delete mountain
  submitDeleteMountain(deleteId: number) {
    this.mountainService.delete(deleteId).subscribe(
      deletedMountain => {
        console.log(deletedMountain);
        this.cancelMountain();
      },
      error => {
        console.error('admin.submitDeleteMountain(): Error deleting Mountain');
        console.error(error);
      }
    );
  }

  // add trail
  submitNewTrail() {
    this.trailService.createTrail(this.addTrail).subscribe(
      created => {
        console.log(created);
        this.cancelTrail();
      },
      error => {
        console.error('admin.submitNewTrail(): Error creating Trail');
        console.error(error);
      }
    );
  }

  // update trail
  submitUpdatedTrail() {
    this.trailService.patchTrail(this.updateTrail).subscribe(
      updated => {
        console.log(updated);
        this.cancelTrail();
      },
      error => {
        console.error('admin.submitUpdatedTrail(): Error updating Trail');
        console.error(error);
      }
    );
  }

  // find all trails
  findAllTrails() {
    this.trailService.index().subscribe(
      trailIndex => {
        console.log(trailIndex);
        this.trailList = trailIndex;
      },
      error => {
        console.error('admin.findAllTrails(): Error finding all Trails');
        console.error(error);
      }
    );
  }

  // find single trail
  findSingleTrail(trailId: number) {
    this.trailService.findTrailById(trailId).subscribe(
      singleTrail => {
        console.log(singleTrail);
        this.trailToUpdate = singleTrail;
      },
      error => {
        console.error('admin.findSingleTrail(): Error finding Trail');
        console.error(error);
      }
    );
  }

  // delete trail
  submitDeleteTrail(deleteId: number) {
    this.trailService.deleteTrail(deleteId).subscribe(
      deleteTrail => {
        console.log(deleteTrail);
        this.cancelTrail();
      },
      error => {
        console.error('admin.submitDeleteTrail(): Error deleting Trail');
        console.error(error);
      }
    );
  }

  // add resort
  submitNewResort() {
    this.resortService.createResort(this.addResort).subscribe(
      created => {
        console.log(created);
        this.cancelResort();
      },
      error => {
        console.error('admin.submitNewResort(): Error creating Resort');
        console.error(error);
      }
    );
  }

  // update resort
  submitUpdatedResort() {
    this.updateResort.id = this.resortToUpdate.id;
    this.resortService.putResort(this.updateResort).subscribe(
      updated => {
        console.log(updated);
        this.cancelResort();
      },
      error => {
        console.error('admin.submitUpdatedResort(): Error updating Resort');
        console.error(error);
      }
    );
  }

  // find all resorts
  findAllResorts() {
    this.resortService.index().subscribe(
      resortIndex => {
        console.log(resortIndex);
        this.resortList = resortIndex;
      },
      error => {
        console.error('admin.findAllResort(): Error finding all Resort');
        console.error(error);
      }
    );
  }

  // find single resort
  findSingleResort(resortId: number) {
    this.resortService.findResortById(resortId).subscribe(
      singleResort => {
        console.log(singleResort);
        this.updateResort = singleResort;
        this.resortToUpdate = singleResort;
        this.tempResort = true;
      },
      error => {
        console.error('admin.findSingleResort(): Error finding Resort');
        console.error(error);
      }
    );
  }

  // delete resort
  submitDeleteResort(deleteId: number) {
    this.resortService.deleteResort(deleteId).subscribe(
      deleteTrail => {
        console.log(deleteTrail);
        this.cancelResort();
      },
      error => {
        console.error('admin.submitDeleteResort(): Error deleting Resort');
        console.error(error);
      }
    );
  }

}
