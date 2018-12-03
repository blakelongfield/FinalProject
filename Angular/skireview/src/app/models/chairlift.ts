export class Chairlift {
  id: number;
  name: string;
  rideLength: number;
  hours: string;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, name?: string, rideLength?: number, hours?: string) {
    this.id = id;
    this.name = name;
    this.rideLength = rideLength;
    this.hours = hours;
  }
}
