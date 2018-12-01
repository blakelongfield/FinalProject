package com.skilldistillery.skireport.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class ResortTest {

	private static EntityManagerFactory emf;

	private EntityManager em;
	
	private Resort resort;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
	emf = Persistence.createEntityManagerFactory("SkiReview");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
	
	@BeforeEach
	public void setUp() throws Exception {
		em = emf.createEntityManager();
		resort = em.find(Resort.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		resort = null;
	}
	
	@Test
	@DisplayName("Test Resort mappings")
	void test_resort_mappings() {
		assertNotNull(resort);
		assertEquals("28194 US Hwy 6", resort.getStreet());
		assertNull(resort.getStreet2());
		assertEquals("Keystone", resort.getCity());
		assertEquals("CO", resort.getState());
		assertEquals("80435", resort.getZip());
		assertEquals("Arapahoe Basin", resort.getName());
		assertEquals(1428, resort.getAcres().intValue());
		assertEquals(1, resort.getMountains().size());
		assertEquals("Arapahoe Basin", resort.getMountains().get(0).getName());
	}

}
