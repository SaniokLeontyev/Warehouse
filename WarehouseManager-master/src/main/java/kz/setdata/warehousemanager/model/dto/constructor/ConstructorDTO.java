package kz.setdata.warehousemanager.model.dto.constructor;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ConstructorDTO{
    private long id;
    private int width;
    private int height;
    private String name;
    private List<WallsDTO> walls;
    private List<DoorwaysDTO> doorways;
    private List<WindowsDTO> windows;
    private List<ZoneDTO> zones;
    private List<ShelfDTO> shelves;

}
