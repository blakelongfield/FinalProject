package com.skilldistillery.skireport;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class FinalProjectRestApplication extends SpringBootServletInitializer {
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(FinalProjectRestApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(FinalProjectRestApplication.class, args);
	}
	
//	@Bean
//	public PasswordEncoder configurePasswordEncoder() {
//		return new BCryptPasswordEncoder();
//	}
}
