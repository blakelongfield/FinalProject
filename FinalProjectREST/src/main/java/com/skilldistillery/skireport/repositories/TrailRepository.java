package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.Trail;

public interface TrailRepository extends JpaRepository<Trail, Integer> {

	List<Trail> findByMountainId(Integer id);
	
	@Query("SELECT trail FROM Trail trail WHERE active = true")
	List<Trail> findAllWhereActiveIsTrue();
}
