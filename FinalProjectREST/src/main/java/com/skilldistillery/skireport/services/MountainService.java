package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Mountain;

public interface MountainService {
	
	List<Mountain> findAll();
	
	Mountain findById(Integer id);
	


}
