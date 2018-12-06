package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.entities.Resort;
import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.MountainRepository;
import com.skilldistillery.skireport.repositories.ResortRepository;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class MountainServiceImpl implements MountainService {

	@Autowired
	private MountainRepository mountRepo;

	@Autowired
	private ResortRepository resortRepo;

	@Autowired
	private UserRepository userRepo;

//	Lists all mountains
	@Override
	public List<Mountain> findAll() {

		return mountRepo.findAllWhereActiveIsTrue();
	}

//	Lists mountain by ID
	@Override
	public Mountain findById(Integer id) {
		Optional<Mountain> opt = mountRepo.findById(id);
		Mountain mountId = opt.get();

		return mountId;
	}

//	 Creates a new mountain
	@Override
	public Mountain create(Mountain mountain, Integer resortId, String username) {
		System.out.println(mountain);
		Mountain newMountain = null;
		User user = userRepo.findByUsername(username);
		if (user != null) {
			if (user.getRole().equals("Admin")) {
				Optional<Resort> resortOpt = resortRepo.findById(resortId);
				Resort resort = resortOpt.get();
				mountain.setResort(resort);
				mountain.setActive(true);
				newMountain = mountRepo.saveAndFlush(mountain);
			}
		}
		return newMountain;
	}

	@Override
	public Mountain update(Mountain mountain, Integer mountainId, String username) {
		Mountain updateMountain = null;
		User user = userRepo.findByUsername(username);
		
		System.out.println("In mountain update");
		
		
		if(user != null) {
			System.out.println("In user");
			if( user.getRole().equals("Admin")) {
				System.out.println("In user role");
				
				Optional<Mountain> mountOpt = mountRepo.findById(mountainId);
				if(mountOpt.isPresent()) {
					updateMountain = mountOpt.get();
					System.out.println("Found mountain" + updateMountain);
					
					if(mountain.getName() != null) {
						updateMountain.setName(mountain.getName());
						System.out.println(updateMountain.getName());
						
					}
					
					if(mountain.getNumberOfRuns() != null) {
						updateMountain.setNumberOfRuns(mountain.getNumberOfRuns());
						
					}
					
					if(mountain.getNumberOfLifts() != null) {
						updateMountain.setNumberOfLifts(mountain.getNumberOfLifts());
					}
					
					if(mountain.getBaseElevation() != null) {
						updateMountain.setBaseElevation(mountain.getBaseElevation());
					}
					
					if(mountain.getPeakElevation() != null) {
						updateMountain.setPeakElevation(mountain.getPeakElevation());
					}
					
					if(mountain.getImgUrl() != null) {
						updateMountain.setImgUrl(mountain.getImgUrl());
					}
					
					mountRepo.saveAndFlush(updateMountain);
					
					
				}
				
			}
		}
		return updateMountain;
	}

	@Override
	public Boolean disable(int mountainId, String username) {
		Boolean disableMountain = false;
		Mountain mountainFound = null;
		User user = userRepo.findByUsername(username);
		if(user != null) {
			if(user.getRole().equals("Admin")) {
				Optional<Mountain> optionalMountain = mountRepo.findById(mountainId);
				if(optionalMountain.isPresent()) {
					mountainFound = optionalMountain.get();
					for (int h = 0; h < mountainFound.getReports().size()-1; h++) { // get reports on mountain
						mountainFound.getReports().get(h).setActive(false);
					}
					for (int h2 = 0; h2 < mountainFound.getChairlifts().size()-1; h2++) { // get chairlifts on mountain
						mountainFound.getReports().get(h2).setActive(false);
					}
					for (int i = 0; i < mountainFound.getTrails().size()-1; i++) { //get trails on mountain
						for (int j = 0; j < mountainFound.getTrails().get(i).getReports().size()-1; j++) { // get reports on trails on mountain
							for (int j2 = 0; j2 < mountainFound.getTrails().get(i).getReports().get(j).getComment().size()-1; j2++) { // get comments on reports on trails on mountain
								for (int k = 0; k < mountainFound.getTrails().get(i).getReports().get(j).getComment().get(j2).getComments().size()-1; k++) { // get comments on comments on reports on trails on mountain
									mountainFound.getTrails().get(i).getReports().get(j).getComment().get(j2).getComments().get(k).setActive(false);
								}
								mountainFound.getTrails().get(i).getReports().get(j).getComment().get(j2).setActive(false);
							}
							mountainFound.getTrails().get(i).getReports().get(j).setActive(false);;
						}
						mountainFound.getTrails().get(i).setActive(false);
					}
					mountainFound.setActive(false);
					disableMountain = true;
					mountRepo.saveAndFlush(mountainFound);
				}
			}
		}
		return disableMountain;
	}

	@Override
	public Boolean destroy(Integer mountainId, String username) {
		Boolean deleteMountain = false;
		
		User user = userRepo.findByUsername(username);
		
		if(user!= null) {
			if(user.getRole().equals("Admin")) {
				if(mountRepo.existsById(mountainId)) {
					mountRepo.deleteById(mountainId);
					deleteMountain = true;
					
				}
			}
		}
		
		return deleteMountain;
	}


	

}
