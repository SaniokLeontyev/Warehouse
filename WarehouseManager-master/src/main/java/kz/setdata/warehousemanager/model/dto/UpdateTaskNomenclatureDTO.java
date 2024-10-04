package kz.setdata.warehousemanager.model.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
public class UpdateTaskNomenclatureDTO {

    private List<TaskNomenclaturesDTO> taskNomenclatures;

    @Data
    public static class TaskNomenclaturesDTO{
        @Schema(description = "Id of itemAttribute inside task")
        private long id;
        private int quantity;
    }
}
