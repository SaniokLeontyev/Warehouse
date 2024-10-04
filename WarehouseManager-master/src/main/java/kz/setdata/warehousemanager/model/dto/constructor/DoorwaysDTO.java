package kz.setdata.warehousemanager.model.dto.constructor;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DoorwaysDTO{
    private long id;
    @JsonProperty("x")
    private String coordinateX;

    @JsonProperty("y")
    private String coordinateY;

    private boolean draggable;
    @JsonProperty("fill_pattern_image")
    private String fillPatternImage;
    private int height;
    private int width;
    private String name;
    private double opacity;
    private int rotation;
}
