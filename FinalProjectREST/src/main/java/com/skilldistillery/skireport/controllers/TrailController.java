package com.skilldistillery.skireport.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.Trail;
import com.skilldistillery.skireport.services.TrailService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4201" })
public class TrailController {

	@Autowired
	private TrailService trailService;

	/*
	 * TO BE REMOVED WHEN WE ADD SECURITY
	 */
	private String username = "zach";

	@GetMapping("trails")
	public List<Trail> index(HttpServletResponse resp) {
		List<Trail> trails = null;
		trails = trailService.findAll();
		System.out.println(trails);
		if (trails.isEmpty()) {
			resp.setStatus(404);
		}
		return trails;
	}

	@GetMapping("trails/{trailId}")
	public Trail findTrailById(@PathVariable("trailId") int trailId, HttpServletResponse resp) {
		Trail trail = null;
		trail = trailService.findById(trailId);
		if (trail == null) {
			resp.setStatus(404);
		}
		return trail;
	}

	@PostMapping("trails")
	public Trail create(@RequestBody Trail trail, HttpServletResponse resp, HttpServletRequest req) {
		Trail newTrail = null;
		newTrail = trailService.create(trail, username);
		if (newTrail == null) {
			resp.setStatus(400);
		} else {
			resp.setStatus(201);
			String newResourceUrl = req.getRequestURL() + "/" + newTrail.getId();
			resp.setHeader("Locaion", newResourceUrl);
		}
		return newTrail;
	}

	@PutMapping("trails/{trailId}")
	public Trail update(@RequestBody Trail trail, @PathVariable("trailId") int trailId, HttpServletResponse resp) {
		Trail updateTrail = null;
		updateTrail = trailService.update(trail, trailId, username);
		if (updateTrail != null) {
			resp.setStatus(202);
		} else {
			resp.setStatus(400);
		}
		return updateTrail;
	}

	@PatchMapping("trails/{trailId}")
	public Trail patch(@RequestBody Trail trail, @PathVariable("trailId") int trailId, HttpServletResponse resp) {
		Trail patchTrail = null;
		patchTrail = trailService.patch(trail, trailId, username);
		if (patchTrail != null) {
			resp.setStatus(202);
		} else {
			resp.setStatus(400);
		}
		return patchTrail;
	}

	@DeleteMapping("trails/{trailId}")
	public Boolean destroy(@PathVariable("trailId") int trailId, HttpServletResponse resp) {
		Boolean destroyTrail = null;
		destroyTrail = trailService.destroy(trailId, username);
		if (destroyTrail) {
			resp.setStatus(200);
		} else {
			resp.setStatus(400);
		}
		return destroyTrail;
	}

	@GetMapping("ping")
	public String ping() {
		return "pong";
	}
}
