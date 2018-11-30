package com.skilldistillery.skireport.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.Columns;

@Entity
public class Mountain {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name="number_of_lifts")
	private Integer numberOfLifts;
	
	@Column(name="number_of_trails")
	private Integer numberOfRuns;
	
	@Column(name="elevation_base")
	private Integer baseElevation;
	
	@Column(name="elevation_peak")
	private Integer peakElevation;
	
	@Column(name="mountain_map_url")
	private String imgUrl;

	public Mountain() {
		super();
	}

	public Mountain(int id, String name, Integer numberOfLifts, Integer numberOfRuns, Integer baseElevation,
			Integer peakElevation, String imgUrl) {
		super();
		this.id = id;
		this.name = name;
		this.numberOfLifts = numberOfLifts;
		this.numberOfRuns = numberOfRuns;
		this.baseElevation = baseElevation;
		this.peakElevation = peakElevation;
		this.imgUrl = imgUrl;
	}

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

	public Integer getNumberOfLifts() {
		return numberOfLifts;
	}

	public void setNumberOfLifts(Integer numberOfLifts) {
		this.numberOfLifts = numberOfLifts;
	}

	public Integer getNumberOfRuns() {
		return numberOfRuns;
	}

	public void setNumberOfRuns(Integer numberOfRuns) {
		this.numberOfRuns = numberOfRuns;
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

	@Override
	public String toString() {
		return "Mountain [id=" + id + ", name=" + name + ", numberOfLifts=" + numberOfLifts + ", numberOfRuns="
				+ numberOfRuns + ", baseElevation=" + baseElevation + ", peakElevation=" + peakElevation + ", imgUrl="
				+ imgUrl + "]";
	}
}
