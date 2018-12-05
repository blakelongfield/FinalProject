package com.skilldistillery.skireport.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ReportTests {
	private static EntityManagerFactory emf;
	EntityManager em;
	private Report report;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception{
		emf = Persistence.createEntityManagerFactory("SkiReview");
	}
	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		report = em.find(Report.class, 1);
	}
	
	@AfterAll
	static void tearDownAfterClasS() {
		emf.close();
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}
	
	@Test
	void test1() {
		assertEquals("report 1 on trail 1", report.getReportText());
		assertEquals(5, report.getRating().intValue());
		assertTrue(report.getActive());
	}
	
}
