package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Mountain;

public interface MountainService {
	
	List<Mountain> findAll();
	
	Mountain findById(Integer id);
	
	Mountain create(Mountain mountain, Integer resortId, String username);
	
//	patch
	Mountain update(Mountain mountain, Integer mountainId, String username);
	
	Boolean destroy(Integer mountainId, String username);
	


}
