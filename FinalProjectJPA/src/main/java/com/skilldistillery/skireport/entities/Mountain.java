package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Mountain {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name="number_of_trails")
	private Integer numberOfRuns;
	
	@Column(name="number_of_lifts")
	private Integer numberOfLifts;
	
	@Column(name="elevation_base")
	private Integer baseElevation;
	
	@Column(name="elevation_peak")
	private Integer peakElevation;
	
	@Column(name="average_annual_snowfall")
	private Integer averageAnnualSnowfall;
	
	@Column(name="mountain_map_url")
	private String imgUrl;
	
	private Boolean active;
	
	@JsonIgnore
//	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@ManyToOne
	@JoinColumn(name="resort_id")
	private Resort resort;
	
	@JsonIgnore
	@OneToMany(mappedBy="mountain", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	private List<Report> reports;
	
//	@JsonBackReference(value="mountainToTrail")
	//@JsonIgnore
	@OneToMany(mappedBy="mountain", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	private List<Trail> trails;
	
	@OneToMany(mappedBy="mountain")
	private List<ChairLift> chairlifts;

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

	public Integer getNumberOfRuns() {
		return numberOfRuns;
	}

	public void setNumberOfRuns(Integer numberOfRuns) {
		this.numberOfRuns = numberOfRuns;
	}

	public Integer getNumberOfLifts() {
		return numberOfLifts;
	}

	public void setNumberOfLifts(Integer numberOfLifts) {
		this.numberOfLifts = numberOfLifts;
	}

	public Integer getBaseElevation() {
		return baseElevation;
	}

	public void setBaseElevation(Integer baseElevation) {
		this.baseElevation = baseElevation;
	}

	public Integer getPeakElevation() {
		return peakElevation;
	}

	public void setPeakElevation(Integer peakElevation) {
		this.peakElevation = peakElevation;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public Resort getResort() {
		return resort;
	}

	public void setResort(Resort resort) {
		this.resort = resort;
	}

	public List<Report> getReports() {
		return reports;
	}

	public void setReports(List<Report> reports) {
		this.reports = reports;
	}

	public List<Trail> getTrails() {
		return trails;
	}

	public void setTrails(List<Trail> trails) {
		this.trails = trails;
	}

	public List<ChairLift> getChairlifts() {
		return chairlifts;
	}

	public void setChairlifts(List<ChairLift> chairlifts) {
		this.chairlifts = chairlifts;
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
		Mountain other = (Mountain) obj;
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
		builder.append("Mountain [id=").append(id)
				.append(", name=").append(name)
				.append(", numberOfRuns=").append(numberOfRuns)
				.append(", numberOfLifts=").append(numberOfLifts)
				.append(", baseElevation=").append(baseElevation)
				.append(", peakElevation=").append(peakElevation)
				.append(", imgUrl=").append(imgUrl)
				.append(", active=").append(active)
//				.append(", resort=").append(resort)
//				.append(", reports=").append(reports.size())
//				.append(", trails=").append(trails.size())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public Mountain() {
		super();
	}

	public Mountain(int id, String name, Integer numberOfRuns, Integer numberOfLifts, Integer baseElevation,
			Integer peakElevation, String imgUrl, Resort resort, List<Report> reports, List<Trail> trails) {
		super();
		this.id = id;
		this.name = name;
		this.numberOfRuns = numberOfRuns;
		this.numberOfLifts = numberOfLifts;
		this.baseElevation = baseElevation;
		this.peakElevation = peakElevation;
		this.imgUrl = imgUrl;
		this.resort = resort;
		this.reports = reports;
		this.trails = trails;
	}

	public Integer getAverageAnnualSnowfall() {
		return averageAnnualSnowfall;
	}

	public void setAverageAnnualSnowfall(Integer averageAnnualSnowfall) {
		this.averageAnnualSnowfall = averageAnnualSnowfall;
	}
 
	
}
