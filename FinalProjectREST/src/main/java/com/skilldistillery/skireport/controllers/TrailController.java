package com.skilldistillery.skireport.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.services.TrailService;

@RestController
@RequestMapping("api")
public class TrailController {

	@Autowired
	private TrailService trailService;
	
	@GetMapping("ping")
	public String ping() {
		return "pong";
	}
}
