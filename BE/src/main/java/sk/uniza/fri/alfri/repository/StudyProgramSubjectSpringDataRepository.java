package sk.uniza.fri.alfri.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import sk.uniza.fri.alfri.entity.StudyProgramSubject;

import java.util.List;
import java.util.Optional;

public interface StudyProgramSubjectSpringDataRepository
        extends JpaRepository<StudyProgramSubject, Integer>,
        JpaSpecificationExecutor<StudyProgramSubject> {

    Optional<StudyProgramSubject> findBySubject_IdAndStudyProgram_Id(Integer subjectId, Integer studyProgramId);

    @Query("""
            SELECT s FROM StudyProgramSubject s
            WHERE s.obligation = 'Pov.'
            AND s.studyProgram.id = :studyProgramId
            AND s.recommendedYear <= :recommendedYear
            """)
    List<StudyProgramSubject> findAllMandatorySubjectsForStudyProgramAndYear(
            @Param("studyProgramId") Long studyProgramId,
            @Param("recommendedYear") Integer recommendedYear);

    @Query("""
            SELECT sps FROM StudyProgramSubject sps
            WHERE sps.obligation IN ('Výb.', 'P.v.')
            GROUP BY sps.id, sps.subject, sps.studyProgram, sps.obligation, sps.recommendedYear, sps.semesterWinter
            ORDER BY (
                SELECT COUNT(DISTINCT ss.studentId)
                FROM StudentSubject ss
                WHERE ss.subjectId = sps.subject.id
            ) DESC
            """)
    Page<StudyProgramSubject> findMostPopularElectiveSubjects(Pageable pageable);
}


