package kz.setdata.warehousemanager.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MoveItemAttributeDTO {
    private long id;
    @JsonProperty("from_shelf_id")
    private long fromShelfId;
    @JsonProperty("to_shelf_id")
    private long toShelfId;
}
