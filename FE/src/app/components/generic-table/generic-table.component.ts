import {
  Component,
  input,
  output,
  viewChild,
  model,
  computed,
  effect,
  signal,
  AfterViewInit,
  Type,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  MatTable,
  MatTableDataSource,
  MatColumnDef,
  MatHeaderCell,
  MatHeaderCellDef,
  MatCell,
  MatCellDef,
  MatHeaderRow,
  MatHeaderRowDef,
  MatRow,
  MatRowDef,
} from '@angular/material/table';
import { MatSort, MatSortHeader, SortDirection } from '@angular/material/sort';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatFormField, MatLabel, MatPrefix } from '@angular/material/form-field';
import { MatInput } from '@angular/material/input';
import { MatIcon } from '@angular/material/icon';
import { MatCheckbox } from '@angular/material/checkbox';
import { MatTooltip } from '@angular/material/tooltip';
import { MatProgressSpinner } from '@angular/material/progress-spinner';
import { SelectionModel } from '@angular/cdk/collections';
import { Subject } from 'rxjs';
import { debounceTime, distinctUntilChanged } from 'rxjs/operators';

import {
  TableConfig,
  TableColumnDef,
  TableCellContext,
  TableHeaderContext,
  TableCellRenderer,
  TableRow,
} from './generic-table.types';
import { TextCellRendererComponent } from '@components/generic-table/cell-renderers';
import { DynamicCellRendererDirective } from '@components/generic-table/dynamic-cell-renderer.directive';

@Component({
  selector: 'app-generic-table',
  standalone: true,
  imports: [
    CommonModule,
    MatTable,
    MatColumnDef,
    MatHeaderCell,
    MatHeaderCellDef,
    MatCell,
    MatCellDef,
    MatHeaderRow,
    MatHeaderRowDef,
    MatRow,
    MatRowDef,
    MatSort,
    MatSortHeader,
    MatPaginator,
    MatFormField,
    MatLabel,
    MatPrefix,
    MatInput,
    MatIcon,
    MatCheckbox,
    MatTooltip,
    MatProgressSpinner,
    DynamicCellRendererDirective,
  ],
  templateUrl: './generic-table.component.html',
  styleUrl: './generic-table.component.scss',
})
export class GenericTableComponent<
  T extends TableRow,
