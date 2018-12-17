package com.skilldistillery.skireport.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.entities.Trail;
import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.MountainRepository;
import com.skilldistillery.skireport.repositories.TrailRepository;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class TrailServiceImpl implements TrailService {

	@Autowired
	private TrailRepository trailRepo;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private MountainRepository mountainRepo;

	@Override
	public List<Trail> findAll() {
		return trailRepo.findAllWhereActiveIsTrue();
	}
	
	@Override
	public List<Trail> sortBy( String searchParam, Integer mid) {
		
		List<Trail> trails = trailRepo.findByMountainId(mid);
		
		if( searchParam.equals("Name")) {
		TrailSortByName sort = new TrailSortByName();
		Collections.sort(trails, sort);
		}
		
		else if(searchParam.equals("Difficulty")) {
		TrailSortByDifficulty sortDiff = new TrailSortByDifficulty();
		Collections.sort(trails, sortDiff);
		}
		
		else if( searchParam.equals("Features")) {
			System.out.println(trails.size());
			List<Trail> featureList = new ArrayList<>();
			TrailSortByFeature sortFeature = new TrailSortByFeature();
			for (int i = 0; i < trails.size() -1; i++) {
				if(trails.get(i).getFeatures() != null ) {
					featureList.add(trails.get(i));
				}
			}
			trails = featureList;
			Collections.sort(trails, sortFeature);
		}
		return trails;
	}

	@Override
	public Trail findById(int trailId) {
		Trail findById = null;
		Optional<Trail> optionalTrail = trailRepo.findById(trailId);
		if (optionalTrail.isPresent()) {
			findById = optionalTrail.get();
		}
		return findById;
	}

	@Override
	public Trail create(Trail trail, int mountainId, String username) {
		Trail newTrail = null;
		Mountain findMountain = null;
		User user = userRepository.findByUsername(username);
		if (user != null) {
			if (user.getRole().equals("Admin")) {
				Optional<Mountain> optionalMountain = mountainRepo.findById(mountainId);
				if (optionalMountain.isPresent()) {
					findMountain = optionalMountain.get();
					trail.setMountain(findMountain);
					trail.setActive(true);
					newTrail = trailRepo.saveAndFlush(trail);
				}
			}
		}
		return newTrail;
	}

	@Override
	public Trail update(Trail trail, int trailId, String username) {
		Trail updateTrail = null;
		User user = userRepository.findByUsername(username);
		if (user != null) {
			if (user.getRole().equals("Admin")) {
				Optional<Trail> optionalTrail = trailRepo.findById(trailId);
				if (optionalTrail.isPresent()) {
					updateTrail = optionalTrail.get();
					updateTrail.setName(trail.getName());
					updateTrail.setDifficulty(trail.getDifficulty());
					updateTrail.setLength(trail.getLength());
					updateTrail.setElevationGainLoss(trail.getElevationGainLoss());
					updateTrail.setFeatures(trail.getFeatures());
					updateTrail = trailRepo.saveAndFlush(updateTrail);
				}
			}
		}
		return updateTrail;
	}

	@Override
	public Trail patch(Trail trail, int trailId, String username) {
		Trail updateTrail = null;
		User user = userRepository.findByUsername(username);
		if (user != null) {
			if (user.getRole().equals("Admin")) {
				Optional<Trail> optionalTrail = trailRepo.findById(trailId);
				if (optionalTrail.isPresent()) {
					updateTrail = optionalTrail.get();
					if (trail.getName() != null) {
						updateTrail.setName(trail.getName());
					}
					if (trail.getDifficulty() != null) {
						updateTrail.setDifficulty(trail.getDifficulty());
					}
					if (trail.getLength() != null) {
						updateTrail.setLength(trail.getLength());
					}
					if (trail.getElevationGainLoss() != null) {
						updateTrail.setElevationGainLoss(trail.getElevationGainLoss());
					}
					if (trail.getFeatures() != null) {
						updateTrail.setFeatures(trail.getFeatures());
					}
					updateTrail = trailRepo.saveAndFlush(updateTrail);
				}
			}
		}
		return updateTrail;
	}

	@Override
	public Boolean disable(int trailId, String username) {
		boolean disableTrail = false;
		Trail trailFound = null;
		User user = userRepository.findByUsername(username);
		if(user != null) {
			if(user.getRole().equals("Admin")) {
				Optional<Trail> optionalTrail = trailRepo.findById(trailId);
				if(optionalTrail.isPresent()) {
					trailFound = optionalTrail.get();
					for (int i = 0; i < trailFound.getReports().size()-1; i++) { 
						for (int j = 0; j < trailFound.getReports().get(i).getComment().size()-1; j++) {
							for (int j2 = 0; j2 < trailFound.getReports().get(i).getComment().get(j).getComments().size()-1; j2++) {
								trailFound.getReports().get(i).getComment().get(j).getComments().get(j2).setActive(false);
							}
							trailFound.getReports().get(i).getComment().get(j).setActive(false);
						}
						trailFound.getReports().get(i).setActive(false);
					}
					trailFound.setActive(false);
					disableTrail = true;
					trailRepo.saveAndFlush(trailFound);
					
				}
			}
		}
		return disableTrail;
	}

	@Override
	public Boolean destroy(int trailId, String username) {
		boolean destroy = false;
		User user = userRepository.findByUsername(username);
		if (user != null) {
			if (user.getRole().equals("Admin")) {
				if (trailRepo.existsById(trailId)) {
					trailRepo.deleteById(trailId);
					destroy = true;
				}
			}
		}
		return destroy;
	}

	@Override
	public List<Trail> findTrailsWithLiftsByMtnId(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}


//	@Override
//	public List<Trail> findTrailsWithLiftsByMtnId(Integer id) {
//		
//		return trailRepo.findTrailswithCLByMtnId(id);
//	}

	

}
