package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.ChairLift;
import com.skilldistillery.skireport.entities.LiftType;
import com.skilldistillery.skireport.repositories.ChairLiftRepository;
import com.skilldistillery.skireport.repositories.LiftTypeRepository;

@Service
public class ChairLiftServiceImpl implements ChairLiftService {
	
	@Autowired
	ChairLiftRepository repo;
	@Autowired
	LiftTypeRepository ltRepo;

	//FIND ALL CHAIRLIFTS
	@Override
	public List<ChairLift> findAll() {
		
		return repo.findAll();
	}

	//FIND CHAIRLIFT BY ID
	@Override
	public ChairLift findById(Integer id) {
		Optional<ChairLift> opt = repo.findById(id);
		return opt.get();
	}

	//CREATE NEW CHAIR LIFT
	@Override
	public ChairLift create(ChairLift chairLift, Integer liftTypeId) {
		
		Optional<LiftType> opt = ltRepo.findById(liftTypeId);
				LiftType lt = opt.get();
			
		if( chairLift != null) {
			chairLift.setType(lt);
			repo.saveAndFlush( chairLift );
		}
		return chairLift;
	}

	// UPDATE CHAIRLIFT
	@Override
	public ChairLift update(Integer cid, ChairLift chairLift) {
		
		ChairLift mChairLift = findById(cid);
		if( mChairLift != null && chairLift != null) {
			
			if( chairLift.getName() != null ) {
				mChairLift.setName(chairLift.getName());
			}
			if( chairLift.getHours() != null) {
				mChairLift.setHours(chairLift.getHours());
			}
			if( chairLift.getType() != null) {
				mChairLift.setType(chairLift.getType());
			}
			if( chairLift.getRideLength() != null ) {
				mChairLift.setRideLength(chairLift.getRideLength());
			}
		}
		
		repo.saveAndFlush(mChairLift);
		return mChairLift;
	}

	//DELETE CHAIRLIFT
	@Override
	public Boolean delete(Integer id) {
		
		Boolean deleted = false;
		Optional<ChairLift> opt = repo.findById(id);
		ChairLift chairList = opt.get();

		if (opt != null) {
			repo.delete(chairList);
			Optional<ChairLift> opt2 = repo.findById(id);
			if (!opt2.isPresent()) {
				deleted = true;
			}
		}
		return deleted;
	}

}
