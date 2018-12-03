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

  newMountain: Mountain = null;
  constructor(
    private mountainService: MountainService
  ) { }

  ngOnInit() {
  }

  addMountain() {
    this.title = 'Add Mountain';
    this.newMountain = new Mountain();
  }

  submitMountain() {
    console.log(this.newMountain);

    this.mountainService.create(this.newMountain).subscribe(
      created => {
        console.log(created);
        this.cancel();
      },
      error => {
        console.error('admin.submitMountain(): Error creating Mountain');
        console.error(error);
      }
    );
  }

  cancel() {
    this.title = this.mainTitle;
    this.newMountain = null;
  }

}
