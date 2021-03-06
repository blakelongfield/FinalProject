package com.skilldistillery.skireport.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class LiftTypeTests {
	private static EntityManagerFactory emf;
	EntityManager em;
	private LiftType liftType;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception{
		emf = Persistence.createEntityManagerFactory("SkiReview");
	}
	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		liftType = em.find(LiftType.class, 1);
	}
	
	@Test
	void test1() {
		assertEquals(4, liftType.getCapacity().intValue());
		assertEquals("Express Chairlift", liftType.getType());
		assertEquals(16, liftType.getLifts().size());
	}
	
	@AfterAll
	static void tearDownAfterClasS() {
		emf.close();
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}
}
