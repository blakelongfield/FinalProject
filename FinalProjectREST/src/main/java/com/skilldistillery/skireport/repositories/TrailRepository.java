package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Trail;

public interface TrailRepository extends JpaRepository<Trail, Integer> {

	List<Trail> findByMountainId(Integer id);
}
