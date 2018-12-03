export class User {
  id: number;
  firstName: string;
  lastName: string;
  username: string;
  password: string;
  email: string;
  role: string;
  active: boolean;
  profilePic: string;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, firstName?: string, lastName?: string, username?: string, password?: string, email?: string, role?: string, active?: boolean, profilePic?: string) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.active = active;
    this.profilePic = profilePic;
  }

}
