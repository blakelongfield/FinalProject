package com.skilldistillery.skireport.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.repositories.TrailRepository;

@Service
public class TrailServiceImpl implements TrailService {

	@Autowired
	private TrailRepository trailRepo;
}
