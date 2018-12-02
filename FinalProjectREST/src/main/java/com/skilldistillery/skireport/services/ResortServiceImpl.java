package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Resort;
import com.skilldistillery.skireport.repositories.ResortRepository;

@Service
public class ResortServiceImpl implements ResortService {
	@Autowired
	private ResortRepository resortRepo;
	
	@Override
	public List<Resort> findAll() {
		List <Resort> resorts = resortRepo.findAll();
		return resorts;
	}

	@Override
	public Resort findById(int resortId) {
		Resort resort = null;
		Optional<Resort> resortOpt = resortRepo.findById(resortId);
		if (resortOpt.isPresent()) {
			resort = resortOpt.get();
		}
		return resort;
	}

	@Override
	public Resort create(Resort resort, String username) {
		
		return null;
	}

	@Override
	public Resort update(Resort resort, int resortId, String username) {

		return null;
	}

	@Override
	public Boolean destroy(int resortId, String username) {	
		Boolean deletedResort = false;
		Resort resort = null;
		Optional<Resort> resortOpt = resortRepo.findById(resortId);
		if (resortOpt.isPresent()) {
			resort = resortOpt.get();
			resortRepo.deleteById(resortId);
			deletedResort = true;
		}
		return deletedResort;
	}

}
