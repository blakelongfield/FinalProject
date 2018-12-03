package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Report;

public interface ReportRepository extends JpaRepository<Report, Integer> {
	
	List<Report> findByUserUsername(String username);
	
	List<Report> findByTrailName(String trailName);
	
	List<Report> findByMountainReportsName(String mtnName);
}
