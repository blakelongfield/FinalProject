package com.skilldistillery.skireport.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

	// hard-coded until we start using Angular
//	private String username = "blake";

	@GetMapping(path = "comments")
	public List<Comment> getAllComments(HttpServletResponse resp, HttpServletRequest req) {
		List<Comment> comments = null;
		comments = commentService.findAll();
		if (comments.isEmpty()) {
			resp.setStatus(404);
		}
		return comments;
	}

	@GetMapping(path = "comments/{commentId}")
	public Comment findCommentById(@PathVariable("commentId") int commentId, HttpServletResponse resp,
			HttpServletRequest req) {
		Comment comment = commentService.findById(commentId);
		if (comment == null) {
			resp.setStatus(404);
		}
		return comment;
	}
	
	@GetMapping(path="comments/reports/{reportId}")
	public List<Comment> getCommentsOnAReport(@PathVariable("reportId") int reportId, HttpServletResponse resp,
			HttpServletRequest req) {
		List<Comment> comments = commentService.getCommentsOnAReport(reportId);
		return comments;
	}

	@PostMapping(path = "comments/reports/{reportId}")
	public Comment createCommentOnReport(@RequestBody Comment comment, @PathVariable("reportId") Integer reportId,
			HttpServletResponse resp, HttpServletRequest req, Principal principal) {
		Integer commentId = null;
		comment = commentService.create(comment, principal.getName(), reportId, commentId);
		if (comment == null) {
			resp.setStatus(400);
		} else {
			resp.setStatus(201);
		}
		return comment;
	}

	@PostMapping(path = "comments/comments/{commentId}")
	public Comment createCommentOnComment(@RequestBody Comment comment, @PathVariable("commentId") int commentId,
			HttpServletResponse resp, HttpServletRequest req, Principal principal) {
		Integer reportId = null;
		comment = commentService.create(comment, principal.getName(), reportId, commentId);
		if (comment == null) {
			resp.setStatus(400);
		} else {
			resp.setStatus(201);
		}
		return comment;
	}

	@PutMapping(path = "comments/{commentId}")
	public Comment updateComment(@RequestBody Comment comment, @PathVariable("commentId") int commentId,
			HttpServletResponse resp, HttpServletRequest req, Principal principal) {
		comment = commentService.update(comment, commentId, principal.getName());
		if (comment != null) {
			resp.setStatus(202);
		} else {
			resp.setStatus(400);
		}
		return comment;
	}

	@DeleteMapping(path = "comments/{commentId}")
	public Boolean deleteComment(@PathVariable("commentId") int commentId, HttpServletResponse resp,
			HttpServletRequest req, Principal principal) {
		Boolean deletedComment = false;
		deletedComment = commentService.destroy(commentId, principal.getName());
		if (deletedComment == true) {
			resp.setStatus(200);
		} else {
			resp.setStatus(400);
		}
		return deletedComment;
	}
}
