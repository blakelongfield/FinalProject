package com.skilldistillery.skireport.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class MountainTests {
	private static EntityManagerFactory emf;
	EntityManager em;
	private Mountain mountain;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception{
		emf = Persistence.createEntityManagerFactory("SkiReport");
		
	}
	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		mountain = em.find(Mountain.class, 1);
	}
	
	@Test
	@DisplayName("test that mountain has many reports")
	void test1() {
		assertEquals(1, mountain.getReports().size());
	}
	
	@Test
	@DisplayName("Mountain in database is correct")
	void test2() {
		assertEquals("Arapahoe Basin", mountain.getName());
		assertEquals(2, mountain.getNumberOfLifts().intValue());
		assertEquals(, mountain.getNumberOfRuns().);
		assertEquals(, mountain.getPeakElevation());
		assertEquals(, mountain.getBaseElevation());
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
