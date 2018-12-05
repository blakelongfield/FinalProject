import { Mountain } from './mountain';
export class Trail {
  id: number;
  name: string;
  difficulty: string;
  length: number;
  elevationGainLoss: number;
  features: string;
  mountain: Mountain;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, name?: string, difficulty?: string, length?: number, elevationGainLoss?: number, features?: string, mountain?: Mountain) {

    this.id = id;
    this.name = name;
    this.difficulty = difficulty;
    this.length = length;
    this.elevationGainLoss = elevationGainLoss;
    this.features = features;
    this.mountain = mountain;
  }
}
