package sk.uniza.fri.alfri.service;

import sk.uniza.fri.alfri.client.dto.*;

public interface PythonPredictionService {
    PassingChanceResponseDto passingChance(PassingChanceRequestDto request);
    PassingMarkResponseDto passingMark(PassingMarkRequestDto request);
    ClusteringResponseDto clustering(ClusteringRequestDto request);
    void triggerPrediction();
}

