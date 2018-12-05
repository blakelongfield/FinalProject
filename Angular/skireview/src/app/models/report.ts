import { User } from './user';
import { Trail } from './trail';
import { Mountain } from './mountain';
export class Report {
  id: number;
  reportText: string;
  rating: number;
  imageURL: string;
  votes: number;
  active: boolean;
  user: User;
  trail: Trail;
  mountain: Mountain;
  comment: Comment;
  dateCreated: Date;


  constructor(
    id?: number,
    reportText?: string,
    rating?: number,
    image?: string,
    votes?: number,
    active?: boolean,
    user?: User,
    mountain?: Mountain,
    trail?: Trail,
    comment?: Comment
    ) {
    this.id = id;
    this.reportText = reportText;
    this.rating = rating;
    this.imageURL = image;
    this.votes = votes;
    this.active = active;
    this.user = user;
    this.trail = trail;
    this.mountain = mountain;
    this.comment = comment;
  }
}
