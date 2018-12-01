package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="chairlift")
public class ChairLift {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="ride_length")
	private Double rideLength;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="chairlift_type_id")
	private LiftType type;
	
	private String hours;
	
	@JsonBackReference
	@ManyToMany(mappedBy="lifts")
	private List<Trail> trails;

	/*
	 * getters / setters
	 */
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Double getRideLength() {
		return rideLength;
	}

	public void setRideLength(Double rideLength) {
		this.rideLength = rideLength;
	}

	public LiftType getType() {
		return type;
	}

	public void setType(LiftType type) {
		this.type = type;
	}

	public String getHours() {
		return hours;
	}

	public void setHours(String hours) {
		this.hours = hours;
	}

	public List<Trail> getTrails() {
		return trails;
	}

	public void setTrails(List<Trail> trails) {
		this.trails = trails;
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
		ChairLift other = (ChairLift) obj;
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
		builder.append("ChairLift [id=").append(id)
				.append(", rideLength=").append(rideLength)
				.append(", type=").append(type)
				.append(", hours=").append(hours)
				.append(", trails=").append(trails.size())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public ChairLift() {
		super();
	}

	public ChairLift(int id, Double rideLength, LiftType type, String hours, List<Trail> trails) {
		super();
		this.id = id;
		this.rideLength = rideLength;
		this.type = type;
		this.hours = hours;
		this.trails = trails;
	}
	
	
	
	
}
