package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.repository.impl.TaskTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/taskTypes")
@RestController
@Api(value = "Operations related to task types", tags = {"Task types"})
public class TaskTypeController {
    private final TaskTypeService taskTypeService;

    @GetMapping
    public ResponseEntity<ResponseDto> getTaskTypes(){
        return ResponseEntity.ok(ResponseDto.success(taskTypeService.getAll()));
    }
}
