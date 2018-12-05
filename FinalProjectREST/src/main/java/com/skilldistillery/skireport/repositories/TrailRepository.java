package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.Trail;

public interface TrailRepository extends JpaRepository<Trail, Integer> {

	List<Trail> findByMountainId(Integer id);
	
	@Query("SELECT trail FROM Trail trail WHERE active = true")
	List<Trail> findAllWhereActiveIsTrue();
	
	@Query("SELECT tr FROM Trail tr JOIN FETCH Chairlift cl WHERE tr.mountain.id = :id")
	List<Trail> findTrailswithCLByMtnId( Integer id);
}


//select *
//from trail t
//	join chairlift_has_trail cht on cht.trail_id = t.id
//	join chairlift c on cht.chairlift_id = c.id
//  where t.mountain_id = 1;