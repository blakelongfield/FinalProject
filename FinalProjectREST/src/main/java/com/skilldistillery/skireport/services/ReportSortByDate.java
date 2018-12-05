package com.skilldistillery.skireport.services;

import java.util.Comparator;

import com.skilldistillery.skireport.entities.Report;

public class ReportSortByDate implements Comparator<Report>{

	@Override
	public int compare(Report o1, Report o2) {
		
		return o1.getDateCreated().compareTo(o2.getDateCreated());
		
		
	}
	
	
	
	

}
