package com.skilldistillery.skireport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Report;

public interface ReportRepository extends JpaRepository<Report, Integer> {

}
