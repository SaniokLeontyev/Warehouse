package kz.setdata.warehousemanager.model.hist.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class NomenclatureHistDTO {
    private Long id;

    private String nomenclature;

    private String units;

    private String uuid;

    @JsonProperty("condition_type")
    private String conditionType;

    @JsonProperty("start_date")
    private LocalDateTime startDate;

    @JsonProperty("end_date")
    private LocalDateTime endDate;
}
