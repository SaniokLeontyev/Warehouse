package kz.setdata.warehousemanager.service.dto;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.model.*;
import kz.setdata.warehousemanager.model.dto.TaskDto;
import kz.setdata.warehousemanager.model.dto.form.CreateTaskDto;
import kz.setdata.warehousemanager.model.dto.form.CreateTaskWithShelfNomenclatureDto;
import kz.setdata.warehousemanager.model.dto.general.PaginationDto;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.repository.impl.*;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.HistService;
import kz.setdata.warehousemanager.service.ValueService;
import kz.setdata.warehousemanager.variable.Util;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class TaskDtoService {
    private final TaskService taskService;
    private final AccountService accountService;
    private final TaskTypeService taskTypeService;
    private final UserService userService;
    private final TaskNomenclatureService taskNomenclatureService;
    private final ConstructorService constructorService;

    private final TaskStatusService taskStatusService;
    private final RoleService roleService;
    private final TaskFileService taskFileService;
    private final ItemAttrShelfService itemAttributesShelfService;
    private final HistService histService;

    private EntityMapper entityMapper;

    @Autowired
    private void setEntityMapper(EntityMapper entityMapper) {
        this.entityMapper = entityMapper;
    }

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd HH:mm");

    public ResponseDto getAll(int page) {
        Page<Task> tasksPage = taskService.getAllTasks(page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAsc(int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateAsc(page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDesc(int page) {
        Page<Task> tasksPage = taskService.findAllOrderByDesc(page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByLogin(String login, int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateAscByLogin(page,login);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByLogin(String login, int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateDescByLogin(page,login);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskType(String taskType, int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateAscByTaskType(page,taskType);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskType(String taskType, int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateDescByTaskType(page,taskType);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskTypeAndLogin(String taskType, String login, int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateAscByTaskTypeAndLogin(page,taskType,login);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskTypeAndLogin(String taskType, String login, int page) {
        Page<Task> tasksPage = taskService.getAllTasksCreateDateDescByTaskTypeAndLogin(page,taskType,login);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByLogin(String login, int page) {
        Account account = accountService.getAccountByLogin(login);
        Page<Task> tasksPage = taskService.getAllByUserId(account.getUser().getId(), page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByTaskType(String taskTypeName, int page) {
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        Page<Task> tasksPage = taskService.getAllByTaskType(taskType, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    @Transactional
    public TaskDto saveTask(CreateTaskDto createTaskDto) {
        Task task = new Task();
        task.setCreateDate(ValueService.getTime());
        task.setEditDate(ValueService.getTime());
        task.setComments(createTaskDto.getComments());
        task.setUuid(Util.generateUUID());
        task.setTaskType(taskTypeService.getByName(createTaskDto.getTaskType()));
        Constructor constructor = constructorService.getById(createTaskDto.getConstructorId());
        task.setConstructor(constructor);
        TaskStatus taskStatus = taskStatusService.getStatusById(createTaskDto.getTaskStatusId());
        task.setTaskStatus(taskStatus);
        Account account = accountService.getAccountByLogin(createTaskDto.getLogin());
        User user = userService.getById(account.getUser().getId());
        task.setUser(user);
        Account creator;
        if (createTaskDto.getManager() != null) {
            creator = accountService.getAccountByLogin(createTaskDto.getManager());
            task.setCreator(creator.getUser());
        } else {
            Role role = roleService.getRoleByName("ADMINISTRATOR");
            creator = accountService.getAdminAccounts(role.getId()).get(0);
        }
        task.setCreator(creator.getUser());
        List<String> s3urls = new ArrayList<>();
        if (createTaskDto.getFiles() != null && !createTaskDto.getFiles().isEmpty()) {
            s3urls = taskFileService.saveTaskFilesToS3(task.getUuid(), createTaskDto.getFiles());
        }
        task = taskService.save(task);
        Map<ItemAttrShelf, Integer> taskItemAttrs = null;
        if (task.getTaskType().getName().equals("shipment") ||
                task.getTaskType().getName().equals("receipt_from_warehouse") ||
                task.getTaskType().getName().equals("write_off") ||
                task.getTaskType().getName().equals("return")
        ) {
            taskItemAttrs = taskNomenclatureService.buildTaskNomenclature(createTaskDto.getNomenclatures());
        } else {
            taskItemAttrs = taskNomenclatureService.buildTaskNomenclatureNoMinus(createTaskDto.getNomenclatures());
        }
        if (taskItemAttrs == null || taskItemAttrs.isEmpty())
            throw new CRUDOperationException("ItemAttributeShelf not found");
        taskNomenclatureService.save(taskNomenclatureService.build(task, taskItemAttrs));
        taskFileService.save(task, s3urls);
        return entityMapper.mapTaskDto(task, s3urls);
    }

    public TaskDto saveTaskWithShelfId(CreateTaskWithShelfNomenclatureDto createTaskWithShelfNomenclatureDto) {
        Task task = new Task();
        task.setCreateDate(ValueService.getTime());
        task.setComments(createTaskWithShelfNomenclatureDto.getComments());
        task.setUuid(Util.generateUUID());
        List<String> s3urls = taskFileService.saveTaskFilesToS3(task.getUuid(), createTaskWithShelfNomenclatureDto.getFiles());

        task.setTaskType(taskTypeService.getByName(createTaskWithShelfNomenclatureDto.getTaskType()));
        Constructor constructor = constructorService.getById(createTaskWithShelfNomenclatureDto.getConstructorId());
        task.setConstructor(constructor);
        Account account = accountService.getAccountByLogin(createTaskWithShelfNomenclatureDto.getLogin());
        User user = userService.getById(account.getUser().getId());
        task.setUser(user);
        Account manager = accountService.getAccountByLogin(createTaskWithShelfNomenclatureDto.getManager());
        task.setCreator(manager.getUser());
        task.setTaskStatus(taskStatusService.getStatusById(createTaskWithShelfNomenclatureDto.getTaskStatusId()));
        task = taskService.save(task);
        Map<ItemAttrShelf, Integer> taskItemAttrs = taskNomenclatureService
                .buildTaskNomenclatureWithShelf(createTaskWithShelfNomenclatureDto.getShelves());
        if (taskItemAttrs.isEmpty()) throw new CRUDOperationException("ItemAttrShelf not found");
        taskNomenclatureService.save(taskNomenclatureService.build(task, taskItemAttrs));
        taskFileService.save(task, s3urls);
        return entityMapper.mapTaskDto(task, s3urls);
    }

    public TaskDto updateUser(long taskId, String login) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        task.setUser(user);
        taskService.save(task);
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    @Transactional
    public TaskDto closeTask(long taskId) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        task.setTaskStatus(taskStatusService.getClosedStatus());
        List<TaskNomenclature> taskNomenclatures = taskNomenclatureService.getTaskNomenclature(taskId);
        List<ItemAttrShelf> itemAttributesShelf = new ArrayList<>();
        List<ItemAttrShelf> itemAttributesShelfToDelete = new ArrayList<>();
        for (TaskNomenclature taskNomenclature : taskNomenclatures) {
            ItemAttrShelf itemAttrShelf = taskNomenclature.getItemAttrShelf();
            int overallQuantity = taskNomenclature.getItemAttrShelf().getItemAttributes().getQuantity();
            int finalQuantity = overallQuantity - taskNomenclature.getQuantity();
            if (finalQuantity == 0) {
                itemAttributesShelf.add(itemAttrShelf);
                itemAttributesShelfToDelete.add(itemAttrShelf);
            }else {
                if (task.getTaskType().getName().equals("shipment") ||
                        task.getTaskType().getName().equals("receipt_from_warehouse") ||
                        task.getTaskType().getName().equals("write_off") ||
                        task.getTaskType().getName().equals("return")
                ){
                    itemAttrShelf.getItemAttributes().setQuantity(finalQuantity);
                }
                itemAttributesShelf.add(itemAttrShelf);
                itemAttributesShelfService.saveItemAttributesShelves(itemAttributesShelf);
            }
        }
        List<TaskFile> taskFiles = taskFileService.getByTaskId(taskId);
        histService.histTask(itemAttributesShelf,task,taskNomenclatures,taskFiles);
        taskNomenclatureService.delete(taskNomenclatures);
        itemAttributesShelfService.delete(itemAttributesShelfToDelete);
        taskFileService.delete(taskFiles);
        taskService.delete(task);
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    public void deleteNomenclature(long taskId, long nomenclatureId) {
        taskNomenclatureService.deleteNomenclatureFromTask(taskId, nomenclatureId);
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        taskService.save(task);
    }

    public TaskDto updateNomenclature(long taskId, long nomenclatureId, int quantity) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        ItemAttrShelf itemAttrShelf = itemAttributesShelfService.getById(nomenclatureId);
        taskNomenclatureService.save(new TaskNomenclature(task, itemAttrShelf, quantity));
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    public TaskDto updateNomenclatureByShelf(long taskId, long shelfId) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        List<ItemAttrShelf> itemAttrShelves = itemAttributesShelfService.getShelfItemAttributes(shelfId);
        List<TaskNomenclature> taskNomenclatures = new ArrayList<>();
        for (ItemAttrShelf itemAttributeShelf : itemAttrShelves) {
            taskNomenclatures.add(new TaskNomenclature(task, itemAttributeShelf, itemAttributeShelf.getQuantity()));
        }
        taskNomenclatureService.save(taskNomenclatures);
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    public TaskDto updateComment(long taskId, String comment) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        task.setComments(comment);
        taskService.save(task);
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    public TaskDto updateTaskStatus(long taskId, long taskStatusId) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        TaskStatus taskStatus = taskStatusService.getStatusById(taskStatusId);
        task.setTaskStatus(taskStatus);
        taskService.save(task);
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    public TaskDto updateTaskType(long taskId, String taskTypeName) {
        Task task = taskService.getById(taskId);
        task.setEditDate(ValueService.getTime());
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        if (taskType == null) throw new CRUDOperationException("Wrong task type name");
        task.setTaskType(taskType);
        taskService.save(task);
        List<TaskFile> s3urls = taskFileService.getByTaskId(taskId);
        return entityMapper.mapTaskDto(task, taskFileService.getTaskS3Urls(s3urls));
    }

    public ResponseDto getByDateBetweenAsc(String from, String to, int page) {
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getByDateBetweenAsc(dateFrom, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByDateBetweenDesc(String from, String to, int page) {
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getByDateBetweenDesc(dateFrom, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByDateFromAsc(String date, int page) {
        LocalDateTime dateFrom = LocalDateTime.parse(date + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getByDateFromAsc(dateFrom, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByDateFromDesc(String date, int page) {
        LocalDateTime dateFrom = LocalDateTime.parse(date + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getByDateFromDesc(dateFrom, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByDateBefore(String date, int page) {
        LocalDateTime dateFrom = LocalDateTime.parse(date + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getByDateBefore(dateFrom, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByUserAndTask(String login, String taskTypeName, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        Page<Task> tasksPage = taskService.getAllByUserAndTaskType(user, taskType, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByUserAndTaskBetweenDates(String login, String taskTypeName, String from, String to, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByUserAndTaskTypeBetweenDates(user, taskType, dateFrom, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByUserAndTaskAfterDates(String login, String taskTypeName, String from, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByUserAndTaskTypeFromDate(user, taskType, dateFrom, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByUserAndTaskBeforeDates(String login, String taskTypeName, String to, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByUserAndTaskTypeBeforeDate(user, taskType, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByTaskBeforeDates(String taskTypeName, String to, int page) {
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByTaskTypeBeforeDate(taskType, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByTaskAfterDates(String taskTypeName, String from, int page) {
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByTaskTypeAfterDate(taskType, dateFrom, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByTaskBetweenDates(String taskTypeName, String from, String to, int page) {
        TaskType taskType = taskTypeService.getByName(taskTypeName);
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByTaskTypeBetweenDate(taskType, dateFrom, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByLoginBetweenDates(String login, String from, String to, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByLoginTypeBetweenDate(user, dateFrom, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByLoginGreaterDate(String login, String from, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        LocalDateTime dateFrom = LocalDateTime.parse(from + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByLoginTypeGreaterDate(user, dateFrom, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }

    public ResponseDto getByLoginLessDate(String login, String to, int page) {
        Account account = accountService.getAccountByLogin(login);
        User user = userService.getById(account.getUser().getId());
        LocalDateTime dateTo = LocalDateTime.parse(to + " 00:00", FORMATTER);
        Page<Task> tasksPage = taskService.getAllByLoginTypeLessDate(user, dateTo, page);
        List<Task> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(entityMapper.mapTaskDtoList(tasks), paginationDto);
    }
}
