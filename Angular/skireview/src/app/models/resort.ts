export class Resort {
  id: number;
  street: string;
  street2: string;
  city: string;
  state: string;
  zip: string;
  name: string;
  acres: number;

  // tslint:disable-next-line:max-line-length
  constructor(id?: number, street?: string, street2?: string, city?: string, state?: string, zip?: string, name?: string, acres?: number) {
    this.id = id;
    this.street = street;
    this.street2 = street2;
    this.city = city;
    this.state = state;
    this.zip = zip;
    this.name = name;
    this.acres = acres;
}
}
