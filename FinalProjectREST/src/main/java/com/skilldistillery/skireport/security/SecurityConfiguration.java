package com.skilldistillery.skireport.security;

//@Configuration
//@EnableWebSecurity
public class SecurityConfiguration {
//public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

//	@Autowired
//	PasswordEncoder encoder;
//
//	@Autowired
//	DataSource dataSource;
//	
//	@Override
//	protected void configure(HttpSecurity http) throws Exception {
//		http
//	        .csrf().disable()
//	        .authorizeRequests()
//	        .antMatchers(HttpMethod.OPTIONS, "/api/**").permitAll()  // For CORS, the preflight request will hit the OPTIONS on the route
//	        .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
//	        .antMatchers("/login").permitAll()
//	        .antMatchers("/register").permitAll()
//	        .antMatchers("/*").permitAll()
//	        .anyRequest().authenticated()
//	        .and()
//	        .httpBasic();
//
//		http
//	        .sessionManagement()
//	        .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
//	}
//
//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		String userQuery = "SELECT username, password, enabled FROM User WHERE username=?";
//		String authQuery = "SELECT username, role FROM User WHERE username=?";
//		auth
//			.jdbcAuthentication()
//			.dataSource(dataSource)
//			.usersByUsernameQuery(userQuery)
//			.authoritiesByUsernameQuery(authQuery)
//			.passwordEncoder(encoder);
//	}
}
