package com.skilldistillery.skireport.entities;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;

public class UserTests {

	private static EntityManagerFactory emf;
	private EntityManager em;

	@BeforeAll
	public static void BeforeAll() throws Exception {
		emf = Persistence.createEntityManagerFactory("SkiReport");
	}

	@AfterAll
	public static void AfterAll() throws Exception {
		emf.close();
	}

	@BeforeEach
	public void setUp() throws Exception {
		em = emf.createEntityManager();
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
	}

	@Test
	@DisplayName("test User connects to the database")
	public void test() {
		User user = em.find(User.class, 1);
		System.out.println("USER------------------------------------------------: " + user);
		
		assertNotNull(user);
		assertEquals("blank", user.getFirstName());
		
		
	}

}
