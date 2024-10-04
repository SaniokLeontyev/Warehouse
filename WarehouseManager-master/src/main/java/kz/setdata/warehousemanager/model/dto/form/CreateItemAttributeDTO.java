package kz.setdata.warehousemanager.model.dto.form;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CreateItemAttributeDTO {
    private String conditionType;
    private String nomenclature;
    private String units;
    private String uuid;
    private int quantity;
    @JsonProperty("start_date")
    private LocalDateTime startDate;
    @JsonProperty("end_date")
    private LocalDateTime endDate;
}
