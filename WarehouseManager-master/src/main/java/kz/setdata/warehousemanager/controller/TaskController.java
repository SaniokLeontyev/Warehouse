package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.form.CreateTaskDto;
import kz.setdata.warehousemanager.model.dto.form.CreateTaskWithShelfNomenclatureDto;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.model.excel.TaskExcel;
import kz.setdata.warehousemanager.repository.impl.TaskNomenclatureService;
import kz.setdata.warehousemanager.service.ValueService;
import kz.setdata.warehousemanager.service.dto.TaskDtoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Slf4j
@RequestMapping("/api/tasks")
@RestController
@Api(value = "Operations related to tasks", tags = {"Tasks"})
public class TaskController {

    private TaskDtoService taskDtoService;
    private TaskNomenclatureService taskNomenclatureService;

    @Autowired
    private void setTaskDtoService(TaskDtoService taskDtoService) {
        this.taskDtoService = taskDtoService;
    }

    @Autowired
    private void setTaskNomenclatureService(TaskNomenclatureService taskNomenclatureService) {
        this.taskNomenclatureService = taskNomenclatureService;
    }

    @PutMapping
    public ResponseEntity<ResponseDto> createTask(@RequestBody CreateTaskDto createTaskDto) {
        log.info("[CREATE TASK REQUEST] Body: {}", ValueService.toJSON(createTaskDto));
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.saveTask(createTaskDto)));
    }

    @PutMapping("/withShelf")
    public ResponseEntity<ResponseDto> createInventoryTask(@RequestBody CreateTaskWithShelfNomenclatureDto createTaskWithShelfNomenclatureDto) {
        log.info("[CREATE TASK WITH SHELF REQUEST] Body: {}",ValueService.toJSON(createTaskWithShelfNomenclatureDto));
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.saveTaskWithShelfId(createTaskWithShelfNomenclatureDto)));
    }

    @PatchMapping("/user/{taskId}/{login}")
    public ResponseEntity<ResponseDto> updateUser(@PathVariable long taskId, @PathVariable String login) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.updateUser(taskId, login)));
    }

    @PatchMapping("/nomenclature/{taskId}/{nomenclatureId}/{quantity}")
    public ResponseEntity<ResponseDto> updateNomenclature(@PathVariable long taskId,
                                                          @PathVariable long nomenclatureId,
                                                          @PathVariable int quantity) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.updateNomenclature(taskId, nomenclatureId, quantity)));
    }

    @PatchMapping("/nomenclature/{taskId}/{shelfId}")
    public ResponseEntity<ResponseDto> updateNomenclatureByShelf(@PathVariable long taskId, @PathVariable long shelfId) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.updateNomenclatureByShelf(taskId, shelfId)));
    }

    @PatchMapping("/comment/{taskId}")
    public ResponseEntity<ResponseDto> updateComment(@PathVariable long taskId, @RequestBody String comment) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.updateComment(taskId, comment)));
    }

    @PatchMapping("/taskStatus/{taskId}/{taskStatusId}")
    public ResponseEntity<ResponseDto> updateTaskStatus(@PathVariable long taskId, @PathVariable long taskStatusId) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.updateTaskStatus(taskId, taskStatusId)));
    }

    @PatchMapping("/taskType/{taskId}/{taskType}")
    public ResponseEntity<ResponseDto> updateTaskType(@PathVariable long taskId, @PathVariable String taskType) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.updateTaskType(taskId, taskType)));
    }

    @PatchMapping("/closeTask/{taskId}")
    public ResponseEntity<ResponseDto> closeTask(@PathVariable long taskId) {
        return ResponseEntity.ok(ResponseDto.success(taskDtoService.closeTask(taskId)));
    }

    @DeleteMapping("/nomenclature/{taskId}/{nomenclatureId}")
    public ResponseEntity<ResponseDto> deleteItemAttribute(@PathVariable long taskId, @PathVariable long nomenclatureId) {
        taskDtoService.deleteNomenclature(taskId, nomenclatureId);
        return ResponseEntity.ok(ResponseDto.success(null));
    }

    @PostMapping("/excel")
    public void getExcel(@RequestBody List<TaskExcel> taskExcels, HttpServletResponse response) throws IOException {
        taskNomenclatureService.excelTask(taskExcels, response);
    }
}
