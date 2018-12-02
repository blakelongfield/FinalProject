package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.User;

public interface UserService {
	
	
	
	List<User> findAll();

	User findById(Integer id);

	User create(User user);

	//	Patch
	User update(User user, Integer id);

	Boolean destroy(Integer id);

}
