package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.repository.impl.TaskStatusService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/taskStatus")
@RestController
@Api(value = "Operations related to task statuses", tags = {"Task status"})
public class TaskStatusController {

    private final TaskStatusService taskStatusService;

    @GetMapping
    public ResponseEntity<?> getAll(){
        return ResponseEntity.ok(ResponseDto.success(taskStatusService.getAll()));
    }
}
