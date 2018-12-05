package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.CascadeType;
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

@Entity
@Table(name="chairlift")
public class ChairLift {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name="ride_length")
	private Double rideLength;
	
	@JsonBackReference(value="liftTypeToChairLift")
//	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@ManyToOne
	@JoinColumn(name="chairlift_type_id")
	private LiftType type;
	
	private String hours;
	
	private Boolean active;
	
//	@JsonBackReference(value="trailToChairLift")
	@JsonIgnore
	@ManyToMany(mappedBy="lifts", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	private List<Trail> trails;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="mountain_id")
	private Mountain mountain;

	/*
	 * getters / setters
	 */
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public List<Trail> getTrails() {
		return trails;
	}

	public void setTrails(List<Trail> trails) {
		this.trails = trails;
	}

	public Mountain getMountain() {
		return mountain;
	}

	public void setMountain(Mountain mountain) {
		this.mountain = mountain;
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
//	@Override
//	public String toString() {
//		StringBuilder builder = new StringBuilder();
//		builder.append("ChairLift [id=").append(id)
//				.append(", name=").append(name)
//				.append(", rideLength=").append(rideLength)
//				.append(", type=").append(type)
//				.append(", hours=").append(hours)
//				.append(", trails=").append(trails.size())
//				.append("]");
//		return builder.toString();
//	}

	/*
	 * constructors
	 */
	public ChairLift() {
		super();
	}

	public ChairLift(int id, String name, Double rideLength, LiftType type, String hours, Boolean active,
			List<Trail> trails, Mountain mountain) {
		super();
		this.id = id;
		this.name = name;
		this.rideLength = rideLength;
		this.type = type;
		this.hours = hours;
		this.active = active;
		this.trails = trails;
		this.mountain = mountain;
	}
	
	
	
	
}
