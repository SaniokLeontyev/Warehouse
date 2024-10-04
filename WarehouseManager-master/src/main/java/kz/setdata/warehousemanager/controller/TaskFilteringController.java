package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import io.swagger.v3.oas.annotations.Parameter;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.dto.TaskDtoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/tasks")
@RestController
@Api(value = "Operations related to tasks filtering", tags = {"Tasks filtering"})
public class TaskFilteringController {

    private final TaskDtoService taskDtoService;

    @GetMapping
    public ResponseEntity<ResponseDto> getTasks(@RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getAll(page));
    }

    @GetMapping(value = "/sorted/byCreateDate")
    public ResponseEntity<ResponseDto> getTasksCreateDate(@RequestParam(name = "sortType", required = false)
                                                          @Parameter(name = "sortType", description = "Sorting type; Default=ASC", example = "ASC or DESC")
                                                          String sortType,
                                                          @RequestParam(name = "login", required = false)
                                                          @Parameter(name = "login", description = "Login of task executor")
                                                          String login,
                                                          @RequestParam(name = "taskType", required = false)
                                                          @Parameter(name = "taskType")
                                                          String taskType,
                                                          @Parameter(required = true)
                                                          @RequestParam("page") int page) {
        if (sortType != null) {
            if (sortType.equals("DESC")) {
                if (login != null && taskType != null) {
                    return ResponseEntity.ok(taskDtoService.getAllCreateDateDescByTaskTypeAndLogin(taskType,login,page));
                }
                if (login != null){
                    return ResponseEntity.ok(taskDtoService.getAllCreateDateDescByLogin(login,page));
                }
                if (taskType != null){
                    return ResponseEntity.ok(taskDtoService.getAllCreateDateDescByTaskType(taskType,page));
                }
                return ResponseEntity.ok(taskDtoService.getAllCreateDateDesc(page));
            }
        }
        if (login != null && taskType != null) {
            return ResponseEntity.ok(taskDtoService.getAllCreateDateAscByTaskTypeAndLogin(taskType,login,page));
        }
        if (login != null){
            return ResponseEntity.ok(taskDtoService.getAllCreateDateAscByLogin(login,page));
        }
        if (taskType != null){
            return ResponseEntity.ok(taskDtoService.getAllCreateDateAscByTaskType(taskType,page));
        }
        return ResponseEntity.ok(taskDtoService.getAllCreateDateAsc(page));
    }

    @GetMapping(params = {"login"})
    public ResponseEntity<ResponseDto> getTasksByLogin(@RequestParam(value = "login") String login,
                                                       @Parameter(name = "page", required = true)
                                                       @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByLogin(login, page));
    }

    @GetMapping(params = {"taskType"})
    public ResponseEntity<ResponseDto> getTasksByTaskType(@RequestParam(value = "taskType") String taskType,
                                                          @Parameter(name = "page", required = true)
                                                          @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByTaskType(taskType, page));
    }

    @GetMapping(params = {"from", "to"})
    public ResponseEntity<ResponseDto> getByDate(@Parameter(name = "from", description = "Format: YYYYMMDD", example = "20221229", required = true)
                                                 @RequestParam("from") String from,
                                                 @Parameter(name = "to",
                                                         description = "Format: YYYYMMDD",
                                                         example = "20230101",
                                                         required = true)
                                                 @RequestParam("to") String to,
                                                 @Parameter(name = "sortType",
                                                         description = "Sorting type; Default=ASC",
                                                         example = "ASC or DESC")
                                                 @RequestParam(value = "sortType", required = false)
                                                 String sortType,
                                                 @Parameter(name = "page", required = true)
                                                 @RequestParam("page") int page) {
        if (sortType != null) {
            if (sortType.equals("DESC")) {
                return ResponseEntity.ok(taskDtoService.getByDateBetweenDesc(from, to, page));
            }
        }
        return ResponseEntity.ok(taskDtoService.getByDateBetweenAsc(from, to, page));
    }

    @GetMapping(params = {"dateGreaterThan"})
    public ResponseEntity<ResponseDto> getByDateFrom(@Parameter(name = "dateGreaterThan", description = "Format: YYYYMMDD", example = "20221229", required = true)
                                                     @RequestParam("dateGreaterThan") String dateGreaterThan,
                                                     @Parameter(name = "sortType",
                                                             description = "Sorting type; Default=ASC",
                                                             example = "ASC or DESC")
                                                     @RequestParam(value = "sortType", required = false) String sortType,
                                                     @Parameter(name = "page", required = true)
                                                     @RequestParam("page") int page) {
        if (sortType != null) {
            if (sortType.equals("DESC")) {
                return ResponseEntity.ok(taskDtoService.getByDateFromDesc(dateGreaterThan, page));
            }
        }
        return ResponseEntity.ok(taskDtoService.getByDateFromAsc(dateGreaterThan, page));
    }

    @GetMapping(params = {"dateLessThan"})
    public ResponseEntity<ResponseDto> getByDateBefore(@Parameter(name = "dateLessThan", description = "Format: YYYYMMDD", example = "20221229", required = true)
                                                       @RequestParam("dateLessThan") String dateLessThan,
                                                       @Parameter(name = "page", required = true)
                                                       @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByDateBefore(dateLessThan, page));
    }

    @GetMapping(params = {"login", "taskType"})
    public ResponseEntity<ResponseDto> getByUserAndTask(@Parameter(name = "login", required = true)
                                                        @RequestParam("login") String login,
                                                        @Parameter(name = "taskType", required = true)
                                                        @RequestParam("taskType") String taskType,
                                                        @Parameter(name = "page", required = true)
                                                        @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByUserAndTask(login, taskType, page));
    }

    @GetMapping(params = {"login", "taskType", "from", "to"})
    public ResponseEntity<ResponseDto> getByUserAndTaskBetweenDates(@Parameter(name = "login", required = true)
                                                                    @RequestParam("login") String login,
                                                                    @Parameter(name = "taskType", required = true)
                                                                    @RequestParam("taskType") String taskType,
                                                                    @Parameter(name = "from",
                                                                            description = "Format: YYYYMMDD",
                                                                            example = "20221229",
                                                                            required = true)
                                                                    @RequestParam("from") String from,
                                                                    @Parameter(name = "to",
                                                                            description = "Format: YYYYMMDD",
                                                                            example = "20230101",
                                                                            required = true)
                                                                    @RequestParam("to") String to,
                                                                    @Parameter(required = true)
                                                                    @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByUserAndTaskBetweenDates(login, taskType, from, to, page));
    }

    @GetMapping(params = {"login", "taskType", "from"})
    public ResponseEntity<ResponseDto> getByUserAndTaskAfterDate(@Parameter(name = "login", required = true)
                                                                  @RequestParam("login") String login,
                                                                  @Parameter(name = "taskType", required = true)
                                                                  @RequestParam("taskType") String taskType,
                                                                  @Parameter(name = "from",
                                                                          description = "Format: YYYYMMDD",
                                                                          example = "20221229",
                                                                          required = true)
                                                                  @RequestParam("from") String from,
                                                                  @Parameter(required = true)
                                                                  @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByUserAndTaskAfterDates(login, taskType, from, page));
    }

    @GetMapping(params = {"login", "taskType", "to"})
    public ResponseEntity<ResponseDto> getByUserAndTaskBeforeDate(@Parameter(name = "login", required = true)
                                                                   @RequestParam("login") String login,
                                                                   @Parameter(name = "taskType", required = true)
                                                                   @RequestParam("taskType") String taskType,
                                                                   @Parameter(name = "to",
                                                                           description = "Format: YYYYMMDD",
                                                                           example = "20221229",
                                                                           required = true)
                                                                   @RequestParam("to") String to,
                                                                   @Parameter(required = true)
                                                                   @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByUserAndTaskBeforeDates(login, taskType, to, page));
    }

    @GetMapping(params = {"taskType", "to"})
    public ResponseEntity<ResponseDto> getByTaskBeforeDate(@Parameter(name = "taskType", required = true)
                                                            @RequestParam("taskType") String taskType,
                                                            @Parameter(name = "to",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("to") String to,
                                                            @Parameter(required = true)
                                                            @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByTaskBeforeDates(taskType, to, page));
    }

    @GetMapping(params = {"taskType", "from"})
    public ResponseEntity<ResponseDto> getByTaskAfterDate(@Parameter(name = "taskType", required = true)
                                                            @RequestParam("taskType") String taskType,
                                                            @Parameter(name = "from",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("from") String from,
                                                            @Parameter(required = true)
                                                            @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByTaskAfterDates(taskType, from, page));
    }

    @GetMapping(params = {"taskType", "from", "to"})
    public ResponseEntity<ResponseDto> getByTaskBetweenDates(@Parameter(name = "taskType", required = true)
                                                            @RequestParam("taskType") String taskType,
                                                            @Parameter(name = "from",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("from") String from,
                                                             @Parameter(name = "to",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("to") String to,
                                                            @Parameter(required = true)
                                                            @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByTaskBetweenDates(taskType, from, to, page));
    }

    @GetMapping(params = {"login", "from", "to"})
    public ResponseEntity<ResponseDto> getByLoginBetweenDates(@Parameter(name = "login", required = true)
                                                            @RequestParam("login") String login,
                                                            @Parameter(name = "from",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("from") String from,
                                                             @Parameter(name = "to",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("to") String to,
                                                            @Parameter(required = true)
                                                            @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByLoginBetweenDates(login, from, to, page));
    }

    @GetMapping(params = {"login", "from"})
    public ResponseEntity<ResponseDto> getByLoginGreaterDate(@Parameter(name = "login", required = true)
                                                            @RequestParam("login") String login,
                                                            @Parameter(name = "from",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("from") String from,
                                                            @Parameter(required = true)
                                                            @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByLoginGreaterDate(login, from, page));
    }

    @GetMapping(params = {"login", "to"})
    public ResponseEntity<ResponseDto> getByLoginLessDate(@Parameter(name = "login", required = true)
                                                            @RequestParam("login") String login,
                                                            @Parameter(name = "to",
                                                                    description = "Format: YYYYMMDD",
                                                                    example = "20221229",
                                                                    required = true)
                                                            @RequestParam("to") String to,
                                                            @Parameter(required = true)
                                                            @RequestParam("page") int page) {
        return ResponseEntity.ok(taskDtoService.getByLoginLessDate(login, to, page));
    }
}
