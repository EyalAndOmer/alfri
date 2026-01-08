import { Component, inject, OnDestroy, OnInit, ViewChild } from '@angular/core';

import { MatCardModule } from '@angular/material/card';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { FormsModule } from '@angular/forms';
import { Subject, forkJoin, takeUntil } from 'rxjs';
import { DataReportService } from '@services/data-report.service';
import { StudyProgramService } from '@services/study-program.service';
import {
  DataReportDto,
  StudentTrendDataPoint,
  StudyProgramDto,
} from '../../../types';
import { LineChartComponent } from '@components/charts';
import { ApexAxisChartSeries, ApexOptions } from 'ng-apexcharts';

@Component({
  selector: 'app-teacher-home',
  standalone: true,
  imports: [
    MatCardModule,
    MatProgressBarModule,
    MatSelectModule,
    MatFormFieldModule,
    MatIconModule,
    FormsModule,
    LineChartComponent,
  ],
  templateUrl: './teacher-home.component.html',
  styleUrl: './teacher-home.component.scss',
})
export class TeacherHomeComponent implements OnInit, OnDestroy {
  @ViewChild(LineChartComponent) lineChart?: LineChartComponent;

  private readonly _destroy$: Subject<void> = new Subject();
  private readonly dataReportService = inject(DataReportService);
  private readonly studyProgramService = inject(StudyProgramService);

  isLoading = false;
  dataReport: DataReportDto | null = null;

  selectedStudyProgramId: number | null = null;
  studyPrograms: StudyProgramDto[] = [];

  // Chart options using the generic component
  public chartOptions: ApexOptions | null = null;

  ngOnInit(): void {
    this.loadData();
  }

  ngOnDestroy(): void {
    this._destroy$.next();
    this._destroy$.complete();
  }

  loadData(): void {
    this.isLoading = true;
    forkJoin({
      dataReport: this.dataReportService.getDataReport(),
      studyPrograms: this.studyProgramService.getAll(),
    })
      .pipe(takeUntil(this._destroy$))
      .subscribe({
        next: ({ dataReport, studyPrograms }) => {
          this.dataReport = dataReport;
          this.studyPrograms = studyPrograms;
          this.initializeChart(dataReport.studentTrend);
          this.isLoading = false;
        },
        error: () => {
          this.isLoading = false;
        },
      });
  }

  initializeChart(trendData: StudentTrendDataPoint[]): void {
    const series = this.getSeriesData(trendData);

    this.chartOptions = {
      series: series,
      chart: {
        height: 350,
        type: 'line',
        zoom: {
          enabled: false,
        },
        toolbar: {
          show: true,
        },
        animations: {
          enabled: true,
          animateGradually: {
            enabled: true,
            delay: 150,
          },
          dynamicAnimation: {
            enabled: false, // Disable animations when series data updates
          },
        },
        redrawOnWindowResize: false,
        redrawOnParentResize: false,
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        curve: 'smooth' as const,
        width: 3,
      },
      title: {
        text: 'Vývoj počtu študentov',
        align: 'left',
      },
      grid: {
        row: {
          colors: ['#f3f3f3', 'transparent'],
          opacity: 0.5,
        },
      },
      xaxis: {
        categories: trendData.map((d) => d.year.toString()),
        title: {
          text: 'Rok',
        },
      },
      yaxis: {
        title: {
          text: 'Počet študentov',
        },
      },
      legend: {
        position: 'top',
        horizontalAlign: 'right',
      },
      colors: ['#2E93fA', '#FF9800'],
    };
  }

  getSeriesData(trendData: StudentTrendDataPoint[]): ApexAxisChartSeries {
    let series: ApexAxisChartSeries = [];

    // If a specific study program is selected, show only that program's data
    if (this.selectedStudyProgramId) {
      const selectedProgram = this.studyPrograms.find(
        (p) => p.id === this.selectedStudyProgramId,
      );
      if (selectedProgram) {
        // For now, using the mock data structure
        // This should be adjusted based on actual API response
        const programKey = selectedProgram.name.toLowerCase();
        if (trendData[0] && programKey in trendData[0]) {
          series = [
            {
              name: selectedProgram.name,
              data: trendData.map(
                (d: StudentTrendDataPoint) =>
                  (d as unknown as Record<string, number>)[programKey] || 0,
              ),
            },
          ];
        }
      }
    } else {
      // Show all programs
      series = [
        {
          name: 'Informatika',
          data: trendData.map((d) => d.informatika),
        },
        {
          name: 'Manažment',
          data: trendData.map((d) => d.manazment),
        },
      ];
    }

    return series;
  }

  onStudyProgramChange(): void {
    console.log('change');
    if (this.dataReport && this.lineChart) {
      // Use the chart's updateSeries method to update data without animations
      const newSeries = this.getSeriesData(this.dataReport.studentTrend);
      this.lineChart.updateSeries(newSeries, false);
    }
  }

  get showStudyProgramCount(): boolean {
    return this.selectedStudyProgramId === null;
  }
}
