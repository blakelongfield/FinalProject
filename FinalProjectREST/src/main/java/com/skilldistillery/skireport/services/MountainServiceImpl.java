package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.repositories.MountainRepository;

@Service
public class MountainServiceImpl implements MountainService {
	
	@Autowired
	private MountainRepository mountRepo;

//	Lists all mountains
	@Override
	public List<Mountain> findAll() {
		
		return mountRepo.findAll();
	}

//	Lists mountain by ID
	@Override
	public Mountain findById(Integer id) {
		Optional<Mountain> opt = mountRepo.findById(id);
		Mountain mountId = opt.get();
		
		return mountId;
	}
	


}
