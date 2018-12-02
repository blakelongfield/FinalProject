package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.UserRepository;


@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepo;

//	Lists all Users
	@Override
	public List<User> findAll() {
		
		return userRepo.findAll();
	}

//	Finds User by Id
	@Override
	public User findById(Integer id) {
		
		Optional<User> userOpt = userRepo.findById(id);
		User userId = userOpt.get();
		
		return userId;
	}
	
	
// Creates a new User
	@Override
	public User create(User user) {
		
		User createUser = userRepo.saveAndFlush(user);
		
		return createUser;
	}
	
	
//  Updates User
	@Override
	public User update(User user, Integer id) {
		Optional<User> opt = userRepo.findById(id);
		User updatedUser = opt.get();
		
		if(user.getFirstName() != null) {
			updatedUser.setFirstName(user.getFirstName());
		}
		
		if(user.getLastName() != null) {
			updatedUser.setLastName(user.getLastName());
			
		}
		
		if(user.getUsername() != null) {
			updatedUser.setUsername(user.getUsername());
		}
		
		if(user.getPassword() != null) {
			updatedUser.setPassword(user.getPassword());
		}
		
		if(user.getEmail() != null) {
			updatedUser.setEmail(user.getEmail());
		}
		
		if(user.getRole() != null) {
			updatedUser.setRole(user.getRole());
		}
		
		if(user.getActive() != null) {
			updatedUser.setActive(user.getActive());
		}
		
		if(user.getImgUrl() != null) {
			updatedUser.setImgUrl(user.getImgUrl());
		}
		
		return updatedUser;
	}
	
//	  Deletes User
	@Override
	public Boolean destroy(Integer id) {
		if(userRepo.findById(id).isPresent()) {
			userRepo.deleteById(id);
			return true;
		}
		else {
			return false;
		}
		
	}

}
