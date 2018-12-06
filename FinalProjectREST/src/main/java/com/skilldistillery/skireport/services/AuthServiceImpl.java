package com.skilldistillery.skireport.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	UserRepository userRepository;
	@Autowired
	PasswordEncoder encoder;
	
	@Override
	public User register(User user) {
		String encodedPW = encoder.encode(user.getPassword());
		user.setPassword(encodedPW);
		user.setActive(true);
		user.setRole("Standard");
		userRepository.saveAndFlush(user);
		return user;
	}

}
