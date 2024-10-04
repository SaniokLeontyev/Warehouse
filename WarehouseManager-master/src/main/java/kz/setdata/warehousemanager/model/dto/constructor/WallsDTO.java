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
public class WallsDTO{
    private long id;
    @JsonProperty("x")
    private String coordinateX;

    @JsonProperty("y")
    private String coordinateY;

    private String fill;
    private double opacity;
    private boolean draggable;
    private String name;
    private double width;
    private double height;
    private int rotation;
}
