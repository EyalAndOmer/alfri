package sk.uniza.fri.alfri.repository;

import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import sk.uniza.fri.alfri.entity.StudentSubject;

import java.util.List;

@Repository
public interface StudentSubjectRepository extends JpaRepository<StudentSubject, StudentSubject.StudentSubjectPK> {
    @Query("SELECT s.year AS year, COUNT(DISTINCT s.studentId) AS studentCount " +
            "FROM StudentSubject s GROUP BY s.year")
    List<Tuple> countStudentsByYear();
}
