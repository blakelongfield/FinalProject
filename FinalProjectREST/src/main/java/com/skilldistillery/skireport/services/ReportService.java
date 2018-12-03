package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Report;

public interface ReportService {

	List<Report> findAll();
	
	List<Report> findByUsername(String username);
	
	List<Report> findByMountainName(String mtnName);
	
	List<Report> findByTrailName(String trailName);
	
	Report findById( Integer id);
	
	Report create( Report report);
	
	Report update( Integer rid, Report report);
	
	Boolean delete( Integer id);

}
