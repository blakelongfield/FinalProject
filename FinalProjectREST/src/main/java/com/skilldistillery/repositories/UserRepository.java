package com.skilldistillery.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.skireport.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

}
