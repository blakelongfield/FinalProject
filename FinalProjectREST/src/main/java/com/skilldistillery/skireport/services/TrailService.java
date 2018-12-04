package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Trail;

public interface TrailService {

	List<Trail> findAll();
	
	List<Trail> sortBy( String searchParam);

	Trail findById(int trailId);

	Trail create(Trail trail, int mountianId, String username);

	Trail update(Trail trail, int trailId, String username);

	Trail patch(Trail trail, int trailId, String username);

	Boolean destroy(int trailId, String username);
	
	

}
