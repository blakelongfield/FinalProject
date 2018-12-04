package com.skilldistillery.skireport.services;

import java.util.Comparator;

import com.skilldistillery.skireport.entities.Trail;

public class TrailSortByFeature implements Comparator<Trail> {
	
	

	@Override
	public int compare(Trail t1, Trail t2) {
		if(t1.getFeatures() == t2.getFeatures()) {
			return 0;
		}
		if( t1.getFeatures() ==  null) {
			return -1;
		}
		if( t2.getFeatures() == null) {
			return 1;
		}
		
		return t1.getFeatures().compareTo(t2.getFeatures());
	}

}
