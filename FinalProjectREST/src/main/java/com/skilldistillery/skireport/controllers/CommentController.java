package com.skilldistillery.skireport.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.skireport.entities.Comment;
import com.skilldistillery.skireport.services.CommentService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class CommentController {
	@Autowired
	private CommentService commentService;
	
	//hardcoded for now
	private String username = "blake";
	
	@GetMapping(path="comments")
	public List<Comment> getAllComments() {
		List<Comment> comments = null;
		comments = commentService.findAll();
		return comments;
	}
	
	@GetMapping(path="comments/{commentId}")
	public Comment findCommentById(@PathVariable("commentId") int commentId) {
		Comment comment = null;
		comment = commentService.findById(commentId);
		return comment;
	}
	
	@PostMapping(path="comments/reports/{reportId}")
	public Comment createCommentOnReport(@RequestBody Comment comment, @PathVariable("reportId") Integer reportId) {
		Integer commentId = null;
		comment = commentService.create(comment, username, reportId, commentId);
		return comment;
	}
	
	@PostMapping(path="comments/comments/{commentId}")
	public Comment createCommentOnComment(@RequestBody Comment comment, @PathVariable("commentId") int commentId) {
		Integer reportId = null;
		comment = commentService.create(comment, username, reportId, commentId);
		return comment;
	}
	
	@PutMapping(path="comments/{commentId}")
	public Comment updateComment(@RequestBody Comment comment, @PathVariable("commentId") int commentId) {
		comment = commentService.update(comment, commentId, username);
		return comment;
	}
	
	@DeleteMapping(path="comments/{commentId}")
	public Boolean deleteComment(@PathVariable("commentId") int commentId) {
		Boolean deletedComment = false;
		deletedComment = commentService.destroy(commentId, username);
		return deletedComment;
	}
}

