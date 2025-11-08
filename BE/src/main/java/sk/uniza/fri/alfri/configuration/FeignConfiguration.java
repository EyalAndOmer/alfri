package sk.uniza.fri.alfri.configuration;

import feign.Request;
import feign.RequestInterceptor;
import feign.Logger;
import feign.Response;
import feign.FeignException;
import feign.codec.ErrorDecoder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import sk.uniza.fri.alfri.client.PythonServiceServerException;

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
        // Use legacy int constructor for current feign version
        return new Request.Options(timeoutMs, timeoutMs);
    }

    @Bean
    Logger.Level feignLoggerLevel() {
        return Logger.Level.BASIC;
    }

    @Bean
    public ErrorDecoder errorDecoder() {
        return (methodKey, response) -> {
            int status = response.status();
            if (status >= 500 && status < 600) {
                return new PythonServiceServerException("Python service 5xx error: status=" + status);
            }
            return FeignException.errorStatus(methodKey, response);
        };
    }
}
