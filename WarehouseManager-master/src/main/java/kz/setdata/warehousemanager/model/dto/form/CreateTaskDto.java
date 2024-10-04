package kz.setdata.warehousemanager.model.dto.form;

import kz.setdata.warehousemanager.model.dto.TaskNomenclatureDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CreateTaskDto {
    private String login;

    private String taskType;
    private List<TaskNomenclatureDTO> nomenclatures;
    private String comments;
    private long constructorId;
    private long taskStatusId;
    private String manager;

    private List<String> files;

}
