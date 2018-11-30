package com.skilldistillery.skireport.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Report {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="report_text")
	private String reportText;
	
	private Integer rating;
	
	@Column(name="vote")
	private Integer votes;
	
	@Column(name="image_url")
	private String imgUrl;
	
	@Temporal(TemporalType.DATE)
	@CreationTimestamp
	@Column(name="date_created")
	private Date dateCreated;
	
	@OneToMany(mappedBy="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="")
	private Mountain mountain;
	
	@OneToMany(mappedBy="trail_id")
	private Trail trail;
	
	@ManyToOne
	@JoinColumn(name="comment_id")
	private List<Comment> comments;
	
	public Report() {
		super();
	}

	public Report(int id, String reportText, Integer rating, Integer votes, String imgUrl, Date dateCreated) {
		super();
		this.id = id;
		this.reportText = reportText;
		this.rating = rating;
		this.votes = votes;
		this.imgUrl = imgUrl;
		this.dateCreated = dateCreated;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getReportText() {
		return reportText;
	}

	public void setReportText(String reportText) {
		this.reportText = reportText;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public Integer getVotes() {
		return votes;
	}

	public void setVotes(Integer votes) {
		this.votes = votes;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	@Override
	public String toString() {
		return "Report [id=" + id + ", reportText=" + reportText + ", rating=" + rating + ", votes=" + votes
				+ ", imgUrl=" + imgUrl + ", dateCreated=" + dateCreated + "]";
	}
}
