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

		user.setActive(true);
		User createUser = userRepo.saveAndFlush(user);

		return createUser;
	}

//  Updates User
	@Override
	public User update(User user, String username) {
		User updatedUser = userRepo.findByUsername(username);

		if (user != null) {

			if (user.getFirstName() != null) {
				System.out.println(user.getFirstName());
				updatedUser.setFirstName(user.getFirstName());

			}

			if (user.getLastName() != null) {
				updatedUser.setLastName(user.getLastName());

			}

			if (user.getUsername() != null) {
				updatedUser.setUsername(user.getUsername());
			}

			if (user.getPassword() != null) {
				updatedUser.setPassword(user.getPassword());
			}

			if (user.getEmail() != null) {
				updatedUser.setEmail(user.getEmail());
			}

			if (user.getRole() != null) {
				updatedUser.setRole(user.getRole());
			}

			if (user.getActive() != null) {

				updatedUser.setActive(user.getActive());

			}

			if (user.getImgUrl() != null) {
				updatedUser.setImgUrl(user.getImgUrl());
			}
			userRepo.saveAndFlush(updatedUser);
		}

		return updatedUser;
	}

//	  Deletes User
	@Override
	public Boolean destroy(String username) {

		User user = userRepo.findByUsername(username);

		if (user != null) {

			userRepo.deleteById(user.getId());
			return true;
		} else {
			return false;

		}

	}

	@Override
	public Boolean findByRole(String username) {
		User user = userRepo.findByUsername(username);
		Boolean role = false;
		
		if(user != null) {
			if(user.getRole().equals("Admin")) {
				role = true;
			}
			
		}
		return role;
	}
	
//  Grabs user by username
	@Override
	public User findByUsername(String username) {
		User findUser = userRepo.findByUsername(username);
		System.out.println("--------" + findUser);
		
		
		return findUser;
	}

}
