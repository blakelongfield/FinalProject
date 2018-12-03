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

import com.skilldistillery.skireport.entities.Report;
import com.skilldistillery.skireport.services.ReportServiceImpl;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class ReportController {
	
	@Autowired
	ReportServiceImpl rServ;
	
	//INDEX 
	@GetMapping("reports")
	public List<Report> index () {
		
		return rServ.findAll();
		
	}
	
	//GET REPORTS BY USERNAME
	@GetMapping("reports/user/{username}")
	public List<Report> showByUsername(@PathVariable("username") String username) {
		
		return rServ.findByUsername(username);
	}
	
	//GET REPORTS BY MTN NAME
	@GetMapping("reports/mtn/{mtnName}")
	public List<Report> showByMtnName( @PathVariable("mtnName") String mtnName) {
		
		return rServ.findByMountainName(mtnName);
	}
	
	//GET REPORTS BY TRAIL NAME
	@GetMapping("reports/trail/{trailName}")
	public List<Report> showByTrailName( @PathVariable("trailName")String trailName) {
		
		return rServ.findByTrailName(trailName);
	}
	
	//GET REPORT BY ID
	@GetMapping("reports/{id}")
	public Report showById( @PathVariable("id") Integer id) {
		
		return rServ.findById(id);
	}
	
	//CREATE NEW REPORT
	@PostMapping("reports")
	public Report create( @RequestBody Report report) {
		
		return rServ.create(report);
	}
	
	//UPDATE REPORT (PATCH)
	@PatchMapping("reports/{id}")
	public Report patch( @PathVariable("id") Integer id, @RequestBody Report report) {
		
		return rServ.update(id, report);
	}
	
	//DELETE REPORT
	@DeleteMapping("reports/{id}")
	public Boolean delete( @PathVariable("id") Integer id) {
		return rServ.delete( id );
		
	}
	
	
	
	
	
	

}
