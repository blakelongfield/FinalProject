

export class Trail {
  id: number;
  name: string;
  difficulty: string;
  length: number;
  elevationGainLoss: number;
  features: string;


  constructor(id?: number, name?: string, length?: number, elevationGainLoss?: number, features?: string ) {

    this.id = id;
    this.name = name;
    this.length = length;
    this.elevationGainLoss = elevationGainLoss;
    this.features = features;

  }
}
