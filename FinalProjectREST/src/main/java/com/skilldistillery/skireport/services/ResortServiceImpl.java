package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.entities.Resort;
import com.skilldistillery.skireport.repositories.MountainRepository;
import com.skilldistillery.skireport.repositories.ResortRepository;

@Service
public class ResortServiceImpl implements ResortService {
	@Autowired
	private ResortRepository resortRepo;
	@Autowired
	private MountainRepository mountainRepo;

	@Override
	public List<Resort> findAll() {
		List<Resort> resorts = resortRepo.findAll();
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

	//doesn't work yet. Need to figure out how to create a mountain first
	@Override
	public Resort create(Resort resort, String username) {
		Resort newResort = null;
		if (username != null) {
			
		}
		return newResort;
	}

	@Override
	public Resort update(Resort resort, int resortId, String username) {
		Resort managedResort = null;
		Optional<Resort> resortOpt = resortRepo.findById(resortId);
		if (resortOpt.isPresent()) {
			managedResort = resortOpt.get();
			managedResort.setName(resort.getName());
			managedResort.setStreet(resort.getStreet());
			managedResort.setStreet2(resort.getStreet2());
			managedResort.setCity(resort.getCity());
			managedResort.setState(resort.getState());
			managedResort.setZip(resort.getZip());
			managedResort.setAcres(resort.getAcres());
			resortRepo.saveAndFlush(managedResort);
		}
		return managedResort;
	}

	//doesn't work yet. Need to delete/persist the mountains first? 
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
