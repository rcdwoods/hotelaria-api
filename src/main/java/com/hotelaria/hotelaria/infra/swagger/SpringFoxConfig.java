package com.hotelaria.hotelaria.infra.swagger;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.RequestMappingInfoHandlerMapping;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.RequestHandlerProvider;
import springfox.documentation.spring.web.WebMvcRequestHandler;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.spring.web.plugins.DocumentationPluginsBootstrapper;
import springfox.documentation.spring.web.plugins.WebMvcRequestHandlerProvider;
import springfox.documentation.spring.web.readers.operation.HandlerMethodResolver;

import javax.servlet.ServletContext;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import static java.util.stream.Collectors.toList;
import static springfox.documentation.spi.service.contexts.Orderings.byPatternsCondition;
import static springfox.documentation.spring.web.paths.Paths.ROOT;

@Configuration
@EnableWebMvc
public class SpringFoxConfig extends WebMvcConfigurationSupport {

	private static final String TITLE = "Hotelaria API";
	private static final String DESCRIPTION = "First version of Hotelaria API.";
	private static final String VERSION = "v1";
	private static final String CONTACT_NAME = "Hotelaria";
	private static final String CONTACT_EMAIL = "contact@hotelaria.app";

	@Bean
	public Docket api() {
		return new Docket(DocumentationType.SWAGGER_2)
			.select()
			.apis(RequestHandlerSelectors.basePackage("com.hotelaria.hotelaria.infra.resource"))
			.paths(PathSelectors.any())
			.build()
			.apiInfo(apiInfo());
	}

	@Bean
	public InitializingBean removeSpringfoxHandlerProvider(DocumentationPluginsBootstrapper bootstrapper) {
		return () -> bootstrapper.getHandlerProviders().removeIf(WebMvcRequestHandlerProvider.class::isInstance);
	}

	@Bean
	public RequestHandlerProvider customRequestHandlerProvider(
		Optional<ServletContext> servletContext,
		HandlerMethodResolver methodResolver,
		List<RequestMappingInfoHandlerMapping> handlerMappings
	) {
		String contextPath = servletContext.map(ServletContext::getContextPath).orElse(ROOT);
		return () -> handlerMappings.stream()
			.filter(mapping -> !mapping.getClass().getSimpleName().equals("IntegrationRequestMappingHandlerMapping"))
			.map(mapping -> mapping.getHandlerMethods().entrySet())
			.flatMap(Set::stream)
			.map(entry -> new WebMvcRequestHandler(contextPath, methodResolver, tweakInfo(entry.getKey()), entry.getValue()))
			.sorted(byPatternsCondition())
			.collect(toList());
	}

	RequestMappingInfo tweakInfo(RequestMappingInfo info) {
		if (info.getPathPatternsCondition() == null) return info;
		String[] patterns = info.getPathPatternsCondition().getPatternValues().toArray(String[]::new);
		return info.mutate().options(new RequestMappingInfo.BuilderConfiguration()).paths(patterns).build();
	}

	private ApiInfo apiInfo() {
		return new ApiInfoBuilder()
			.title(TITLE)
			.description(DESCRIPTION)
			.version(VERSION)
			.contact(new Contact(CONTACT_NAME, null, CONTACT_EMAIL))
			.build();
	}
}
