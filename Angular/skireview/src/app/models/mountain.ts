export class Mountain {
  id: number;
  name: string;
  numberOfTrails: number;
  numberOfLifts: number;
  elevationBase: number;
  elevationPeak: number;
  mountainMapUrl: string;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, name?: string, numberOfTrails?: number, numberOfLifts?: number, elevationBase?: number, elevationPeak?: number, mountainMapUrl?: string) {
    this.id = id;
    this.name = name;
    this.numberOfTrails = numberOfTrails;
    this.numberOfLifts = numberOfLifts;
    this.elevationBase = elevationBase;
    this.elevationPeak = elevationPeak;
    this.mountainMapUrl = mountainMapUrl;
  }
}
