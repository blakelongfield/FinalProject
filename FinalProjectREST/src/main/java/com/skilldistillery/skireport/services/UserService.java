package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.User;

public interface UserService {
	
	
	
	List<User> findAll();

	User findById(Integer id);

	User create(User user);

	//	Patch
	User update(User user, String username);

	Boolean destroy(String username);
	
	Boolean findByRole(String username);
	
	User findByUsername(String username);

}
