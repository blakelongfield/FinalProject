package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Report;

public interface ReportService {

	List<Report> findAll();
	
	List<Report> findByUserId(Integer uid);
	
	List<Report> findByMountainId(Integer mid);
	
	List<Report> findByTrailId(Integer tid);
	
	Report findById( Integer id);
	
	Report create( Report report, String username, Integer trailId, Integer mountainId);
	
	Report update( Integer rid, Report report, String username);
	
	Boolean delete( Integer id);

}
