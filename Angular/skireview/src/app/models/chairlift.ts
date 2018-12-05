export class Chairlift {
  id: number;
  name: string;
  rideLength: number;
  hours: string;
  active: boolean;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, name?: string, rideLength?: number, hours?: string, active?: boolean) {
    this.id = id;
    this.name = name;
    this.rideLength = rideLength;
    this.hours = hours;
    this.active = active;
  }
}
