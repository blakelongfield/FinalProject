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

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

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
	
	@JsonBackReference(value="mountainToTrails")
	@ManyToOne
	@JoinColumn(name="mountain_id")
	private Mountain mountain;

//	@JsonManagedReference(value="trailToChairLift")
	@JsonIgnore
	@ManyToMany
	@JoinTable(name="chairlift_has_trail", 
	joinColumns=@JoinColumn(name="trail_id"),
	inverseJoinColumns=@JoinColumn(name="chairlift_id"))
	private List<ChairLift> lifts;
	
	@JsonIgnore
	@OneToMany(mappedBy="trail")
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

	public Mountain getMountain() {
		return mountain;
	}

	public void setMountain(Mountain mountain) {
		this.mountain = mountain;
	}

	public List<ChairLift> getLifts() {
		return lifts;
	}

	public void setLifts(List<ChairLift> lifts) {
		this.lifts = lifts;
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
		Trail other = (Trail) obj;
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
		builder.append("Trail [id=").append(id)
				.append(", name=").append(name)
				.append(", difficulty=").append(difficulty)
				.append(", length=").append(length)
				.append(", elevationGainLoss=").append(elevationGainLoss)
				.append(", features=").append(features)
				.append(", mountain=").append(mountain)
//				.append(", lifts=").append(lifts.toString())
//				.append(", reports=").append(reports.toString())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public Trail(int id, String name, Difficulty difficulty, Integer length, Integer elevationGainLoss, String features,
			Mountain mountain, List<ChairLift> lifts, List<Report> reports) {
		super();
		this.id = id;
		this.name = name;
		this.difficulty = difficulty;
		this.length = length;
		this.elevationGainLoss = elevationGainLoss;
		this.features = features;
		this.mountain = mountain;
		this.lifts = lifts;
		this.reports = reports;
	}

	public Trail() {
		super();
	}
	

	
}
