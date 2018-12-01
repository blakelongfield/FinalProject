package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Resort {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String street;
	
	private String street2;
	
	private String city;
	
	private String state;
	
	private String zip;
	
	private String name;
	
	private Integer acres;
	
	@JsonManagedReference
	@OneToMany(mappedBy="resort")
	private List<Mountain> mountains;
	
	/*
	 * getters / setters
	 */
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getStreet() {
		return street;
	}
	
	public void setStreet(String street) {
		this.street = street;
	}
	
	public String getStreet2() {
		return street2;
	}
	
	public void setStreet2(String street2) {
		this.street2 = street2;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getState() {
		return state;
	}
	
	public void setState(String state) {
		this.state = state;
	}
	
	public String getZip() {
		return zip;
	}
	
	public void setZip(String zip) {
		this.zip = zip;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getAcres() {
		return acres;
	}
	
	public void setAcres(Integer acres) {
		this.acres = acres;
	}
	
	public List<Mountain> getMountains() {
		return mountains;
	}
	
	public void setMountains(List<Mountain> mountains) {
		this.mountains = mountains;
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
		Resort other = (Resort) obj;
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
		builder.append("Resort [id=").append(id)
				.append(", street=").append(street)
				.append(", street2=").append(street2)
				.append(", city=").append(city)
				.append(", state=").append(state)
				.append(", zip=").append(zip)
				.append(", name=").append(name)
				.append(", acres=").append(acres)
				.append(", mountains=").append(mountains.size())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public Resort(int id, String street, String street2, String city, String state, String zip, String name,
			Integer acres, List<Mountain> mountains) {
		super();
		this.id = id;
		this.street = street;
		this.street2 = street2;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.name = name;
		this.acres = acres;
		this.mountains = mountains;
	}

	public Resort() {
		super();
	}
	
}
