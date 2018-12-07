package com.skilldistillery.skireport.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.ChairLift;
import com.skilldistillery.skireport.services.ChairLiftService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class ChairliftController {
	
	
	@Autowired ChairLiftService clServe;
	
	//INDEX
	@GetMapping("chairlifts")
	public List<ChairLift> index() {
		return clServe.findAll();
	}
	
	//SHOW
	@GetMapping("chairlifts/{id}")
	public ChairLift showById( @PathVariable("id") Integer id) {
		return clServe.findById(id);
	}
	
	//CREATE
	@PostMapping("admin/chairlifts")
	public ChairLift create(@RequestBody ChairLift chairlift) {
		
		// will need to pull in lifttype id
		return clServe.create(chairlift, 1);
	}
	
	//UPDATE
	@PatchMapping("admin/chairlifts/{id}")
	public ChairLift update( @PathVariable("id") Integer id, @RequestBody ChairLift chairlift ) {
		return clServe.update(id, chairlift);
	}
	
	//DELETE
	@DeleteMapping("admin/chairlifts/{id}")
	public Boolean delete( @PathVariable("id") Integer id ) {
		return clServe.delete(id);
	}

}
