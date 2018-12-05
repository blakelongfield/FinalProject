package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.Resort;

public interface ResortRepository extends JpaRepository<Resort, Integer> {

	@Query("SELECT resort FROM Resort resort WHERE active = true")
	List<Resort> findAllWhereActiveIsTrue();
}
