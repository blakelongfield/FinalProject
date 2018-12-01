package com.skilldistillery.skireport.services;

import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.User;

@Service
public class AuthServiceImpl implements AuthService {

//	@Autowired
//	UserRepository userRepository;
//	@Autowired
//	PasswordEncoder encoder;
//	
	@Override
	public User register(User user) {
//		String encodedPW = encoder.encode(user.getPassword());
//		user.setPassword(encodedPW);
//		user.setEnabled(true);
//		user.setRole("standard");
//		userRepository.saveAndFlush(user);
		return user;
	}

}
