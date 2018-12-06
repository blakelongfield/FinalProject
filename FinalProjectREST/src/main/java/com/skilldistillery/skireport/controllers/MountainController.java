package com.skilldistillery.skireport.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.services.MountainService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class MountainController {

	@Autowired
	private MountainService mountServ;

//	private String username = "zach";

//	Lists all mountains
	@RequestMapping(path = "mountains", method = RequestMethod.GET)
	public List<Mountain> index() {

		List<Mountain> mountains = mountServ.findAll();

		return mountains;

	}

//	Finds mountain by ID
	@RequestMapping(path = "mountains/{id}", method = RequestMethod.GET)
	public Mountain findById(@PathVariable("id") Integer id, HttpServletResponse resp) {

		Mountain mountById = mountServ.findById(id);
		if (mountById == null) {
			resp.setStatus(404);
		} else {
			resp.setStatus(200);
		}

		return mountById;

	}

//	Creates a new mountain
	@RequestMapping(path = "mountains/resorts/{resortId}", method = RequestMethod.POST)
	public Mountain createMountain(@RequestBody Mountain mountain, @PathVariable("resortId") int resortId, HttpServletResponse resp, HttpServletRequest req, Principal principal) {

		System.out.println("In create mountain" + mountain);
		// will need to pull in resort id
		Mountain newMountain = mountServ.create(mountain, resortId, principal.getName());
		System.out.println("After create mountain" + newMountain);
		if (newMountain == null) {
			resp.setStatus(404);
		} else {
			resp.setStatus(201);
			String newUrl = req.getRequestURL() + "/" + mountain.getId();
			resp.setHeader("Location", newUrl);
		}

		return newMountain;

	}
	
//	Updates mountain (patch)
	@RequestMapping(path="mountains/{id}", method=RequestMethod.PATCH)
	public Mountain updateMountain(@RequestBody Mountain mountain, @PathVariable ("id") Integer mountainId,
			HttpServletResponse resp, Principal principal) {
		
		Mountain updatedMountain = mountServ.update(mountain, mountainId, principal.getName());
		System.out.println(updatedMountain);
		
		if(updatedMountain != null) {
			resp.setStatus(201);
		}
		else {
			resp.setStatus(404);
		}
		
		return updatedMountain;
		
	}
	
	@DeleteMapping("mountains/disable/{mountainId}")
	public Boolean disableMountain(@PathVariable("mountainId") int mountainId, HttpServletResponse resp, Principal principal) {
		Boolean disableMountain = null;
		disableMountain = mountServ.disable(mountainId, principal.getName());
		if(disableMountain) {
			resp.setStatus(200);
		} else {
			resp.setStatus(404);
		}
		return disableMountain;
	}
	
//	Deletes mountain
	@RequestMapping(path="mountains/{id}", method=RequestMethod.DELETE)
	public Boolean deleteMountain(@PathVariable ("id") Integer mountainId, HttpServletResponse resp, Principal principal) {
		Boolean deletedMountain = null;
		
		deletedMountain = mountServ.destroy(mountainId, principal.getName());
		
		if(deletedMountain) {
			resp.setStatus(200);
			resp.setHeader("Message", "Mountain successfully deleted");
		}
		else {
			resp.setStatus(404);
			resp.setHeader("Message", "Error deleting mountain");
		}
		
		return deletedMountain;
		
	}
	
	

}
