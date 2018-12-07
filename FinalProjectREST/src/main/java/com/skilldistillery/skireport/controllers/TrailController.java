package com.skilldistillery.skireport.controllers;

import java.security.Principal;
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
@CrossOrigin({ "*", "http://localhost:4205" })
public class TrailController {

	@Autowired
	private TrailService trailService;

	/*
	 * TO BE REMOVED WHEN WE ADD SECURITY
	 */
//	private String username = "zach";

	/*
	 * Get methods can be accessed by anybody. Other methods require you to be an
	 * admin.
	 */
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
	
	@GetMapping("trails/sort/{mid}/{search}")
	public List<Trail> sortBy( @PathVariable("search") String search, @PathVariable("mid") Integer mid) {
		return trailService.sortBy(search, mid);
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
	
	@GetMapping("trails/mountains/{mid}")
	public List<Trail> trailswithliftbyMTNId( @PathVariable("mid") Integer mid) {
		
		return trailService.findTrailsWithLiftsByMtnId(mid);
	}
	
	
	

	@PostMapping("admin/trails/mountains/{mountainId}")
	public Trail create(@RequestBody Trail trail, @PathVariable("mountainId") int mountainId, HttpServletResponse resp,
			HttpServletRequest req, Principal principal) {
		Trail newTrail = null;
		System.out.println(trail);
		newTrail = trailService.create(trail, mountainId, principal.getName());
		if (newTrail == null) {
			resp.setStatus(400);
		} else {
			resp.setStatus(201);
			String newResourceUrl = req.getRequestURL() + "/" + newTrail.getId();
			resp.setHeader("Locaion", newResourceUrl);
		}
		return newTrail;
	}

	@PutMapping("admin/trails/{trailId}")
	public Trail update(@RequestBody Trail trail, @PathVariable("trailId") int trailId, HttpServletResponse resp, Principal principal) {
		Trail updateTrail = null;
		updateTrail = trailService.update(trail, trailId, principal.getName());
		if (updateTrail != null) {
			resp.setStatus(202);
		} else {
			resp.setStatus(400);
		}
		return updateTrail;
	}

	@PatchMapping("admin/trails/{trailId}")
	public Trail patch(@RequestBody Trail trail, @PathVariable("trailId") int trailId, HttpServletResponse resp, Principal principal) {
		Trail patchTrail = null;
		patchTrail = trailService.patch(trail, trailId, principal.getName());
		if (patchTrail != null) {
			resp.setStatus(202);
		} else {
			resp.setStatus(400);
		}
		return patchTrail;
	}
	
	@DeleteMapping("admin/trails/disable/{trailId}")
	public Boolean disable(@PathVariable("trailId") int trailId, HttpServletResponse resp, Principal principal) {
		Boolean disableTrail = null;
		disableTrail = trailService.disable(trailId, principal.getName());
		if (disableTrail) {
			resp.setStatus(200);
		} else {
			resp.setStatus(400);
		}
		return disableTrail;
	}

	@DeleteMapping("admin/trails/{trailId}")
	public Boolean destroy(@PathVariable("trailId") int trailId, HttpServletResponse resp, Principal principal) {
		Boolean destroyTrail = null;
		destroyTrail = trailService.destroy(trailId, principal.getName());
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
