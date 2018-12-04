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
  comment: Comment;

  // tslint:disable-next-line:max-line-length
  constructor( id?: number, rtext?: string, rating?: number, image?: string, vote?: number, user?: User, mtn?: Mountain, trail?: Trail, comment?: Comment) {
    this.id = id;
    this.reportText = rtext;
    this.rating = rating;
    this.imageURL = image;
    this.vote = vote;
    this.user = user;
    this.trail = trail;
    this.mountain = mtn;
    this.comment = comment;
  }
}
