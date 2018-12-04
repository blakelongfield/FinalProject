package com.skilldistillery.skireport.services;

import java.util.List;

import com.skilldistillery.skireport.entities.Comment;

public interface CommentService {
	List<Comment> findAll();

	Comment findById(int commentId);
	
	List<Comment> getCommentsOnAReport(int reportId);

	Comment create(Comment comment, String username, Integer reportId, Integer commentId);

	Comment update(Comment comment, int commentId, String username);

	Boolean destroy(int commentId, String username);
}
