package kz.setdata.warehousemanager.model.dto.form;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CreateTaskWithShelfNomenclatureDto {

    private String login;
    private String taskType;
    private List<Long> shelves;
    private String comments;
    private long constructorId;
    @JsonProperty("task_status_id")
    private long taskStatusId;
    private String manager;

    private List<String> files;
}
