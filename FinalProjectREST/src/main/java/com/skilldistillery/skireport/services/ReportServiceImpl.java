package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Mountain;
import com.skilldistillery.skireport.entities.Report;
import com.skilldistillery.skireport.entities.Trail;
import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.MountainRepository;
import com.skilldistillery.skireport.repositories.ReportRepository;
import com.skilldistillery.skireport.repositories.TrailRepository;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	ReportRepository repo;
	@Autowired
	UserRepository urepo;
	@Autowired
	MountainRepository mrepo;
	@Autowired
	TrailRepository trepo;

	// FIND ALL
	@Override
	public List<Report> findAll() {

		return repo.findAll();
	}

	// FIND REPORTS BY USERNAME
	@Override
	public List<Report> findByUsername(String username) {

		return repo.findByUserUsername(username);
	}

	// FIND REPORTS BY MTN NAME
	@Override
	public List<Report> findByMountainName(String mtnName) {
		return repo.findByMountainReportsName(mtnName);
	}

	// FIND REPORTS BY TRAIL NAME
	@Override
	public List<Report> findByTrailName(String trailName) {

		return repo.findByTrailName(trailName);
	}

	// FIND REPORT BY REPORT ID
	@Override
	public Report findById(Integer id) {
		Optional<Report> opt = repo.findById(id);
		return opt.get();
	}

	// CREATE NEW REPORT
	@Override
	public Report create(Report report) {

		Optional<User> opt1 = urepo.findById(2);
		User user = opt1.get();
		Optional<Mountain> opt2 = mrepo.findById(1);
		Mountain mtn = opt2.get();
		Optional<Trail> opt3 = trepo.findById(1);
		Trail trail = opt3.get();

		report.setUser(user);
		report.setMountainReports(mtn);
		report.setTrail(trail);

		repo.saveAndFlush(report);

		return report;
	}

	// UPDATE REPORT
	@Override
	public Report update(Integer rid, Report report) {

		Optional<Report> opt = repo.findById(rid);
		Report mReport = opt.get();

		if (report != null && mReport != null) {

			if (report.getReportText() != null) {
				mReport.setReportText(report.getReportText());
			}
			if (report.getRating() != null) {
				mReport.setRating(report.getRating());
			}
			if (report.getImgUrl() != null) {
				mReport.setImgUrl(report.getImgUrl());
			}
			if (report.getTrail() != null) {
				mReport.setTrail(report.getTrail());
			}
			if (report.getComments() != null) {
				mReport.setComments(report.getComments());
			}

			repo.saveAndFlush(mReport);

		}
		return mReport;
	}

	// DELETE REPORT
	@Override
	public Boolean delete(Integer id) {

		Boolean deleted = false;
		Optional<Report> opt = repo.findById(id);
		Report report = opt.get();

		if (opt != null) {
			repo.delete(report);
			Optional<Report> opt2 = repo.findById(id);
			if (!opt2.isPresent()) {
				deleted = true;
			}
		}
		return deleted;
	}

}