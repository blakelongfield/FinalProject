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


  title = 'Admin';
  mainTitle = 'Admin';

  addMountain: Mountain = null;
  updateMountain: Mountain = null;
  mountain: Mountain = new Mountain();
  mountainList: Mountain[] = [];
  mountainToUpdate: Mountain = null;
  mountainToDelete: Mountain = null;
  deleteMountain: boolean = null;
  tempMountain = false;

  addTrail: Trail = null;
  updateTrail: Trail = null;
  trailList: Trail[] = [];
  trailToUpdate: Trail = null;
  deleteTrail: boolean = null;

  addResort: Resort = null;
  updateResort: Resort = null;
  resortList: Resort[] = [];
  resortToUpdate: Resort = null;
  deleteResort: boolean = null;


  constructor(
    private mountainService: MountainService,
    private trailService: TrailDetailsService,
    private resortService: ResortService
  ) { }

  ngOnInit() {
  }

  addMountainForm() {
    this.title = 'Add Mountain';
    this.addMountain = new Mountain();
    this.findAllResorts();
  }

  updateMountainForm() {
    this.title = 'Update Mountain';
    this.updateMountain = new Mountain();
    this.findAllMountains();
  }

  deleteMountainForm() {
    this.title = 'Delete Mountain';
    this.mountainToDelete = new Mountain();
    this.deleteMountain = true;
    this.findAllMountains();
  }

  addTrailForm() {
    this.title = 'Add Trail';
    this.addTrail = new Trail;
  }

  updateTrailForm() {
    this.title = 'Update Trail';
    this.updateTrail = new Trail();
    this.findAllTrails();
  }

  deleteTrailForm() {
    this.title = 'Delete Trail';
    this.deleteTrail = true;
  }

  addResortForm() {
    this.title = 'Add Resort';
    this.addResort = new Resort;
  }

  updateResortForm() {
    this.title = 'Update Resort';
    this.updateResort = new Resort();
    this.findAllResorts();
  }

  deleteResortForm() {
    this.title = 'Delete Resort';
    this.deleteResort = true;
  }

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

  cancelTrail() {
    this.title = this.mainTitle;
    this.addTrail = null;
    this.updateTrail = null;
    this.trailList = [];
    this.trailToUpdate = null;
    this.deleteTrail = null;
  }

  cancelResort() {
    this.addResort = null;
    this.updateResort = null;
    this.resortList = [];
    this.resortToUpdate = null;
    this.deleteResort = null;
  }

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

  submitUpdatedMountain() {
    this.updateMountain.id = this.mountainToUpdate.id;

    // console.log(this.updateMountain);
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

  findSingleMountain(mountainId: number) {
    console.log(mountainId);

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

  findSingleTrail(trailId: number) {
    console.log(trailId);
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

  submitUpdatedResort() {
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

  findSingleResort(resortId: number) {
    this.resortService.findResortById(resortId).subscribe(
      singleResort => {
        console.log(singleResort);
        this.resortToUpdate = singleResort;
      },
      error => {
        console.error('admin.findSingleResort(): Error finding Resort');
        console.error(error);
      }
    );
  }

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
