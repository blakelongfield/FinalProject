import { Resort } from './resort';
import { Trail } from './trail';
export class Mountain {
  id: number;
  name: string;
  numberOfRuns: number;
  numberOfLifts: number;
  baseElevation: number;
  peakElevation: number;
  mountainMapUrl: string;
  trails: Trail[];
  resort: Resort;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, name?: string, numberOfRuns?: number, numberOfLifts?: number, baseElevation?: number, peakElevation?: number, mountainMapUrl?: string, trails ?: Trail[], resort?: Resort) {
    this.id = id;
    this.name = name;
    this.numberOfRuns = numberOfRuns;
    this.numberOfLifts = numberOfLifts;
    this.baseElevation = baseElevation;
    this.peakElevation = peakElevation;
    this.mountainMapUrl = mountainMapUrl;
    this.trails = trails;
    this.resort = resort;
  }
}
