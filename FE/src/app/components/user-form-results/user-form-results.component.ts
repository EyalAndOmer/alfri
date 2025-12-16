import {
  AfterViewInit,
  Component,
  ElementRef,
  input,
  ViewChild,
  computed,
} from '@angular/core';
import {
  BarController,
  BarElement,
  CategoryScale,
  Chart as chartJs,
  Chart,
  ChartDataset,
  Filler,
  Legend,
  LinearScale,
  LineElement,
  PointElement,
  RadarController,
  RadialLinearScale,
  TimeScale,
  Title,
  Tooltip,
} from 'chart.js';

import { MatChip, MatChipSet } from '@angular/material/chips';
import { AnsweredForm, StudyPrograms } from '../../types';
import {
  MatCard,
  MatCardContent,
  MatCardHeader,
  MatCardTitle,
} from '@angular/material/card';
import { MatIcon } from '@angular/material/icon';
import { NgClass } from '@angular/common';
import { SubjectGradesTable, SubjectGrade } from '../subject-grades-table/subject-grades-table';

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
    SubjectGradesTable,
  ],
  templateUrl: './user-form-results.component.html',
  styleUrl: './user-form-results.component.scss',
})
export class UserFormResultsComponent implements AfterViewInit {
  // Use input signal instead of @Input
  existingAnswers = input<AnsweredForm | undefined>();

  @ViewChild('radarChart') chart!: ElementRef<HTMLCanvasElement>;
  radarChart: Chart | undefined;
  protected readonly StudyPrograms = StudyPrograms;
  protected readonly Number = Number;

  // Computed signal that automatically recalculates when existingAnswers changes
  subjectGradesData = computed<SubjectGrade[]>(() => {
    const answers = this.existingAnswers();
    if (!answers?.sections?.[1]) {
      return [];
    }

    return answers.sections[1].questions.map((question) => ({
      subjectName: question.questionTitle,
      grade: question.answers[0].texts[0].textOfAnswer,
    }));
  });

  chartDatasets: ChartDataset[] = [
    {
      data: [],
    },
  ];

  constructor() {
    chartJs.register(
      CategoryScale,
      LinearScale,
      PointElement,
      LineElement,
      TimeScale,
      Title,
      Tooltip,
      Legend,
      RadialLinearScale,
      RadarController,
      Filler,
      BarController,
      BarElement,
    );
  }


  ngAfterViewInit(): void {
    this.initializeRadarChart();
  }

  initializeRadarChart(): void {
    const canvas = this.chart.nativeElement;
    const ctx = canvas.getContext('2d');

    if (ctx) {
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

      // Setup radial gradient for the radar chart fill - Cool Blue/Teal Gradient
      const gradient = ctx.createRadialGradient(0, 0, 0, 0, 0, 400);
      gradient.addColorStop(0, 'rgba(14, 116, 144, 0.4)'); // Cyan-700
      gradient.addColorStop(1, 'rgba(6, 182, 212, 0.05)'); // Cyan-500

      this.radarChart = new Chart(ctx, {
        type: 'radar',
        data: {
          labels: Object.values(focusLabelMapping),
          datasets: this.chartDatasets,
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            r: {
              angleLines: {
                display: true,
                color: 'rgba(14, 116, 144, 0.1)',
              },
              grid: {
                color: 'rgba(14, 116, 144, 0.1)',
              },
              pointLabels: {
                color: '#475569',
                font: {
                  size: 12,
                  family: "'Plus Jakarta Sans', sans-serif",
                  weight: 600,
                },
              },
              ticks: {
                display: false,
                stepSize: 2,
                backdropColor: 'transparent',
              },
              suggestedMin: 0,
              suggestedMax: 10,
            },
          },
          plugins: {
            tooltip: {
              backgroundColor: '#0f172a',
              titleColor: '#f0f9ff',
              bodyColor: '#e2e8f0',
              padding: 12,
              cornerRadius: 12,
              displayColors: false,
              titleFont: {
                family: "'Plus Jakarta Sans', sans-serif",
                size: 14,
              },
              bodyFont: {
                family: "'Plus Jakarta Sans', sans-serif",
                size: 13,
              },
              callbacks: {
                label: (context) => {
                  const value = context.raw || 0;
                  return `Skóre: ${String(value)}`;
                },
              },
            },
            legend: {
              display: false,
            },
          },
        },
      });

      this.chartDatasets[0] = {
        label: 'Skóre záujmu',
        fill: true,
        backgroundColor: gradient,
        borderColor: '#f97316', // Orange-500 accent for the line
        pointBackgroundColor: '#fff',
        pointBorderColor: '#f97316',
        pointHoverBackgroundColor: '#f97316',
        pointHoverBorderColor: '#fff',
        borderWidth: 2,
        pointRadius: 4,
        pointHoverRadius: 7,
        tension: 0.3, // Make lines slightly curved for modern feel
        data: [],
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

        this.chartDatasets[0].data = Object.values(
          Object.fromEntries(
            Object.keys(focusLabelMapping).map((key) => [
              key,
              mergedFocusesFormData[key],
            ]),
          ),
        ) as number[];
      }

      this.radarChart.update();
    }
  }

  getStudentName(): string {
    const answers = this.existingAnswers();
    if (!answers) return '';

    const questions = answers.sections[0].questions;
    const firstName = questions.find(q => q.questionTitle === 'Meno')?.answers[0]?.texts[0]?.textOfAnswer || '';
    const lastName = questions.find(q => q.questionTitle === 'Priezvisko')?.answers[0]?.texts[0]?.textOfAnswer || '';

    return `${firstName} ${lastName}`.trim();
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
