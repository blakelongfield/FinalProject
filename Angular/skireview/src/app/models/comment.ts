import { User } from './user';
import { Report } from './report';

export class Comment {
  id: number;
  commentText: string;
  user: User;
  report: Report;

  constructor( id?: number, commentText?: string, user?: User, report?: Report) {
  this.id = id;
  this.commentText = commentText;
  this.user = user;
  this.report = report;
  }
}
