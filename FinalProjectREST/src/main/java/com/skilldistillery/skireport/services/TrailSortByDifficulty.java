package com.skilldistillery.skireport.services;

import java.util.Comparator;

import com.skilldistillery.skireport.entities.Trail;

public class TrailSortByDifficulty implements Comparator<Trail> {

	@Override
	public int compare(Trail t1, Trail t2) {

			
			if (t1.getDifficulty().ordinal() < t2.getDifficulty().ordinal()) {
				return -1;
				
			} else if (t1.getDifficulty().ordinal() > t2.getDifficulty().ordinal()) {
				return 1;
				
			} else {
				return ((Integer)t1.getDifficulty().ordinal()).compareTo(t2.getDifficulty().ordinal());
			}
		

	}
}
//public int compare(Planet a, Planet b) {
//    if (a.getDiameter() < b.getDiameter())
//      return -1;
//    else if (a.getDiameter() > b.getDiameter())
//      return 1;
//    else
//      return a.getName().compareTo(b.getName());
//  }
//}