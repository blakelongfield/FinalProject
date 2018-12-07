package com.skilldistillery.skireport.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class UserController {

	@Autowired
	private UserService userServ;

	private String username = "zach";

//	Lists all Users
	@RequestMapping(path = "users", method = RequestMethod.GET)
	public List<User> index(Principal principal) {
		List<User> users = userServ.findAll();
		return users;
	}

	// Finds User by Id
	@RequestMapping(path = "users/{id}", method = RequestMethod.GET)
	public User userById(@PathVariable("id") Integer id, HttpServletResponse resp, Principal principal) {
		User userById = userServ.findById(id);
		if (userById == null) {
			resp.setStatus(404);
		}
		return userById;

	}

//	Creates a new User
	@RequestMapping(path = "users", method = RequestMethod.POST)
	public User createUser(@RequestBody User user, HttpServletResponse resp, HttpServletRequest req, Principal principal) {

		User newUser = userServ.create(user);

		if (newUser == null) {
			resp.setStatus(404);
		} else {
			resp.setStatus(201);
			String newUrl = req.getRequestURL() + "/" + user.getId();
			resp.setHeader("Location", newUrl);
		}
		return newUser;

	}

//	Updates a User
	@RequestMapping(path = "users", method = RequestMethod.PATCH)
	public User updateUser(@RequestBody User user, HttpServletResponse resp, Principal principal) {
		System.out.println("User body: " + user);
		User updatedUser = userServ.update(user, principal.getName());
		if (updatedUser != null) {
			resp.setStatus(201);
		} else {
			resp.setStatus(404);
		}
		return updatedUser;
	}

//	Deletes User
	@RequestMapping(path = "users", method = RequestMethod.DELETE)
	public Boolean deleteUser(HttpServletResponse resp, Principal principal) {
		Boolean deletedUser = null;
		deletedUser = userServ.destroy(principal.getName());
		if (deletedUser) {
			resp.setStatus(200);
			resp.setHeader("Message", "User deleted succesfully");
		}

		else {
			resp.setStatus(404);
			resp.setHeader("Message", "User failed to be deleted");
		}
		return deletedUser;
	}
	@GetMapping("users/roles")
	public Boolean checkUserRole(HttpServletResponse resp, Principal principal) {
		Boolean role = false;
		role = userServ.findByRole(principal.getName());
		if(role) {
			resp.setStatus(200);
		}
		else {
			resp.setStatus(404);
		}
		
		
		return role;
	}
	
//	 Grabs user by username
	
	@RequestMapping(path="users/username", method=RequestMethod.GET)
	public User findByUsername(Principal principal, HttpServletResponse resp) {
		System.out.println(principal.getName());
		User user = userServ.findByUsername(principal.getName());
		
		if(user != null) {
			resp.setStatus(200);
			
		}
		else {
			resp.setStatus(404);
		}
		
		return user;
		
	}

}
