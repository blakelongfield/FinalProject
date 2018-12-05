package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.Mountain;

public interface MountainRepository extends JpaRepository<Mountain, Integer> {

	@Query("SELECT mountain FROM Mountain mountain WHERE active = true")
	List<Mountain> findAllWhereActiveIsTrue();
}
