import { User } from './user';
export class Report {
  id: number;
  reportText: string;
  rating: number;
  imageURL: string;
  vote: number;
  user: User;

  constructor( id?: number, rtext?: string, rating?: number, image?: string, vote?: number, user?: User) {
    this.id = id;
    this.reportText = rtext;
    this.rating = rating;
    this.imageURL = image;
    this.vote = vote;
    this.user = user;
  }
}
