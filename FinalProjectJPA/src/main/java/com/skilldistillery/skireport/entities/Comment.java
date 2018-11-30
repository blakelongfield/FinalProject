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
	
	@Column(name="report_id")
	private int reportId;
	
	@ManyToOne
	@JoinColumn(name="comment_id")
	private int mainCommentID;
	
	public Comment(int id, String commentText, int reportId, int mainCommentID, List<Comment> comments, User user) {
		super();
		this.id = id;
		this.commentText = commentText;
		this.reportId = reportId;
		this.mainCommentID = mainCommentID;
		this.comments = comments;
		this.user = user;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}



	@OneToMany(mappedBy="mainCommentId")
	private List<Comment> comments;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	
	
	
	public Comment(int id, String commentText, int reportId, int mainCommentID, User user) {
		super();
		this.id = id;
		this.commentText = commentText;
		this.reportId = reportId;
		this.mainCommentID = mainCommentID;
		this.user = user;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Comment [id=");
		builder.append(id);
		builder.append(", commentText=");
		builder.append(commentText);
		builder.append(", reportId=");
		builder.append(reportId);
		builder.append(", mainCommentID=");
		builder.append(mainCommentID);
		builder.append(", comments=");
		builder.append(comments);
		builder.append(", user=");
		builder.append(user);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((commentText == null) ? 0 : commentText.hashCode());
		result = prime * result + ((comments == null) ? 0 : comments.hashCode());
		result = prime * result + id;
		result = prime * result + mainCommentID;
		result = prime * result + reportId;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		if (commentText == null) {
			if (other.commentText != null)
				return false;
		} else if (!commentText.equals(other.commentText))
			return false;
		if (comments == null) {
			if (other.comments != null)
				return false;
		} else if (!comments.equals(other.comments))
			return false;
		if (id != other.id)
			return false;
		if (mainCommentID != other.mainCommentID)
			return false;
		if (reportId != other.reportId)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public int getMainCommentID() {
		return mainCommentID;
	}

	public void setMainCommentID(int mainCommentID) {
		this.mainCommentID = mainCommentID;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getId() {
		return id;
	}


	
	public Comment() {
		
	}
	

}