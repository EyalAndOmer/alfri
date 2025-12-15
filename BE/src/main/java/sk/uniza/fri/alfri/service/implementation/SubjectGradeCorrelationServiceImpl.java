package sk.uniza.fri.alfri.service.implementation;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import sk.uniza.fri.alfri.entity.SubjectGradeCorrelation;
import sk.uniza.fri.alfri.repository.SubjectGradeCorrelationRepository;
import sk.uniza.fri.alfri.service.SubjectGradeCorrelationService;

import java.util.List;

@Service
public class SubjectGradeCorrelationServiceImpl implements SubjectGradeCorrelationService {
    public static final String CORRELATION = "correlation";
    public static final String FIRST_SUBJECT = "firstSubject";
    public static final String SECOND_SUBJECT = "secondSubject";
    private final SubjectGradeCorrelationRepository subjectGradeCorrelationRepository;

    public SubjectGradeCorrelationServiceImpl(
            SubjectGradeCorrelationRepository subjectGradeCorrelationRepository) {
        this.subjectGradeCorrelationRepository = subjectGradeCorrelationRepository;
    }

    @Override
    public List<SubjectGradeCorrelation> findAll() {
        Specification<SubjectGradeCorrelation> specification = (root, query, criteriaBuilder) ->
                criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT));

        return subjectGradeCorrelationRepository.findAll(specification);
    }

    @Override
    public List<SubjectGradeCorrelation> findAllWithCorrelation(double correlationTreshold,
                                                                String operator) {
        Specification<SubjectGradeCorrelation> specification;

        switch (operator) {
            case ">" -> specification = (root, query, criteriaBuilder) -> criteriaBuilder.and(
                    criteriaBuilder.gt(root.get(CORRELATION), correlationTreshold),
                    criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT))
            );
            case ">=" -> specification = (root, query, criteriaBuilder) -> criteriaBuilder.and(
                    criteriaBuilder.greaterThanOrEqualTo(root.get(CORRELATION), correlationTreshold),
                    criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT))
            );
            case "<" -> specification = (root, query, criteriaBuilder) -> criteriaBuilder.and(
                    criteriaBuilder.lt(root.get(CORRELATION), correlationTreshold),
                    criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT))
            );
            case "<=" -> specification = (root, query, criteriaBuilder) -> criteriaBuilder.and(
                    criteriaBuilder.lessThanOrEqualTo(root.get(CORRELATION), correlationTreshold),
                    criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT))
            );
            case "=" -> specification = (root, query, criteriaBuilder) -> criteriaBuilder.and(
                    criteriaBuilder.equal(root.get(CORRELATION), correlationTreshold),
                    criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT))
            );
            case "<>" -> specification = (root, query, criteriaBuilder) -> criteriaBuilder.and(
                    criteriaBuilder.notEqual(root.get(CORRELATION), correlationTreshold),
                    criteriaBuilder.notEqual(root.get(FIRST_SUBJECT), root.get(SECOND_SUBJECT))
            );

            default -> throw new IllegalArgumentException("Invalid operator: " + operator);
        }

        return subjectGradeCorrelationRepository.findAll(specification);
    }
}
