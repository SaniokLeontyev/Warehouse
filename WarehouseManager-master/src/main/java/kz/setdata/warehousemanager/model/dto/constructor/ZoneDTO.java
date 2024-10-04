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
public class ZoneDTO{
    private long id;
    private String name;
    private String description;

    @JsonProperty("x")
    private String coordinateX;
    @JsonProperty("y")
    private String coordinateY;

    private boolean draggable;
    private String fill;
    private double height;
    private double width;
    private double opacity;
    private String title;
    private int rotation;
}
