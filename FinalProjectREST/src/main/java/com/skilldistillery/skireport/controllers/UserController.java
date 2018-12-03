package com.skilldistillery.skireport.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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

	private String username = "test";

//	Lists all Users
	@RequestMapping(path = "users", method = RequestMethod.GET)
	public List<User> index() {

		List<User> users = userServ.findAll();

		return users;

	}

	// Finds User by Id
	@RequestMapping(path = "users/{id}", method = RequestMethod.GET)
	public User userById(@PathVariable("id") Integer id, HttpServletResponse resp) {

		User userById = userServ.findById(id);
		if (userById == null) {
			resp.setStatus(404);
		}
		return userById;

	}

//	Creates a new User
	@RequestMapping(path = "users", method = RequestMethod.POST)
	public User createUser(@RequestBody User user, HttpServletResponse resp, HttpServletRequest req) {

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
	public User updateUser(@RequestBody User user, HttpServletResponse resp) {
		User updatedUser = userServ.update(user, username);

		if (updatedUser != null) {
			resp.setStatus(201);
		} else {
			resp.setStatus(404);

		}

		return updatedUser;

	}

//	Deletes User
	@RequestMapping(path = "users", method = RequestMethod.DELETE)
	public Boolean deleteUser(HttpServletResponse resp) {
		Boolean deletedUser = null;
		deletedUser = userServ.destroy(username);
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

}
