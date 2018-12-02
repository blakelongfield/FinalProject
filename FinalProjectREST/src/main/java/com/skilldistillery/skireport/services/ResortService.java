package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Resort;

public interface ResortService {
	List<Resort> findAll();

	Resort findById(int resortId);

	Resort create(Resort resort, String username);

	Resort update(Resort resort, int resortId, String username);

	Boolean destroy(int resortId, String username);
}
