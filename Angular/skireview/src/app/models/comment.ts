export class Comment {
  id: number;
  commentText: string;

  constructor( id?: number, commentText?: string ) {
  this.id = id;
  this.commentText = commentText;
  }
}
