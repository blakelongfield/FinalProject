package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Resort;
import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.ResortRepository;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class ResortServiceImpl implements ResortService {
	@Autowired
	private ResortRepository resortRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Resort> findAll() {
		List<Resort> resorts = resortRepo.findAllWhereActiveIsTrue();
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
		if (username != null) {
			resort.setActive(true);
			resortRepo.saveAndFlush(resort);
		}
		return resort;
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

	@Override
	public Boolean disable(int resortId, String username) {
		Boolean disableResort = false;
		Resort resortFound = null;
		User user = userRepo.findByUsername(username);
		if(user != null) {
			if(user.getRole().equals("Admin")) {
				Optional<Resort> optionalResort = resortRepo.findById(resortId);
				if(optionalResort.isPresent()) {
					resortFound = optionalResort.get();
					for (int h = 0; h < resortFound.getMountains().size()-1; h++) { // get mountains on resort
						for (int h2 = 0; h2 < resortFound.getMountains().get(h).getReports().size()-1; h2++) { // get reports on mountains on resort
							resortFound.getMountains().get(h).getReports().get(h2).setActive(false);
						}
						for (int h3 = 0; h3 < resortFound.getMountains().get(h).getChairlifts().size()-1; h3++) {
							resortFound.getMountains().get(h).getChairlifts().get(h3).setActive(false);
						}
						for (int i = 0; i < resortFound.getMountains().get(h).getTrails().size()-1; i++) { //get trails on mountain on resort
							for (int j = 0; j < resortFound.getMountains().get(h).getTrails().get(i).getReports().size()-1; j++) { // get reports on trails on mountain on resort
								for (int j2 = 0; j2 < resortFound.getMountains().get(h).getTrails().get(i).getReports().get(j).getComment().size()-1; j2++) { // get comments on reports on trails on mountain on resort
									for (int k = 0; k < resortFound.getMountains().get(h).getTrails().get(i).getReports().get(j).getComment().get(j2).getComments().size()-1; k++) { // get comments on comments on reports on trails on mountain
										resortFound.getMountains().get(h).getTrails().get(i).getReports().get(j).getComment().get(j2).getComments().get(k).setActive(false);
									}
									resortFound.getMountains().get(h).getTrails().get(i).getReports().get(j).getComment().get(j2).setActive(false);
								}
								resortFound.getMountains().get(h).getTrails().get(i).getReports().get(j).setActive(false);;
							}
							resortFound.getMountains().get(h).getTrails().get(i).setActive(false);
						}
						resortFound.getMountains().get(h).setActive(false);
					}
					resortFound.setActive(false);
					disableResort = true;
					resortRepo.saveAndFlush(resortFound);
				}
			}
		}
		return disableResort;
	}

	@Override
	public Boolean destroy(int resortId, String username) {
		Boolean deletedResort = false;
		if (resortRepo.existsById(resortId)) {
			resortRepo.deleteById(resortId);
			deletedResort = true;			
		}
		return deletedResort;
	}

}
