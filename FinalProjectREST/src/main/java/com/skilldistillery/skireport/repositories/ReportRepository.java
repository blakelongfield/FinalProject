package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Report;

public interface ReportRepository extends JpaRepository<Report, Integer> {
	
	List<Report> findByUserId(Integer uid);
	
	List<Report> findByTrailId(Integer tid);
	
	List<Report> findByMountainReportsId(Integer mid);
}
