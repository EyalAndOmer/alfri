import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { DataReportDto } from '../types';

@Injectable({
  providedIn: 'root',
})
export class DataReportService {
  private readonly URL = `${environment.API_URL}/data-report`;
  private readonly http = inject(HttpClient);

  public getDataReport(): Observable<DataReportDto> {
    // Mock data for now
    const mockData: DataReportDto = {
      studentCount: 1247,
      subjectCount: 156,
      studyProgramCount: 2,
      studentTrend: [
        { year: 2019, informatika: 150, manazment: 120 },
        { year: 2020, informatika: 180, manazment: 135 },
        { year: 2021, informatika: 210, manazment: 145 },
        { year: 2022, informatika: 245, manazment: 160 },
        { year: 2023, informatika: 280, manazment: 175 },
        { year: 2024, informatika: 320, manazment: 190 },
        { year: 2025, informatika: 365, manazment: 210 },
      ],
    };

    return of(mockData);

    // When backend is ready, uncomment this:
    // return this.http.get<DataReportDto>(this.URL);
  }
}
