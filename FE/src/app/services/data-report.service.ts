import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';
import { DataReportDto, StudyProgramId } from '../types';

@Injectable({
  providedIn: 'root',
})
export class DataReportService {
  private readonly URL = `${environment.API_URL}/data-report`;
  private readonly http = inject(HttpClient);

  public getDataReport(studyProgramId: StudyProgramId | null): Observable<DataReportDto> {
    let params = new HttpParams();

    if (studyProgramId) {
      params = params.set('studyProgramId', studyProgramId.toString());
    }

    return this.http.get<DataReportDto>(this.URL, { params });
  }
}
