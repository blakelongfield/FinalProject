package com.skilldistillery.skireport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.skireport.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
	@Query(value="select * FROM Comment comment WHERE comment.report_id IS NOT NULL", nativeQuery=true)
	List<Comment> findCommentWhereReportIdIsNotNull();
}
