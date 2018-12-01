package com.skilldistillery.skireport.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Comment {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	@Column(name="comment_text")
	private String commentText;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="report_id")
	private Report report;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="user_id")
	private User userComment;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="comment_id")
	private Comment mainComment;
	
	@JsonIgnore
	@OneToMany(mappedBy="mainComment")
	private List<Comment> comments;

	
	/*
	 * getters / setters
	 */
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public Report getReport() {
		return report;
	}

	public void setReport(Report report) {
		this.report = report;
	}

	public User getUserComment() {
		return userComment;
	}

	public void setUserComment(User userComment) {
		this.userComment = userComment;
	}

	public Comment getMainComment() {
		return mainComment;
	}

	public void setMainComment(Comment mainComment) {
		this.mainComment = mainComment;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	/*
	 * hashCode / equals
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Comment other = (Comment) obj;
		if (id != other.id)
			return false;
		return true;
	}

	/*
	 * toString
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Comment [id=").append(id)
				.append(", commentText=").append(commentText)
				.append(", report=").append(report)
				.append(", userComment=").append(userComment)
				.append(", mainComment=").append(mainComment)
				.append(", comments=").append(comments.size())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public Comment() {
		super();
	}

	public Comment(int id, String commentText, Report report, User userComment, Comment mainComment,
			List<Comment> comments) {
		super();
		this.id = id;
		this.commentText = commentText;
		this.report = report;
		this.userComment = userComment;
		this.mainComment = mainComment;
		this.comments = comments;
	}
	
	

}