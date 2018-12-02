package com.skilldistillery.skireport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.LiftType;

public interface LiftTypeRepository extends JpaRepository<LiftType, Integer> {

}
