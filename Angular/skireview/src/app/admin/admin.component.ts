import { Mountain } from './../models/mountain';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  title = 'Admin';

  newMountain: Mountain = null;
  constructor() { }

  ngOnInit() {
  }

  addMountain() {
    this.title = 'Add Mountain';
    this.newMountain = new Mountain();
  }

  cancel() {
    this.title = this.title;
    this.newMountain = null;
  }

}
