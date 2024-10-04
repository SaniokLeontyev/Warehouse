package kz.setdata.warehousemanager.service.mapper;

import kz.setdata.warehousemanager.model.TaskNomenclature;
import kz.setdata.warehousemanager.model.excel.TaskExcel;

import java.util.ArrayList;
import java.util.List;

public class ExcelEntityMapper {

    //TODO: ADD Measurement
    public static TaskExcel toTaskExcel(TaskNomenclature taskNomenclature){
        TaskExcel taskExcel = new TaskExcel();
        taskExcel.setUuid(taskNomenclature.getTask().getUuid());
        taskExcel.setQuantity(taskNomenclature.getQuantity());
        taskExcel.setNomenclature(taskNomenclature.getItemAttrShelf().getItemAttributes().getNomenclature());
        taskExcel.setShelf(taskNomenclature.getItemAttrShelf().getShelves().getRackId());
        return taskExcel;
    }

    public static List<TaskExcel> toTaskExcel(List<TaskNomenclature> taskNomenclatures){
        List<TaskExcel> taskExcels = new ArrayList<>();
        for (TaskNomenclature taskNomenclature : taskNomenclatures) {
            taskExcels.add(toTaskExcel(taskNomenclature));
        }
        return taskExcels;
    }
}
