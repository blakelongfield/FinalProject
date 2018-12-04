package com.skilldistillery.skireport.services;

import java.util.Comparator;

import com.skilldistillery.skireport.entities.Trail;

public class TrailSortByName implements Comparator<Trail> {

	@Override
	public int compare(Trail t1, Trail t2) {
		if ( t1.getName() == t2.getName() ) {
			return 0;
		}
		if( t1.getName() == null) {
			return -1;
		}
		if( t2.getName() == null) {
			return 1;
		}
		return t1.getName().compareTo(t2.getName());
		
	}

}