> implements AfterViewInit {
  // ============ INPUTS (Signal-based) ============

  /**
   * Table data array
   */
  data = input.required<T[]>();

  /**
   * Table configuration
   */
  config = input.required<TableConfig<T>>();

  /**
   * Loading state
   */
  loading = input<boolean>(false);

  /**
   * Custom filter function
   */
  customFilterFn = input<(data: T, filter: string) => boolean>();

  // ============ OUTPUTS (Signal-based) ============

  /**
   * Row click event
   */
  rowClick = output<{ row: T; event: MouseEvent }>();

  /**
   * Selection change event
   */
  selectionChange = output<T[]>();

  /**
   * Sort change event
   */
  sortChange = output<{ active: string; direction: SortDirection }>();

  /**
   * Page change event
   */
  pageChange = output<PageEvent>();

  /**
   * Filter change event
   */
  filterChange = output<string>();

  /**
   * Column visibility change event
   */
  columnVisibilityChange = output<string[]>();

  /**
   * Export event
   */
  exportData = output<'csv' | 'excel' | 'pdf' | 'json'>();

  // ============ TWO-WAY BINDING (Model signals) ============

  /**
   * Selected rows (two-way binding)
   */
  selectedRows = model<T[]>([]);

  // ============ VIEW CHILDREN ============

  paginator = viewChild(MatPaginator);
  sort = viewChild(MatSort);

  // ============ INTERNAL STATE ============

  dataSource: MatTableDataSource<T> = new MatTableDataSource<T>();
  selection = new SelectionModel<T>(true, []);
  filterValue = signal<string>('');
  private filterSubject = new Subject<string>();

  // ============ COMPUTED SIGNALS ============

  /**
   * Visible columns based on configuration
   */
  visibleColumns = computed(() => {
    return this.config()
      .columns.filter((col) => col.visible !== false)
      .map((col) => col.id);
  });

  /**
   * Displayed columns including selection and actions
   */
  displayedColumns = computed(() => {
    const cols: string[] = [];

    // Add selection column if enabled
    if (this.config().enableSelection) {
      cols.push('select');
    }

    // Add visible columns
    cols.push(...this.visibleColumns());

    return cols;
  });

  /**
   * Effective page size
   */
  effectivePageSize = computed(() => {
    return this.config().pageSize ?? 10;
  });

  /**
   * Effective page size options
   */
  effectivePageSizeOptions = computed(() => {
    return this.config().pageSizeOptions ?? [5, 10, 25, 50, 100];
  });

  /**
   * Check if table is loading or has loading state
   */
  isLoading = computed(() => {
    return this.loading() || this.config().loading || false;
  });

  /**
   * Check if table has data
   */
  hasData = computed(() => {
    return this.dataSource.data.length > 0;
  });

  /**
   * Get table density class
   */
  densityClass = computed(() => {
    const density = this.config().density ?? 'normal';
    return `density-${density}`;
  });

  constructor() {
    // Update dataSource when data signal changes
    effect(() => {
      this.dataSource.data = this.data();
    });

    // Update selection model mode
    effect(() => {
      const mode = this.config().selectionMode ?? 'multiple';
      this.selection = new SelectionModel<T>(mode === 'multiple', []);
    });

    // Setup custom sorting data accessor to handle field paths
    this.dataSource.sortingDataAccessor = (data: T, sortHeaderId: string) => {
      // Find the column definition for this sort header
      const column = this.config().columns.find(col => col.id === sortHeaderId);
      if (!column || !column.field) {
        return '';
      }

      // Use custom sortAccessor if provided
      if (column.sortAccessor) {
        return column.sortAccessor(data);
      }

      // Get value using field path
      const value = this.getValue(data, column);

      // Convert to sortable value
      if (value === null || value === undefined) {
        return '';
      }

      // Return string or number for sorting
      return typeof value === 'string' || typeof value === 'number' ? value : String(value);
    };

    // Setup data source with custom filter predicate if provided
    effect(() => {
      const configFn = this.config().filterPredicate;
      if (configFn) {
        this.dataSource.filterPredicate = configFn;
      } else {
        this.dataSource.filterPredicate = this.defaultFilterPredicate.bind(this);
      }
    });

    // Setup filter debounce
    effect(() => {
      const debounce = this.config().filterDebounce ?? 300;
      this.filterSubject
        .pipe(debounceTime(debounce), distinctUntilChanged())
        .subscribe((value) => {
          this.applyFilter(value);
        });
    });
  }

  ngAfterViewInit(): void {
    // Connect paginator
    const paginatorInstance = this.paginator();
    if (paginatorInstance && this.config().enablePagination) {
      this.dataSource.paginator = paginatorInstance;
    }

    // Connect sort
    const sortInstance = this.sort();
    if (sortInstance && this.config().enableSorting) {
      this.dataSource.sort = sortInstance;
    }

    // Apply initial sort if configured
    this.applyInitialSort();
  }

  /**
   * Apply initial sort configuration
   */
  private applyInitialSort(): void {
    const sortInstance = this.sort();
    const initialSort = this.config().initialSort;

    if (sortInstance && initialSort) {
      const { active, direction } = initialSort;
      sortInstance.active = active;
      sortInstance.direction = direction;
    }
  }

  // ============ HELPER METHODS ============

  /**
   * Get value from row using field path (supports nested properties)
   */
  getValue(row: T, column: TableColumnDef<T>): unknown {
    if (!column.field) return null;

    const fields = column.field.split('.');
    let value: unknown = row;

    for (const field of fields) {
      if (value === null || value === undefined) return null;
      value = (value as Record<string, unknown>)[field];
    }

    return value;
  }

  /**
   * Get the cell renderer component for a column
   * Returns the custom renderer or defaults to TextCellRendererComponent
   */
  getCellRenderer(
    column: TableColumnDef<T>,
  ): Type<TableCellRenderer<T, unknown>> {
    return column.cellRenderer ?? TextCellRendererComponent;
  }

  /**
   * Check if column has a custom cell renderer component
   */
  hasCellRenderer(column: TableColumnDef<T>): boolean {
    return !!column.cellRenderer;
  }

  /**
   * Check if column has a custom cell template
   */
  hasCellTemplate(column: TableColumnDef<T>): boolean {
    return !!column.cellTemplate;
  }

  /**
   * Get cell context for template rendering
   */
  getCellContext(
    row: T,
    column: TableColumnDef<T>,
    rowIndex: number,
  ): TableCellContext<T> {
    return {
      $implicit: row,
      column,
      rowIndex,
      value: this.getValue(row, column),
    };
  }

  /**
   * Get header context for template rendering
   */
  getHeaderContext(column: TableColumnDef<T>): TableHeaderContext<T> {
    return {
      column,
      sortDirection:
        this.sort()?.active === column.id ? this.sort()?.direction : undefined,
    };
  }

  /**
   * Get CSS classes for cell
   */
  getCellClass(row: T, column: TableColumnDef<T>): string | string[] {
    if (!column.cellClass) return '';

    if (typeof column.cellClass === 'function') {
      return column.cellClass(row);
    }

    return column.cellClass;
  }

  /**
   * Get CSS classes for header cell
   */
  getHeaderClass(column: TableColumnDef<T>): string | string[] {
    return column.headerClass ?? '';
  }

  /**
   * Default filter predicate
   */
  private defaultFilterPredicate(data: T, filter: string): boolean {
    const normalizedFilter = filter.toLowerCase();
    const columns = this.config().columns.filter(
      (col) => col.filterable !== false,
    );

    return columns.some((column) => {
      const value = this.getValue(data, column);
      if (value === null || value === undefined) return false;
      return String(value).toLowerCase().includes(normalizedFilter);
    });
  }

  /**
   * Apply filter to data source
   */
  private applyFilter(filterValue: string): void {
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }

    this.filterChange.emit(filterValue);
  }

  /**
   * Handle filter input
   */
  onFilterChange(event: Event): void {
    const value = (event.target as HTMLInputElement).value;
    this.filterValue.set(value);
    this.filterSubject.next(value);
  }

  /**
   * Handle row click
   */
  onRowClick(row: T, event: MouseEvent): void {
    if (this.config().enableRowClick) {
      this.rowClick.emit({ row, event });
    }
  }

  // ============ SELECTION METHODS ============

  /**
   * Whether the number of selected elements matches the total number of rows
   */
  isAllSelected(): boolean {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.data.length;
    return numSelected === numRows;
  }

  /**
   * Selects all rows if they are not all selected; otherwise clear selection
   */
  masterToggle(): void {
    if (this.isAllSelected()) {
      this.selection.clear();
    } else {
      this.dataSource.data.forEach((row) => this.selection.select(row));
    }
    this.onSelectionChange();
  }

  /**
   * Toggle row selection
   */
  toggleRow(row: T): void {
    this.selection.toggle(row);
    this.onSelectionChange();
  }

  /**
   * Check if row is selected
   */
  isSelected(row: T): boolean {
    return this.selection.isSelected(row);
  }

  /**
   * Handle selection change
   */
  private onSelectionChange(): void {
    const selected = this.selection.selected;
    this.selectedRows.set(selected);
    this.selectionChange.emit(selected);
  }

  // ============ SORT METHODS ============

  /**
   * Handle sort change
   */
  onSortChange(): void {
    const sortInstance = this.sort();
    if (sortInstance) {
      this.sortChange.emit({
        active: sortInstance.active,
        direction: sortInstance.direction,
      });
    }
  }

  // ============ PAGINATION METHODS ============

  /**
   * Handle page change
   */
  onPageChange(event: PageEvent): void {
    this.pageChange.emit(event);
  }

  // ============ EXPORT METHODS ============

  /**
   * Export data to CSV
   */
  exportToCsv(): void {
    this.exportData.emit('csv');
  }

  /**
   * Get column alignment class
   */
  getColumnAlignClass(
    column: TableColumnDef<T>,
    isHeader: boolean = false,
  ): string {
    const align = isHeader
      ? (column.headerAlign ?? column.align)
      : column.align;
    return align ? `align-${align}` : 'align-left';
  }

  /**
   * Get column width style
   */
  getColumnWidthStyle(column: TableColumnDef<T>): Record<string, string> {
    const style: Record<string, string> = {};

    if (column.width) {
      style['width'] = column.width;
    }
    if (column.minWidth) {
      style['min-width'] = column.minWidth;
    }
    if (column.maxWidth) {
      style['max-width'] = column.maxWidth;
    }

    return style;
  }

  /**
   * Track by function for columns
   */
  trackByColumnId(index: number, column: TableColumnDef<T>): string {
    return column.id;
  }

  /**
   * Track by function for rows
   * Uses the required 'id' property for optimal performance
   */
  trackByRow(index: number, row: T): unknown {
    return row.id;
  }
}

