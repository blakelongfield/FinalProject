import { TestBed } from '@angular/core/testing';

import { ResortService } from './resort.service';

describe('ResortService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ResortService = TestBed.get(ResortService);
    expect(service).toBeTruthy();
  });
});
