package com.skilldistillery.skireport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Mountain;

public interface MountainRepository extends JpaRepository<Mountain, Integer> {

}
