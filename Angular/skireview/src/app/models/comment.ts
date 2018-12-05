import { User } from './user';
import { Report } from './report';

export class Comment {
  id: number;
  commentText: string;
  active: boolean;
  user: User;
  report: Report;

  constructor( id?: number, commentText?: string, active?: boolean, user?: User, report?: Report) {
  this.id = id;
  this.commentText = commentText;
  this.active = active;
  this.user = user;
  this.report = report;
  }
}
