import { TestBed } from '@angular/core/testing';

import { ChairliftService } from './chairlift.service';

describe('ChairliftService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ChairliftService = TestBed.get(ChairliftService);
    expect(service).toBeTruthy();
  });
});
