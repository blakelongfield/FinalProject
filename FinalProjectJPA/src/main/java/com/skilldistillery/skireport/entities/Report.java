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

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Report {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="report_text")
	private String reportText;
	
	private Integer rating;
	
	@Column(name="image_url")
	private String imgUrl;
	
	@Temporal(TemporalType.DATE)
	@CreationTimestamp
	@Column(name="date_created")
	private Date dateCreated;
	
	@Column(name="vote")
	private Integer votes;
	
	@JsonBackReference(value="userToReport")
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@JsonBackReference(value="trailToReport")
	@ManyToOne
	@JoinColumn(name="trail_id")
	private Trail trail;
	
	@JsonBackReference(value="mountainToReport")
	@ManyToOne
	@JoinColumn(name="mountain_id")
	private Mountain mountainReports;
	
	@JsonManagedReference(value="reportToComment")
	@OneToMany(mappedBy="report")
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

	public Integer getVotes() {
		return votes;
	}

	public void setVotes(Integer votes) {
		this.votes = votes;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Trail getTrail() {
		return trail;
	}

	public void setTrail(Trail trail) {
		this.trail = trail;
	}

	public Mountain getMountainReports() {
		return mountainReports;
	}

	public void setMountainReports(Mountain mountainReports) {
		this.mountainReports = mountainReports;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	/*
	 * hashCode / Equals
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
		Report other = (Report) obj;
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
		builder.append("Report [id=").append(id)
				.append(", reportText=").append(reportText)
				.append(", rating=").append(rating)
				.append(", imgUrl=").append(imgUrl)
				.append(", dateCreated=").append(dateCreated)
				.append(", votes=").append(votes)
				.append(", user=").append(user)
				.append(", trail=").append(trail)
				.append(", mountainReports=").append(mountainReports)
				.append(", comments=").append(comments.size())
				.append("]");
		return builder.toString();
	}

	/*
	 * constructors
	 */
	public Report() {
		super();
	}
	
	public Report(int id, String reportText, Integer rating, String imgUrl, Date dateCreated, Integer votes, User user,
			Trail trail, Mountain mountainReports, List<Comment> comments) {
		super();
		this.id = id;
		this.reportText = reportText;
		this.rating = rating;
		this.imgUrl = imgUrl;
		this.dateCreated = dateCreated;
		this.votes = votes;
		this.user = user;
		this.trail = trail;
		this.mountainReports = mountainReports;
		this.comments = comments;
	}
	
}
