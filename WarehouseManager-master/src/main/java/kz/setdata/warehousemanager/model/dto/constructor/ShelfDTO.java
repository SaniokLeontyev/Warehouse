package kz.setdata.warehousemanager.model.dto.constructor;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import javax.persistence.Column;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ShelfDTO{
    private long id;
    @JsonProperty("shelf_level")
    private int shelfLevel;
    @JsonProperty("cells_per_width")
    private int cellsPerWidth;
    @JsonProperty("cells_per_depth")
    private int cellsPerDepth;

    @JsonProperty("x")
    private String coordinateX;
    @JsonProperty("y")
    private String coordinateY;
    private String fill;
    private int opacity;
    private boolean draggable;
    private String name;
    private double width;
    private double height;
    private int rotation;

    @JsonProperty("cell_height")
    private double cellHeight;
    @JsonProperty("cell_width")
    private double cellWidth;

    @JsonProperty("rack_height")
    private int rackHeight;

    @JsonProperty("rack_id")
    private String rackId;

    @JsonProperty("item_attributes")
    private List<ItemAttributesDTO> itemAttributes;

    @JsonProperty("zone_names")
    private List<String> zoneNames;

}
