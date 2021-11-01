package edu.spring.project;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //현재클래스가 설정 모든 결과를   xml 파일 설정으로 
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/naverimages/**")   //사용하는 이미지들을 호출하는 url = naverimages
        .addResourceLocations("file:///C:/Users/jjyju/OneDrive/바탕 화면/멀티캠퍼스/네이버AI 수업/images/");
        registry.addResourceHandler("/upload/**")   //사용하는 이미지들을 호출하는 url = naverimages
        .addResourceLocations("file:///C:/kdigital2/upload/");
        registry.addResourceHandler("/imgs/**").addResourceLocations("classpath:/static/imgs/");
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/notice/**").addResourceLocations("file:///C:/kdigital2/notice/");
    }
}

//  http://localhost:port/upload/파일명
