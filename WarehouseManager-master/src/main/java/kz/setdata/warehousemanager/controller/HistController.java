package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import io.swagger.v3.oas.annotations.Parameter;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.HistService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequestMapping("/api/tasksHistory")
@RestController
@Api(value = "Operations related to tasks history")
@RequiredArgsConstructor
public class HistController {
    private final HistService histService;

    @GetMapping
    public ResponseEntity<ResponseDto> getTasks(@RequestParam("page") int page) {
        return ResponseEntity.ok(histService.getAll(page));
    }

    @GetMapping(value = "/sorted/byCreateDate")
    public ResponseEntity<ResponseDto> getHistTasksCreateDate(@RequestParam(name = "sortType", required = false)
                                                              @Parameter(name = "sortType", description = "Sorting type; Default=ASC", example = "ASC or DESC")
                                                              String sortType,
                                                              @RequestParam(name = "name", required = false)
                                                              @Parameter(name = "name", description = "Name of task executor")
                                                              String name,
                                                              @RequestParam(name = "surname", required = false)
                                                              @Parameter(name = "surname", description = "Surname of task executor")
                                                              String surname,
                                                              @RequestParam(name = "patronymic", required = false)
                                                              @Parameter(name = "patronymic", description = "Patronymic of task executor")
                                                              String patronymic,
                                                              @RequestParam(name = "taskType", required = false)
                                                              @Parameter(name = "taskType")
                                                              String taskType,
                                                              @Parameter(required = true)
                                                              @RequestParam("page") int page) {
        if (sortType != null) {
            if (sortType.equals("DESC")) {
                if (name != null && surname != null && patronymic != null && taskType != null) {
                    return ResponseEntity.ok(histService.getAllCreateDateDescByTaskTypeAndName(taskType, name, surname, patronymic, page));
                }
                if (name != null) {
                    if (surname == null && patronymic == null && taskType != null) {
                        return ResponseEntity.ok(histService.getAllCreateDateDescByTaskTypeAndName(taskType, name, page));
                    }
                    if (patronymic == null && taskType != null) {
                        return ResponseEntity.ok(histService.getAllCreateDateDescByTaskTypeAndName(taskType, name, surname, page));
                    }
                    if (surname != null){
                        if (patronymic != null) {
                            return ResponseEntity.ok(histService.getAllCreateDateDescByName(name,surname,patronymic,page));
                        }
                        return ResponseEntity.ok(histService.getAllCreateDateDescByName(name,surname,page));
                    }
                    return ResponseEntity.ok(histService.getAllCreateDateDescByName(name,page));
                }
                if (surname != null){
                    if (patronymic == null && taskType != null) {
                        return ResponseEntity.ok(histService.getAllCreateDateDescByTaskTypeAndName(taskType, surname, page));
                    }
                    return ResponseEntity.ok(histService.getAllCreateDateDescBySurname(surname,page));
                }
                if (taskType != null) {
                    return ResponseEntity.ok(histService.getAllCreateDateDescByTaskType(taskType, page));
                }
                return ResponseEntity.ok(histService.getAllCreateDateDesc(page));
            }
        }
        if (name != null && surname != null && patronymic != null && taskType != null) {
            return ResponseEntity.ok(histService.getAllCreateDateAscByTaskTypeAndName(taskType, name, surname, patronymic, page));
        }
        if (name != null) {
            if (surname == null && patronymic == null && taskType != null) {
                return ResponseEntity.ok(histService.getAllCreateDateAscByTaskTypeAndName(taskType, name, page));
            }
            if (patronymic == null && taskType != null) {
                return ResponseEntity.ok(histService.getAllCreateDateAscByTaskTypeAndName(taskType, name, surname, page));
            }
            if (surname != null){
                if (patronymic != null) {
                    return ResponseEntity.ok(histService.getAllCreateDateAscByName(name,surname,patronymic,page));
                }
                return ResponseEntity.ok(histService.getAllCreateDateAscByName(name,surname,page));
            }
            return ResponseEntity.ok(histService.getAllCreateDateAscByName(name,page));
        }
        if (surname != null){
            if (patronymic == null && taskType != null) {
                return ResponseEntity.ok(histService.getAllCreateDateAscByTaskTypeAndName(taskType, surname, page));
            }
            return ResponseEntity.ok(histService.getAllCreateDateAscBySurname(surname,page));
        }
        if (taskType != null) {
            return ResponseEntity.ok(histService.getAllCreateDateAscByTaskType(taskType, page));
        }
        return ResponseEntity.ok(histService.getAllCreateDateAsc(page));
    }
}
