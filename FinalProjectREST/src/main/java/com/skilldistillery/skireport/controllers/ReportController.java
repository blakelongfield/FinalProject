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
	
	private String username = "kyle";
	
	//INDEX 
	@GetMapping("reports")
	public List<Report> index () {
		return rServ.findAll();
		
	}
	
	//GET REPORTS BY USER ID
	@GetMapping("reports/user/{id}")
	public List<Report> showByUsername(@PathVariable("id") Integer uid) {
		
		return rServ.findByUserId(uid);
	}
	
	//GET REPORTS BY MTN ID
	@GetMapping("reports/mountains/{id}")
	public List<Report> showByMtnName( @PathVariable("id") Integer mid) {
		
		return rServ.findByMountainId(mid);
	}
	
	//GET REPORTS BY TRAIL ID
	@GetMapping("reports/trails/{id}")
	public List<Report> showByTrailName( @PathVariable("id") Integer tid) {
		
		return rServ.findByTrailId(tid);
	}
	
	//GET REPORT BY ID
	@GetMapping("reports/{id}")
	public Report showById( @PathVariable("id") Integer id) {
		
		return rServ.findById(id);
	}
	
	//CREATE NEW REPORT ON A TRAIL
	@PostMapping("reports/trails/{trailId}")
	public Report createReportOnTrail(@RequestBody Report report, @PathVariable("trailId") int trailId) {
		Integer mountainId = null;
		System.out.println(report);
		System.out.println(trailId + "*******************************************");
		return rServ.create(report, username, trailId, mountainId);
	}
	
	//CREATE NEW REPORT ON A MOUNTAIN
	@PostMapping("reports/mountains/{mountainId}")
	public Report createReportOnMountain(@RequestBody Report report, @PathVariable("mountainId") Integer mountainId) {
		Integer trailId = null;
		return rServ.create(report, username, trailId, mountainId);
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
