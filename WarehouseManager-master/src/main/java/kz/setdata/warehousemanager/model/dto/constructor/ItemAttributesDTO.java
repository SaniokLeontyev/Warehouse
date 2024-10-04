package kz.setdata.warehousemanager.model.dto.constructor;

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
public class ItemAttributesDTO{
    private long id;
    private String nomenclature;
    private String units;
    private int quantity;
    @JsonProperty("cell_number")
    private int cellNumber;
    @JsonProperty("shelf_level")
    private int shelfLevel;
    @JsonProperty("condition_type")
    private String conditionType;
    private String uuid;
    @JsonProperty("shelf_id")
    private long shelfId;

    @JsonProperty("start_date")
    private LocalDateTime startDate;
    @JsonProperty("end_date")
    private LocalDateTime endDate;

}
