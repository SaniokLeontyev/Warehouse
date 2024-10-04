package kz.setdata.warehousemanager.model.dto;

import kz.setdata.warehousemanager.model.dto.constructor.ItemAttributesDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TaskDto {
    private long id;

    private UserDto userDto;

    private String taskType;
    private String comment;
    private List<ItemAttributesDTO> itemAttributesDTO;
    private long constructorId;

    private LocalDateTime createDate;
    private LocalDateTime editDate;

    private String uuid;

    private long taskStatusId;
    private UserDto manager;

    private List<String> files;

}
