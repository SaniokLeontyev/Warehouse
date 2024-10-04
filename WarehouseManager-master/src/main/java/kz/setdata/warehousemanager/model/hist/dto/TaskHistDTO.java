package kz.setdata.warehousemanager.model.hist.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TaskHistDTO {
    private long id;
    private String comments;
    private String uuid;

    @JsonProperty("create_date")
    private LocalDateTime createDate;

    @JsonProperty("edit_date")
    private LocalDateTime editDate;

    @JsonProperty("user_name")
    private String userName;
    @JsonProperty("user_surname")
    private String userSurname;
    @JsonProperty("user_patronymic")
    private String userPatronymic;

    @JsonProperty("manager_name")
    private String managerName;
    @JsonProperty("manager_surname")
    private String managerSurname;
    @JsonProperty("manager_patronymic")
    private String managerPatronymic;

    @JsonProperty("task_type")
    private String taskType;

    @JsonProperty("constructor_name")
    private String constructorName;

    @JsonProperty("task_status")
    private String taskStatus;

    private List<String> files;

    private List<TaskNomenclatureHistDTO> nomenclature;

}
