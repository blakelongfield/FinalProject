import { MountainService } from './../mountain.service';
import { Mountain } from './../models/mountain';
import { Component, OnInit } from '@angular/core';

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

  constructor(
    private mountainService: MountainService
  ) { }

  ngOnInit() {
  }

  addMountainForm() {
    this.title = 'Add Mountain';
    this.addMountain = new Mountain();
  }

  updateMountainForm() {
    this.title = 'Update Mountain';
    this.updateMountain = new Mountain();
  }

  cancel() {
    this.title = this.mainTitle;
    this.addMountain = null;
    this.updateMountain = null;
  }

  submitNewMountain() {
    this.mountainService.create(this.addMountain).subscribe(
      created => {
        console.log(created);
        this.cancel();
      },
      error => {
        console.error('admin.submitNewMountain(): Error creating Mountain');
        console.error(error);
      }
    );
  }

  submitUpdatedMountain() {
    this.mountainService.patch(this.updateMountain).subscribe(
      updated => {
        console.log(updated);
        this.cancel();
      },
      error => {
        console.error('admin.submitUpdatedMountain(): Error updating Mountain');
        console.error(error);
      }
    );
  }

}
