package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	private String username;
	
	private String password;
	
	private String email;
	
	private String role;
	
	private Boolean active;
	
	@Column(name="profile_pic_url")
	private String imgUrl;
	
	@JsonManagedReference
	@OneToMany(mappedBy="userComment")
	private List<Comment> comments;
	
	@JsonManagedReference
	@OneToMany(mappedBy="user")
	private List<Report> reports;

	/*
	 * getters / setters
	 */
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String userName) {
		this.username = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Report> getReports() {
		return reports;
	}

	public void setReports(List<Report> reports) {
		this.reports = reports;
	}

	/*
	 * hashCode / equals
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}

	/*
	 * toString
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=").append(id)
				.append(", firstName=").append(firstName)
				.append(", lastName=").append(lastName)
				.append(", userName=").append(username)
				.append(", password=").append(password)
				.append(", email=").append(email)
				.append(", role=").append(role)
				.append(", active=").append(active)
				.append(", imgUrl=").append(imgUrl)
				.append(", comments=").append(comments.size())
				.append(", reports=").append(reports.size())
				.append("]");
		return builder.toString();
	}


	/*
	 * constructors
	 */
	public User(int id, String firstName, String lastName, String username, String password, String email, String role,
			Boolean active, String imgUrl, List<Comment> comments, List<Report> reports) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.email = email;
		this.role = role;
		this.active = active;
		this.imgUrl = imgUrl;
		this.comments = comments;
		this.reports = reports;
	}

	public User() {
		super();
	}
	
	
}