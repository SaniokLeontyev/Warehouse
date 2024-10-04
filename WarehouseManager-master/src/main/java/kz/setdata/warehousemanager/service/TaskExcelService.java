package kz.setdata.warehousemanager.service;

import kz.setdata.warehousemanager.model.excel.TaskExcel;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Service
public class TaskExcelService extends ExcelService {

    public void writeTableData(List<TaskExcel> data) {
        CellStyle style = getFontContentExcel();

        int startRow = 2;

        for (TaskExcel taskExcel : data) {
            Row row = sheet.createRow(startRow++);
            int columnCount = 0;
            createCell(row, columnCount++, taskExcel.getUuid(), style);
            createCell(row, columnCount++, taskExcel.getNomenclature(), style);
            createCell(row, columnCount++, taskExcel.getQuantity(), style);
            createCell(row, columnCount++, taskExcel.getMeasurement(), style);
            createCell(row, columnCount++, taskExcel.getShelf(), style);
        }
    }

    public void exportToExcel(HttpServletResponse response, List<TaskExcel> data) throws IOException {
        newReportExcel();

        // response  writer to excel
        response = initResponseForExportExcel(response, "TaskExcel");
        ServletOutputStream outputStream = response.getOutputStream();

        // write sheet, title & header
        String[] headers = new String[]{"ID задачи","Номеклатура", "Кол-во", "Ед. Измерения", "Номер стеллажа"};
        writeTableHeaderExcel("Sheet Task", "Накладная", headers);

        // write content row
        writeTableData(data);

        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }
}
