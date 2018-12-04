package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;


@Entity
@Table(name="chairlift_type")
public class LiftType {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String type;

	private Integer capacity;
	
	@JsonManagedReference(value="liftTypeToChairLift")
	@OneToMany(mappedBy="type", cascade = CascadeType.ALL)
	private List<ChairLift> lifts;

	/*
	 * getters / setters
	 */
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getCapacity() {
		return capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	public List<ChairLift> getLifts() {
		return lifts;
	}

	public void setLifts(List<ChairLift> lifts) {
		this.lifts = lifts;
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
		LiftType other = (LiftType) obj;
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
		builder.append("LiftType [id=").append(id)
				.append(", type=").append(type)
				.append(", capacity=").append(capacity)
				.append(", lifts=").append(lifts.size())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public LiftType() {
		super();
	}

	public LiftType(int id, String type, Integer capacity, List<ChairLift> lifts) {
		super();
		this.id = id;
		this.type = type;
		this.capacity = capacity;
		this.lifts = lifts;
	}
	
	
	
}
