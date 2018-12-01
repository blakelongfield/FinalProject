package com.skilldistillery.skireport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Trail;

public interface TrailRepository extends JpaRepository<Trail, Integer> {

}
