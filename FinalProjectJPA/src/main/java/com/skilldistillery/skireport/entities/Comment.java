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

@Entity
public class Comment {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	@Column(name="comment_text")
	private String commentText;
	
	@ManyToOne
	@JoinColumn(name="report_id")
	private Report report;
	
	@ManyToOne
	@JoinColumn(name="comment_id")
	private Comment mainComment;
	
	@OneToMany(mappedBy="mainComment")
	private List<Comment> comments;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	public Comment() {
		
	}

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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
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

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Comment [id=");
		builder.append(id);
		builder.append(", commentText=");
		builder.append(commentText);
		builder.append(", report=");
		builder.append(report);
		builder.append(", mainComment=");
		builder.append(mainComment);
		builder.append(", comments=");
		builder.append(comments);
		builder.append(", user=");
		builder.append(user);
		builder.append("]");
		return builder.toString();
	}

	public Comment(int id, String commentText, Report report, Comment mainComment, List<Comment> comments, User user) {
		super();
		this.id = id;
		this.commentText = commentText;
		this.report = report;
		this.mainComment = mainComment;
		this.comments = comments;
		this.user = user;
	}

}