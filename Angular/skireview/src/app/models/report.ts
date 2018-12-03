import { User } from './user';
import { Trail } from './trail';
import { Mountain } from './mountain';
export class Report {
  id: number;
  reportText: string;
  rating: number;
  imageURL: string;
  vote: number;
  user: User;
  trail: Trail;
  mountain: Mountain;

  constructor( id?: number, rtext?: string, rating?: number, image?: string, vote?: number, user?: User, mtn?: Mountain, trail?: Trail) {
    this.id = id;
    this.reportText = rtext;
    this.rating = rating;
    this.imageURL = image;
    this.vote = vote;
    this.user = user;
    this.trail = trail;
    this.mountain = mtn;
  }
}
