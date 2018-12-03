package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.ChairLift;

public interface ChairLiftService {
	List<ChairLift> findAll();
	
	ChairLift findById( Integer id);
	
	ChairLift create( ChairLift chairLift, Integer liftTypeId);
	
	ChairLift update(Integer cid,ChairLift chairLift );
	
	Boolean delete( Integer id);

}
