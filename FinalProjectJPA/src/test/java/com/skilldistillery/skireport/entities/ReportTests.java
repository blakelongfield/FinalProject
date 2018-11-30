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

class ReportTests {
	private static EntityManagerFactory emf;
	EntityManager em;
	private Report report;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception{
		emf = Persistence.createEntityManagerFactory("SkiReport");
	}
	
	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		report = em.find(Report.class, 1);
	}
	
	@Test
	void test1() {
		assertEquals(5, report.getRating().intValue());
		assertEquals("Great Powder Today", report.getReportText());
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
