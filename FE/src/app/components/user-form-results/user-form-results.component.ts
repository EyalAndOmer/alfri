import {
  AfterViewInit,
  Component,
  ElementRef,
  input,
  ViewChild,
  computed,
} from '@angular/core';

import { MatChip, MatChipSet } from '@angular/material/chips';
import { AnsweredForm, Page, StudyPrograms } from '../../types';
import {
  MatCard,
  MatCardContent,
  MatCardHeader,
  MatCardTitle,
} from '@angular/material/card';
import { MatIcon } from '@angular/material/icon';
import { NgClass } from '@angular/common';
import {
  GenericTableComponent,
  TableConfig,
  TableRow,
  TextCellRendererComponent,
} from '../generic-table';
import { GradeCellRendererComponent } from './grade-cell-renderer.component';
import { GenericTableUtils } from '@components/generic-table/generic-table.utils';
import { GradeUtils } from './grade.utils';
import { RadarChartComponent, RadarChartOptions } from '@components/charts';

// Updated SubjectGrade to extend TableRow (requires id)
export interface SubjectGrade extends TableRow {
  subjectName: string;
  grade: string;
  credits?: number;
}

@Component({
  selector: 'app-user-form-results',
  standalone: true,
  imports: [
    MatChip,
    MatChipSet,
    MatCard,
    MatCardHeader,
    MatCardTitle,
    MatCardContent,
    MatIcon,
    NgClass,
    GenericTableComponent,
    RadarChartComponent,
  ],
  templateUrl: './user-form-results.component.html',
  styleUrl: './user-form-results.component.scss',
})
export class UserFormResultsComponent implements AfterViewInit {
  // Use input signal instead of @Input
  existingAnswers = input<AnsweredForm | undefined>();

  protected readonly StudyPrograms = StudyPrograms;
  protected readonly Number = Number;

  // Radar chart options
  radarChartOptions: RadarChartOptions | null = null;

  // Computed signal that automatically recalculates when existingAnswers changes
  subjectGradesData = computed<Page<SubjectGrade>>(() => {
    const answers = this.existingAnswers();
    if (!answers?.sections?.[1]) {
      return GenericTableUtils.pageOf([]);
    }

    const tableData = answers.sections[1].questions.map((question, index) => ({
      id: index, // Add id for TableRow requirement
      subjectName: question.questionTitle,
      grade: question.answers[0].texts[0].textOfAnswer,
    }));

    return GenericTableUtils.pageOf(tableData);
  });

  // Computed signal for grade average
  gradeAverage = computed<string>(() => {
    const answers = this.existingAnswers();
    if (!answers?.sections?.[1]) {
      return '0.00';
    }

    const grades = answers.sections[1].questions.map((question) => {
      const gradeText = question.answers[0].texts[0].textOfAnswer;
      return GradeUtils.letterGradeToNumber(gradeText);
    });

    return GradeUtils.calculateAverage(grades);
  });

  // Table configuration using component-based approach
  gradesTableConfig: TableConfig<SubjectGrade> = {
    columns: [
      {
        id: 'subjectName',
        header: 'Názov predmetu',
        field: 'subjectName',
        sortable: true,
        cellRenderer: TextCellRendererComponent,
      },
      {
        id: 'grade',
        header: 'Známka',
        field: 'grade',
        cellRenderer: GradeCellRendererComponent,
        sortable: true,
        align: 'center',
      }
    ],
    enableSorting: true,
    enablePagination: true,
    pageSize: 5,
    pageSizeOptions: [5, 10, 20],
    serverSide: false,
    header: {
      show: true,
      title: 'Známky z povinných predmetov',
      icon: 'table_chart'
    }
  };


  ngAfterViewInit(): void {
    this.initializeRadarChart();
  }

  initializeRadarChart(): void {
    const focusLabelMapping: Record<string, string> = {
      question_matematika_focus: 'Matematika',
      question_logika_focus: 'Logika',
      question_programovanie_focus: 'Programovanie',
      question_dizajn_focus: 'Dizajn',
      question_ekonomika_focus: 'Ekonomika',
      question_manazment_focus: 'Manažment',
      question_hardver_focus: 'Hardvér',
      question_siete_focus: 'Sieťové technológie',
      question_data_focus: 'Práca s dátami',
      question_testovanie_focus: 'Testovanie',
      question_jazyky_focus: 'Jazyky',
      question_fyzicka_aktivita_focus: 'Fyzické zameranie',
    };

    const focusesFormData: Record<string, string>[] | undefined =
      this.existingAnswers()?.sections[2].questions.map((question) => {
        const focuses: Record<string, string> = {};
        focuses[question.questionIdentifier] =
          question.answers[0].texts[0].textOfAnswer;
        return focuses;
      });

    if (focusesFormData) {
      // Merge all objects in the array into one
      const mergedFocusesFormData = Object.assign({}, ...focusesFormData);

      const chartData = Object.values(
        Object.fromEntries(
          Object.keys(focusLabelMapping).map((key) => [
            key,
            mergedFocusesFormData[key],
          ]),
        ),
      ) as number[];

      this.radarChartOptions = {
        data: {
          labels: Object.values(focusLabelMapping),
          data: chartData,
          label: 'Skóre záujmu',
        },
        scales: {
          suggestedMin: 0,
          suggestedMax: 10,
          stepSize: 2,
        },
      };
    }
  }


  getFilteredQuestions() {
    const answers = this.existingAnswers();
    if (!answers) return [];

    return answers.sections[0].questions.filter(
      q => q.questionTitle !== 'Meno' && q.questionTitle !== 'Priezvisko'
    );
  }

  getIcon(questionTitle: string): string {
    const iconMap: Record<string, string> = {
      'Meno': 'badge',
      'Priezvisko': 'badge',
      'Ročník v škole': 'school',
      'Fakulta': 'domain',
      'Odbor': 'workspace_premium',
    };
    return iconMap[questionTitle] || 'info';
  }

  getDisplayLabel(questionTitle: string): string {
    const labelMap: Record<string, string> = {
      'Meno': 'Meno',
      'Priezvisko': 'Priezvisko',
      'Ročník v škole': 'Ročník',
      'Fakulta': 'Fakulta',
      'Odbor': 'Odbor',
    };
    return labelMap[questionTitle] || questionTitle;
  }

  getIconClass(questionTitle: string): string {
    const classMap: Record<string, string> = {
      'Meno': 'icon-cyan',
      'Priezvisko': 'icon-cyan',
      'Ročník v škole': 'icon-blue',
      'Fakulta': 'icon-emerald',
      'Odbor': 'icon-orange',
    };
    return classMap[questionTitle] || 'icon-default';
  }
}
