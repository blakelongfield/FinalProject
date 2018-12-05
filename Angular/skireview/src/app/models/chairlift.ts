export class Chairlift {
  id: number;
  name: string;
  rideLength: number;
  hours: string;
  active: boolean;

  constructor(
    id?: number,
    name?: string,
    rideLength?: number,
    hours?: string,
    active?: boolean
    ) {
    this.id = id;
    this.name = name;
    this.rideLength = rideLength;
    this.hours = hours;
    this.active = active;
  }
}
