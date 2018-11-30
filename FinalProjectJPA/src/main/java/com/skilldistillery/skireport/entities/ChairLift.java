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

@Entity
@Table(name="chairlift")
public class ChairLift {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="ride_length")
	private Double rideLength;
	
	
	@ManyToOne
	@JoinColumn(name="chairlift_type_id")
	private LiftType type;
	
	private String hours;
	
	@ManyToMany(mappedBy="lifts")
	private List<TrailTest> trails;
	
	
	//GETTERS AND SETTERS

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

	public List<TrailTest> getTrails() {
		return trails;
	}

	public void setTrails(List<TrailTest> trails) {
		this.trails = trails;
	}

	
	// HASH CODE AND EQAULS
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

	
	// TO STRING
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ChairLift [id=");
		builder.append(id);
		builder.append(", rideLength=");
		builder.append(rideLength);
		builder.append(", type=");
		builder.append(type);
		builder.append(", hours=");
		builder.append(hours);
		builder.append(", trails=");
		builder.append(trails);
		builder.append("]");
		return builder.toString();
	}
	
	// CONSTRUCTORS

	public ChairLift(int id, Double rideLength, LiftType type, String hours, List<Trail> trails) {
		super();
		this.id = id;
		this.rideLength = rideLength;
		this.type = type;
		this.hours = hours;
		this.trails = trails;
	}

	public ChairLift() {}
	
	
	
	
}
