package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.ChairLift;
import com.skilldistillery.skireport.entities.Report;

public interface ReportRepository extends JpaRepository<Report, Integer> {
	
	List<Report> findByUserId(Integer uid);
	
	List<Report> findByTrailId(Integer tid);
	
	List<Report> findByMountainId(Integer mid);
	
	@Query("SELECT report FROM Report report WHERE active = true")
	List<Report> findAllWhereActiveIsTrue();
}
