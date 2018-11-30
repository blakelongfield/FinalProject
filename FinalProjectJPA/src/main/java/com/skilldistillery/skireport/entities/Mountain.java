package com.skilldistillery.skireport.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Mountain {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private Integer numberOfLifts;
	
	private Integer numberOfRuns;
	
	private Integer baseElevation;
	
	private Integer peakElevation;
	
	private String imgUrl;

}
