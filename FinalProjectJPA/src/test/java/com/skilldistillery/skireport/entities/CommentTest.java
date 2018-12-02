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

class CommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("SkiReview");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}

	@Test
	@DisplayName("test comments connects to database")
	void test() {
		Comment comment = em.find(Comment.class, 1);
		
		assertNotNull(comment);
		assertEquals("Awesome powder", comment.getCommentText());
		assertEquals(2, comment.getComments().size());
		assertEquals("Totally", comment.getComments().get(0).getCommentText());
	}
	
	

}
