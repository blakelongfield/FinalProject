package com.skilldistillery.skireport.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.services.MountainService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost:4205"})

public class MountainController {
	
	@Autowired
	private MountainService mountServ;
	
	
//	Lists all mountains
	@RequestMapping(path="mountains", method=RequestMethod.GET)
	public List<Mountain> index() {
		
		List<Mountain> mountains = mountServ.findAll();
		
		return mountains;
		
	}
	
	
//	Finds mountain by ID
	@RequestMapping(path="mountains/{id}", method=RequestMethod.GET)
	public Mountain findById(@PathVariable ("id") Integer id, HttpServletResponse resp) {
		
		Mountain mountById = mountServ.findById(id);
		if(mountById == null) {
			resp.setStatus(404);
		}
		else {
			resp.setStatus(302);
		}
		
		return mountById;
		
	}
	


}
