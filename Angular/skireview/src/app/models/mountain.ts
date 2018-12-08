import { Resort } from './resort';
import { Trail } from './trail';
export class Mountain {
  id: number;
  name: string;
  numberOfRuns: number;
  numberOfLifts: number;
  baseElevation: number;
  peakElevation: number;
  averageAnnualSnowfall: number;
  mountainMapUrl: string;
  active: boolean;
  trails: Trail[];
  resort: Resort;

  constructor(
    id?: number,
    name?: string,
    numberOfRuns?: number,
    numberOfLifts?: number,
    baseElevation?: number,
    peakElevation?: number,
    averageAnnualSnowfall?: number,
    mountainMapUrl?: string,
    active?: boolean,
    trails ?: Trail[],
    resort?: Resort
    ) {
    this.id = id;
    this.name = name;
    this.numberOfRuns = numberOfRuns;
    this.numberOfLifts = numberOfLifts;
    this.baseElevation = baseElevation;
    this.peakElevation = peakElevation;
    this.averageAnnualSnowfall = averageAnnualSnowfall;
    this.mountainMapUrl = mountainMapUrl;
    this.active = active;
    this.trails = trails;
    this.resort = resort;
  }
}
