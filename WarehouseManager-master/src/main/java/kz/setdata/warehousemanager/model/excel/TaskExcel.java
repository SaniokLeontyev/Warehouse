package kz.setdata.warehousemanager.model.excel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TaskExcel {
    private String uuid;
    private String nomenclature;
    private int quantity;
    private String shelf;
    private String measurement;
}
