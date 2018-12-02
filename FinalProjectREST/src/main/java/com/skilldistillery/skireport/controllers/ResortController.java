package com.skilldistillery.skireport.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.Resort;
import com.skilldistillery.skireport.services.ResortService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class ResortController {
	@Autowired
	private ResortService resortService;

	//hard-coded until we start using Angular
	private String username = "blake";

	@GetMapping(path = "resorts")
	public List<Resort> findAllResorts(HttpServletResponse resp, HttpServletRequest req) {
		List<Resort> resorts = resortService.findAll();
		if (resorts.isEmpty()) {
			resp.setStatus(404);
		}
		return resorts;
	}

	@GetMapping(path = "resorts/{resortId}")
	public Resort findResortById(@PathVariable("resortId") int resortId, HttpServletResponse resp,
			HttpServletRequest req) {
		Resort resort = resortService.findById(resortId);
		if (resort == null) {
			resp.setStatus(404);
		}
		return resort;
	}

	@PostMapping(path = "resorts")
	public Resort createResort(@RequestBody Resort resort, HttpServletResponse resp, HttpServletRequest req) {
		resort = resortService.create(resort, username);
		if (resort == null) {
			resp.setStatus(400);
		} else {
			resp.setStatus(201);
		}
		return resort;
	}

	@PutMapping(path = "resorts/{resortId}")
	public Resort updateResort(@RequestBody Resort resort, @PathVariable("resortId") int resortId,
			HttpServletResponse resp, HttpServletRequest req) {
		resort = resortService.update(resort, resortId, username);
		if (resort != null) {
			resp.setStatus(202);
		} else {
			resp.setStatus(400);
		}
		return resort;
	}

	@DeleteMapping(path = "resorts/{resortId}")
	public Boolean deleteResort(@PathVariable("resortId") int resortId, HttpServletResponse resp,
			HttpServletRequest req) {
		Boolean deletedResort = resortService.destroy(resortId, username);
		if (deletedResort == true) {
			resp.setStatus(200);
		} else {
			resp.setStatus(400);
		}
		return deletedResort;
	}

}