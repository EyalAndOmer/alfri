package sk.uniza.fri.alfri.configuration;

import feign.Request;
import feign.RequestInterceptor;
import feign.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FeignConfiguration {

    @Value("${python.service.api-key:}")
    private String apiKey;

    @Value("${python.service.timeout-ms:5000}")
    private int timeoutMs;

    @Bean
    public RequestInterceptor apiKeyRequestInterceptor() {
        return template -> {
            if (apiKey != null && !apiKey.isEmpty()) {
                template.header("X-API-Key", apiKey);
            }
        };
    }

    @Bean
    public Request.Options feignOptions() {
        return new Request.Options(timeoutMs, timeoutMs);
    }

    @Bean
    Logger.Level feignLoggerLevel() {
        return Logger.Level.BASIC;
    }
}

