import { TestBed } from '@angular/core/testing';

import { TrailDetailsService } from './trail-details.service';

describe('TrailDetailsService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: TrailDetailsService = TestBed.get(TrailDetailsService);
    expect(service).toBeTruthy();
  });
});
