package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Trail;

public interface TrailService {

	List<Trail> findAll();

	Trail findById(int trailId);

	Trail create(Trail trail, String username);

}
