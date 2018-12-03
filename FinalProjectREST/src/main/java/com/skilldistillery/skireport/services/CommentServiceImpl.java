package com.skilldistillery.skireport.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.skireport.entities.Comment;
import com.skilldistillery.skireport.entities.Report;
import com.skilldistillery.skireport.entities.User;
import com.skilldistillery.skireport.repositories.CommentRepository;
import com.skilldistillery.skireport.repositories.ReportRepository;
import com.skilldistillery.skireport.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {
	@Autowired
	private CommentRepository commentRepo;
	@Autowired
	private UserRepository userRepo;
	@Autowired
	private ReportRepository reportRepo;
	
	@Override
	public List<Comment> findAll() {
		List<Comment> comments = commentRepo.findCommentWhereReportIdIsNotNull();
		return comments;
	}

	@Override
	public Comment findById(int commentId) {
		Comment comment = null;
		Optional<Comment> commentOpt = commentRepo.findById(commentId);
		if (commentOpt.isPresent()) {
			comment = commentOpt.get();
		}
		return comment;
	}

	@Override
	public Comment create(Comment comment, String username, Integer reportId, Integer commentId) {
		Report report = null;
		Comment originalComment = null;
		if (username != null) {
			User user = userRepo.findByUsername(username);
			comment.setUser(user);
			if (reportId != null) {
				Optional<Report> reportOpt = reportRepo.findById(reportId);
				if (reportOpt.isPresent()) {
					report = reportOpt.get();
					comment.setReport(report);
				}
			}
			else if (commentId != null) {
				Optional<Comment> commentOpt = commentRepo.findById(commentId);
				if (commentOpt.isPresent()) {
					originalComment = commentOpt.get();
					comment.setMainComment(originalComment);;
				}
			}
			commentRepo.saveAndFlush(comment);
		}
		return comment;
	}

	@Override
	public Comment update(Comment comment, int commentId, String username) {
		Comment managedComment = null;
		Optional<Comment> commentOpt = commentRepo.findById(commentId);
		if (commentOpt.isPresent()) {
			managedComment = commentOpt.get();
			managedComment.setCommentText(comment.getCommentText());
			commentRepo.saveAndFlush(managedComment);
		}
		return managedComment;
	}

	@Override
	public Boolean destroy(int commentId, String username) {
		Boolean deleted = false; 
		Comment comment = null;
		Optional<Comment> commentOpt = commentRepo.findById(commentId);
		if (commentOpt.isPresent()) {
			comment = commentOpt.get();
			commentRepo.deleteById(commentId);
			deleted = true;
		}
		return deleted;
	}
}
