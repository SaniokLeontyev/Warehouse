package kz.setdata.warehousemanager.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class ItemAttrShelfDTO {
    @JsonProperty("shelf_level")
    private int shelfLevel;
    @JsonProperty("cell_number")
    private int cellNumber;
    @JsonProperty("quantity")
    private int quantity;
    @JsonProperty("shelf_id")
    private long shelfId;
    @JsonProperty("item_attr_id")
    private long itemAttributeId;
}
