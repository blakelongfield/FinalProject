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

		return repo.findAllWhereActiveIsTrue();
	}

	// FIND REPORTS BY USERNAME
	@Override
	public List<Report> findByUserId(Integer uid) {

		return repo.findByUserId(uid);
	}

	// FIND REPORTS BY MTN NAME
	@Override
	public List<Report> findByMountainId(Integer mid) {
		return repo.findByMountainId(mid);
	}

	// FIND REPORTS BY TRAIL NAME
	@Override
	public List<Report> findByTrailId(Integer tid) {

		return repo.findByTrailId(tid);
	}

	// FIND REPORT BY REPORT ID
	@Override
	public Report findById(Integer id) {
		Optional<Report> opt = repo.findById(id);
		return opt.get();
	}

	// CREATE NEW REPORT
	@Override
	public Report create(Report report, String username, Integer trailId, Integer mountainId) {
		Trail trail = null;
		Mountain mountain = null;
		if (username != null) {
			User user = urepo.findByUsername(username);
			report.setUser(user);
			if (trailId != null) {
			Optional<Trail> trailOpt = trepo.findById(trailId);
				if (trailOpt.isPresent()) {
					trail = trailOpt.get();
					report.setTrail(trail);
					Optional<Mountain> mountainOpt = mrepo.findById(trail.getMountain().getId());
					mountain = mountainOpt.get();
					report.setMountain(mountain);
				}
			}
			else if (mountainId != null) {
				Optional<Mountain> mountainOpt = mrepo.findById(mountainId);
				if (mountainOpt.isPresent()) {
					mountain = mountainOpt.get();
					report.setMountain(mountain);
				}
			}
		repo.saveAndFlush(report);
		}
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
