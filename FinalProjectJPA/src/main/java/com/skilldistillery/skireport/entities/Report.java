package com.skilldistillery.skireport.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Report {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private Integer rating;
	
	private Integer votes;
	
	private String imgUrl;
	
	@Temporal(TemporalType.DATE)
	@CreationTimestamp
	private Integer dateCreated;
}
