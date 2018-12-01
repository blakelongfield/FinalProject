package com.skilldistillery.skireport.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class TrailTest {

	private static EntityManagerFactory emf;

	private EntityManager em;
	
	private Trail trail;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
	emf = Persistence.createEntityManagerFactory("SkiReport");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
	
	@BeforeEach
	public void setUp() throws Exception {
		em = emf.createEntityManager();
		trail = em.find(Trail.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		trail = null;
	}
	
	@Test
	@DisplayName("Test Resort mappings")
	void test_resort_mappings() {
		assertNotNull(trail);
		assertEquals("Lower Chisholm Trail", trail.getName());
		assertEquals(Difficulty.BEGINNER, trail.getDifficulty());
		assertNull(trail.getLength());
		assertNull(trail.getElevationGainLoss());
		assertNull(trail.getFeatures());
		assertEquals(1, trail.getMountain().getId());
		assertEquals(1, trail.getLifts().get(0).getId());
		assertEquals(1, trail.getReports().get(0).getId());
	}

}
