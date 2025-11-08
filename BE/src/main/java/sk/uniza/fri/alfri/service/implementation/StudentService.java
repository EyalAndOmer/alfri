package sk.uniza.fri.alfri.service.implementation;

import jakarta.persistence.EntityNotFoundException;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import sk.uniza.fri.alfri.entity.Student;
import sk.uniza.fri.alfri.entity.StudyProgram;
import sk.uniza.fri.alfri.entity.User;
import sk.uniza.fri.alfri.repository.StudentRepository;
import sk.uniza.fri.alfri.repository.StudyProgramRepository;
import sk.uniza.fri.alfri.service.IStudentService;
import sk.uniza.fri.alfri.util.ProcessUtils;
import sk.uniza.fri.alfri.client.PythonMlClient;
import sk.uniza.fri.alfri.service.PythonPredictionService;

@Service
public class StudentService implements IStudentService {
  private final StudentRepository studentRepository;
  private final StudyProgramRepository studyProgramRepository;
  private final PythonMlClient pythonMlClient;

  @Value("${python.service.enabled:false}")
  private boolean pythonServiceEnabled;

  public StudentService(StudentRepository studentRepository,
      StudyProgramRepository studyProgramRepository, PythonMlClient pythonMlClient) {
    this.studentRepository = studentRepository;
    this.studyProgramRepository = studyProgramRepository;
    this.pythonMlClient = pythonMlClient;
  }

  public StudyProgram getUsersStudyProgram(String userEmail) {
    Student student =
        studentRepository.findByUser_Email(userEmail).orElseThrow(() -> new EntityNotFoundException(
            String.format("User with email %s is not student", userEmail)));

    return studyProgramRepository.findById(student.getStudyProgramId())
        .orElseThrow(() -> new EntityNotFoundException(
            String.format("No study program was found for student %s", student)));
  }

  @Override
  public StudyProgram getUsersStudyProgram(User user) {
    return getUsersStudyProgram(user.getEmail());
  }

  @Override
  public void makePrediction() throws IOException {
    if (pythonServiceEnabled) {
      // Use remote python service to trigger predictions
      pythonMlClient.triggerPrediction();
      return;
    }

    // Fallback to original behavior: run local python script
    ProcessBuilder processBuilder =
        new ProcessBuilder("python3", "./python_scripts/passing_chance_prediction.py");
    String output = ProcessUtils.getOutputFromProces(processBuilder, false);
    System.out.println(output);
  }

  @Override
  public Student getStudentByUserEmail(String userEmail) {
    return studentRepository.findByUser_Email(userEmail)
        .orElseThrow(() -> new EntityNotFoundException(
            String.format("User with email %s is not a student!", userEmail)));
  }
}
