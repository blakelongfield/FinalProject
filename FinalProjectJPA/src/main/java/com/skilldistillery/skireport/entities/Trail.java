package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Trail {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String name;
	@Enumerated(EnumType.STRING)
	private Difficulty difficulty;
	private Integer length;
	@Column(name="elevation_gain_loss")
	private Integer elevationGainLoss;
	private String features;
	
	
	
	@ManyToMany
	@JoinTable(name="chairlift_has_trail", 
	joinColumns=@JoinColumn(name="trail_id"),
	inverseJoinColumns=@JoinColumn(name="chairlift_id"))
	private List<ChairLift> lifts;
	
	
	
	@OneToMany(mappedBy="trail")
	private List<Report> reports;
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
	public Difficulty getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(Difficulty difficulty) {
		this.difficulty = difficulty;
	}
	public Integer getLength() {
		return length;
	}
	public void setLength(Integer length) {
		this.length = length;
	}
	public Integer getElevationGainLoss() {
		return elevationGainLoss;
	}
	public void setElevationGainLoss(Integer elevationGainLoss) {
		this.elevationGainLoss = elevationGainLoss;
	}
	public String getFeatures() {
		return features;
	}
	public void setFeatures(String features) {
		this.features = features;
	}
	
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
		Trail other = (Trail) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Trail [id=").append(id)
				.append(", name=").append(name)
				.append(", difficulty=").append(difficulty)
				.append(", length=").append(length)
				.append(", elevationGainLoss=").append(elevationGainLoss)
				.append(", features=").append(features)
				.append("]");
		return builder.toString();
	}
	
	public Trail() {
		super();
	}
	
	public Trail(int id, String name, Difficulty difficulty, Integer length, Integer elevationGainLoss,
			String features) {
		super();
		this.id = id;
		this.name = name;
		this.difficulty = difficulty;
		this.length = length;
		this.elevationGainLoss = elevationGainLoss;
		this.features = features;
	}
	
}
