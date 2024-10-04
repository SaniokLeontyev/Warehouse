package kz.setdata.warehousemanager.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
@NoArgsConstructor
public class TaskNomenclatureDTO {
    @Schema(description = "Id of itemAttr(nomenclature) on shelf")
    @JsonProperty("id")
    private long itemAttrShelfId;
    private int quantity;
}
