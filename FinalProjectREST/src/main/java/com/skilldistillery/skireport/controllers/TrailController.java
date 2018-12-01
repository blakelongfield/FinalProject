package com.skilldistillery.skireport.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.Trail;
import com.skilldistillery.skireport.services.TrailService;

@RestController
@RequestMapping("api")
public class TrailController {

	@Autowired
	private TrailService trailService;
	
	/*
	 * TO BE REMOVED
	 */
	private String username = "zach";
	
	@GetMapping("trails")
	public List<Trail> index(HttpServletResponse resp) {
		List<Trail> trails = null;
		trails = trailService.findAll();
		System.out.println(trails);
		if(trails.isEmpty()) {
			resp.setStatus(404);
		}
		return trails;
	}
	
	@GetMapping("trails/{trailId}")
	public Trail findTrailById(@PathVariable("trailId") int trailId, HttpServletResponse resp) {
		Trail trail = null;
		trail = trailService.findById(trailId);
		if(trail == null) {
			resp.setStatus(404);
		}
		return trail;
	}
	
	@PostMapping("trails")
	public Trail create(@RequestBody Trail trail, HttpServletResponse resp, HttpServletRequest req) {
		Trail newTrail = null;
		newTrail = trailService.create(trail, username);
		if(newTrail == null) {
			resp.setStatus(400);
		} else {
			resp.setStatus(201);
			String newResourceUrl = req.getRequestURL() + "/" + newTrail.getId();
			resp.setHeader("Locaion", newResourceUrl);
		}
		return newTrail;
	}
	
	@GetMapping("ping")
	public String ping() {
		return "pong";
	}
}
