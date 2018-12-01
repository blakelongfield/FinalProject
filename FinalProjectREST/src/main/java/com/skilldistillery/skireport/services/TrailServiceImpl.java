package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Trail;
import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.TrailRepository;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class TrailServiceImpl implements TrailService {

	@Autowired
	private TrailRepository trailRepo;
	@Autowired
	private UserRepository userRepository;

	@Override
	public List<Trail> findAll() {
		return trailRepo.findAll();
	}

	@Override
	public Trail findById(int trailId) {
		Trail findById = null; 
		Optional<Trail> optionalTrail = trailRepo.findById(trailId);
		if(optionalTrail.isPresent()) {
			findById = optionalTrail.get();
		}
		return findById;
	}

	@Override
	public Trail create(Trail trail) {
		Trail newTrail = null;
			newTrail = trailRepo.saveAndFlush(newTrail);
		return newTrail;
	}
	
	
}
