package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.ChairLift;

public interface ChairLiftRepository extends JpaRepository<ChairLift, Integer> {

	@Query("SELECT chairlift FROM ChairLift chairlift WHERE active = true")
	List<ChairLift> findAllWhereActiveIsTrue();
}
