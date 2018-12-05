import { Chairlift } from './chairlift';
import { Mountain } from './mountain';
export class Trail {
  id: number;
  name: string;
  difficulty: string;
  length: number;
  elevationGainLoss: number;
  features: string;
  active: boolean;
  mountain: Mountain;

  constructor(
    id?: number,
    name?: string,
    difficulty?: string,
    length?: number,
    elevationGainLoss?: number,
    features?: string,
    active?: boolean,
    mountain?: Mountain,

    ) {
    this.id = id;
    this.name = name;
    this.difficulty = difficulty;
    this.length = length;
    this.elevationGainLoss = elevationGainLoss;
    this.features = features;
    this.active = active;
    this.mountain = mountain;
  }
}
