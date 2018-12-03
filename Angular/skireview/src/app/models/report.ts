export class Report {
  id: number;
  reportText: string;
  rating: number;
  imageURL: string;
  vote: number;

  constructor( id?: number, rtext?: string, rating?: number, image?: string, vote?: number) {
    this.id = id;
    this.reportText = rtext;
    this.rating = rating;
    this.imageURL = image;
    this.vote = vote;
  }
}
