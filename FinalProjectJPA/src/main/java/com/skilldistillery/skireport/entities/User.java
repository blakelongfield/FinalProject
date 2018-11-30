package com.skilldistillery.skireport.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String firstName;
	private String lastName;
	private String userName;
	private String password;
	private String email;
	private String role;
	private Boolean active;
	private String imgUrl;
		
	
}
