package com.skilldistillery.skireport.entities;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;



class ChairliftTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;

	@BeforeAll
	public static void setupALL() {
		emf = Persistence.createEntityManagerFactory("SkiReview");
	}

	@AfterAll
	public static void tearDownALL() {
		emf.close();
	}

	@BeforeEach
	public void setUpBeforeClass() throws Exception {
		em = emf.createEntityManager();
	}

	@AfterEach
	public void tearDownAfterClass() throws Exception {
		em.close();

	}

	@Test
	@DisplayName("testing connection to data base")
	void test() {
		
		ChairLift cl = em.find (ChairLift.class, 1);
		
		assertNotNull( cl );
		assertEquals( "Express", cl.getType().getType());
		assertEquals( 1, cl.getTrails().size());
		
	
		
	}

}
