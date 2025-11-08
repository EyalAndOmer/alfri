package sk.uniza.fri.alfri.service.implementation;

import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import io.github.resilience4j.retry.annotation.Retry;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import sk.uniza.fri.alfri.client.PythonMlClient;
import sk.uniza.fri.alfri.client.dto.*;
import sk.uniza.fri.alfri.service.PythonPredictionService;

@Service
@RequiredArgsConstructor
@Slf4j
public class ResilientPythonPredictionService implements PythonPredictionService {

    private final PythonMlClient pythonMlClient;

    @Override
    @Retry(name = "pythonServiceRetry")
    @CircuitBreaker(name = "pythonService", fallbackMethod = "passingChanceFallback")
    public PassingChanceResponseDto passingChance(PassingChanceRequestDto request) {
        return pythonMlClient.passingChance(request);
    }

    public PassingChanceResponseDto passingChanceFallback(PassingChanceRequestDto request, Throwable t) {
        log.warn("passingChance fallback due to: {}", t.toString());
        PassingChanceResponseDto resp = new PassingChanceResponseDto();
        // return empty results to indicate graceful degradation
        resp.setResults(java.util.Collections.emptyMap());
        return resp;
    }

    @Override
    @Retry(name = "pythonServiceRetry")
    @CircuitBreaker(name = "pythonService", fallbackMethod = "passingMarkFallback")
    public PassingMarkResponseDto passingMark(PassingMarkRequestDto request) {
        return pythonMlClient.passingMark(request);
    }

    public PassingMarkResponseDto passingMarkFallback(PassingMarkRequestDto request, Throwable t) {
        log.warn("passingMark fallback due to: {}", t.toString());
        PassingMarkResponseDto resp = new PassingMarkResponseDto();
        resp.setDistribution(java.util.Collections.emptyMap());
        resp.setChosen_grade(null);
        resp.setSubject(null);
        return resp;
    }

    @Override
    @Retry(name = "pythonServiceRetry")
    @CircuitBreaker(name = "pythonService", fallbackMethod = "clusteringFallback")
    public ClusteringResponseDto clustering(ClusteringRequestDto request) {
        return pythonMlClient.clustering(request);
    }

    public ClusteringResponseDto clusteringFallback(ClusteringRequestDto request, Throwable t) {
        log.warn("clustering fallback due to: {}", t.toString());
        return null; // callers should handle null as 'no clustering available'
    }

    @Override
    @Retry(name = "pythonServiceRetry")
    @CircuitBreaker(name = "pythonService", fallbackMethod = "triggerPredictionFallback")
    public void triggerPrediction() {
        pythonMlClient.triggerPrediction();
    }

    public void triggerPredictionFallback(Throwable t) {
        log.warn("triggerPrediction fallback due to: {}", t.toString());
    }
}

