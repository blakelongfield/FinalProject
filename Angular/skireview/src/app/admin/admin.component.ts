import { Chairlift } from './../models/chairlift';
import { ChairliftService } from './../chairlift.service';
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

  /*
   * ----ORDER OF CODE----
   * VARIABLES
   * MOUNTAIN
   * TRAIL
   * RESORT
   * CHAIRLIFT
   *
   * --this code contains CRUD operations for an admin to perform on mountain, trail, resort, and chairlift
   * --deleting does not actually happen in the database but active is set to false instead
   */


  // title information
  title = 'Admin';
  mainTitle = 'Admin';

  /*
   * VARIABLES
   */

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
  resortToDelete: Resort = null;
  deleteResort: boolean = null;
  tempResort = false;

  // chairlift variables
  addChairlift: Chairlift = null;
  updateChairlift: Chairlift = null;
  chairliftList: Chairlift[] = [];
  chairliftToUpdate: Chairlift = null;
  chairliftToDelete: Chairlift = null;
  deleteChairlift: boolean = null;
  tempChairlift = false;

  // constructor
  constructor(
    private mountainService: MountainService,
    private trailService: TrailDetailsService,
    private resortService: ResortService,
    private chairliftService: ChairliftService
  ) { }

  // nothing happeing on init
  ngOnInit() {
  }

  /*
   *
   * MOUNTAIN
   *
   */

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
    this.resortList = [];
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

  // find all mountains
  findAllMountains() {
    this.mountainService.index().subscribe(
      mountainIndex => {

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

  // disable mountain
  submitDisableMountain(deleteId: number) {
    this.mountainService.disable(deleteId).subscribe(
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

  /*
   *
   * TRAIL
   *
   */

   // button click event that shows the add trail form
  addTrailForm() {
    this.title = 'Add Trail';
    this.addTrail = new Trail;
    this.findAllMountains();
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
    this.trailToDelete = new Trail();
    this.deleteTrail = true;
    this.findAllTrails();
  }

  // button click event that returns back to initial buttons
  cancelTrail() {
    this.title = this.mainTitle;
    this.addTrail = null;
    this.updateTrail = null;
    this.trailList = [];
    this.trailToUpdate = null;
    this.deleteTrail = null;
    this.tempTrail = false;
    this.trailToDelete = null;
    this.mountainList = [];
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
        this.updateTrail = singleTrail;
        this.tempTrail = true;
      },
      error => {
        console.error('admin.findSingleTrail(): Error finding Trail');
        console.error(error);
      }
    );
  }

  // delete trail
  submitDeleteTrail(deleteId: number) {
    this.trailService.disableTrail(deleteId).subscribe(
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


  /*
   *
   * RESORT
   *
   */

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
    this.resortToDelete = new Resort();
    this.findAllResorts();
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


  /*
   *
   * CHAIRLIFT
   *
   */

  // button click event that shows the add chairlift form
  addChairliftForm() {
    this.title = 'Add Chairlift';
    this.addChairlift = new Chairlift;
  }

  // button click event that shows the update chairlift form
  updateChairliftForm() {
    this.title = 'Update Chairlift';
    this.updateChairlift = new Chairlift();
    this.findAllChairlifts();
  }

  // button click event that shows the delete chairlift form
  deleteChairliftForm() {
    this.title = 'Delete Chairlift';
    this.deleteChairlift = true;
  }

  // button click event that returns back to initial buttons
  cancelChairlift() {
    this.title = this.mainTitle;
    this.addChairlift = null;
    this.updateChairlift = null;
    this.chairliftList = [];
    this.chairliftToUpdate = null;
    this.deleteChairlift = null;
    this.tempChairlift = false;
    this.chairliftToDelete = null;
  }

  // add chairlift
  submitNewChairlift() {
    this.chairliftService.create(this.addChairlift).subscribe(
      created => {
        console.log(created);
        this.cancelChairlift();
      },
      error => {
        console.error('admin.submitNewChairlift(): Error creating Chairlift');
        console.error(error);
      }
    );
  }

  // update resort
  submitUpdatedChairlift() {
    this.updateChairlift.id = this.chairliftToUpdate.id;
    this.chairliftService.update(this.updateChairlift).subscribe(
      updated => {
        console.log(updated);
        this.cancelChairlift();
      },
      error => {
        console.error('admin.submitUpdatedChairlift(): Error updating Chairlift');
        console.error(error);
      }
    );
  }

  // find all resorts
  findAllChairlifts() {
    this.chairliftService.index().subscribe(
      chairliftIndex => {
        console.log(chairliftIndex);
        this.chairliftList = chairliftIndex;
      },
      error => {
        console.error('admin.findAllChairlifts(): Error finding all Chairlifts');
        console.error(error);
      }
    );
  }

  // find single resort
  findSingleChairlift(chairliftId: number) {
    this.chairliftService.show(chairliftId).subscribe(
      singleChairlift => {
        console.log(singleChairlift);
        this.updateChairlift = singleChairlift;
        this.chairliftToUpdate = singleChairlift;
        this.tempChairlift = true;
      },
      error => {
        console.error('admin.findSingleChairlift(): Error finding Chairlift');
        console.error(error);
      }
    );
  }

  // delete resort
  submitDeleteChairlift(deleteId: number) {
    this.chairliftService.delete(deleteId).subscribe(
      deleteChairlift => {
        console.log(deleteChairlift);
        this.cancelChairlift();
      },
      error => {
        console.error('admin.submitDeleteChairlift(): Error deleting Chairlift');
        console.error(error);
      }
    );
  }
}
