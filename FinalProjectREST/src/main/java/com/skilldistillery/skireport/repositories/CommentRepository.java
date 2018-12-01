package com.skilldistillery.skireport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

}
