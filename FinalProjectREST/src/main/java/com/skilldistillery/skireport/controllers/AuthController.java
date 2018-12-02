package com.skilldistillery.skireport.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.services.AuthService;

@RestController
@CrossOrigin({ "*", "http://localhost:4201" })
public class AuthController {

	@Autowired
	AuthService authService;

	@PostMapping("/register")
	public User register(@RequestBody User user, HttpServletResponse res) {
		if (user == null) {
			res.setStatus(400);
			return user;
		}

		user = authService.register(user);
		return user;
	}

	@GetMapping("/authenticate")
	public Principal authenticate(Principal principal) {
		return principal;
	}

}