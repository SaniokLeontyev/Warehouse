package kz.setdata.warehousemanager.service;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.model.*;
import kz.setdata.warehousemanager.model.dto.general.PaginationDto;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.model.hist.NomenclatureHist;
import kz.setdata.warehousemanager.model.hist.TaskFileHist;
import kz.setdata.warehousemanager.model.hist.TaskHist;
import kz.setdata.warehousemanager.model.hist.TaskNomenclatureHist;
import kz.setdata.warehousemanager.model.hist.dto.TaskHistDTO;
import kz.setdata.warehousemanager.repository.hist.TaskHistRepository;
import kz.setdata.warehousemanager.repository.hist.impl.NomenclatureHistService;
import kz.setdata.warehousemanager.repository.hist.impl.TaskFileHistService;
import kz.setdata.warehousemanager.repository.hist.impl.TaskHistService;
import kz.setdata.warehousemanager.repository.hist.impl.TaskNomenclatureHistService;
import kz.setdata.warehousemanager.service.mapper.HistEntityMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HistService {

    private final NomenclatureHistService nomenclatureHistService;
    private final TaskHistService taskHistService;
    private final TaskNomenclatureHistService taskNomenclatureHistService;
    private final TaskFileHistService taskFileHistService;
    private HistEntityMapper histEntityMapper;

    @Autowired
    private void setHistEntityMapper(HistEntityMapper histEntityMapper) {
        this.histEntityMapper = histEntityMapper;
    }

    @Transactional
    public TaskHist histTask(List<ItemAttrShelf> itemAttrShelves, Task task, List<TaskNomenclature> taskNomenclature, List<TaskFile> taskFiles){
        List<NomenclatureHist> nomenclatureHists = HistEntityMapper.toNomenclatureHist(itemAttrShelves);
        nomenclatureHistService.save(nomenclatureHists);
        TaskHist taskHist = HistEntityMapper.toTaskHist(task);
        taskHistService.save(taskHist);
        List<TaskNomenclatureHist> taskNomenclatureHists =
                HistEntityMapper.buildTaskNomenclatureHist(taskNomenclature,nomenclatureHists,taskHist);
        taskNomenclatureHistService.save(taskNomenclatureHists);
        List<TaskFileHist> taskFileHists = HistEntityMapper.toTaskFileHist(taskFiles, taskHist);
        taskFileHistService.save(taskFileHists);
        return taskHist;
    }

    public TaskHistDTO getTaskHistDTO(long taskId){
        TaskHist taskHist = taskHistService.findById(taskId);
        if(taskHist == null)
            throw new CRUDOperationException("Task with id " + taskId + " does not exist");
        List<TaskNomenclatureHist> taskNomenclatureHist = taskNomenclatureHistService.getByTaskId(taskId);
        List<TaskFileHist> taskFileHists = taskFileHistService.getTaskFileHistByTaskId(taskId);
        return HistEntityMapper.toTaskHistDTO(taskHist,taskNomenclatureHist,taskFileHists);
    }

    public List<TaskHistDTO> getAllTaskHistDTO(){
        List<TaskHistDTO> taskHistDTOList = new ArrayList<>();
        List<TaskHist> taskHistList = taskHistService.findAll();
        for(TaskHist taskHist : taskHistList){
            List<TaskNomenclatureHist> taskNomenclatureHist = taskNomenclatureHistService.getByTaskId(taskHist.getId());
            List<TaskFileHist> taskFileHists = taskFileHistService.getTaskFileHistByTaskId(taskHist.getId());
            taskHistDTOList.add(HistEntityMapper.toTaskHistDTO(taskHist,taskNomenclatureHist,taskFileHists));
        }
        return taskHistDTOList;
    }

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd HH:mm");

    public ResponseDto getAll(int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasks(page);
        List<TaskHist> taskHists = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(taskHists), paginationDto);
    }

    public ResponseDto getAllCreateDateAsc(int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAsc(page);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDesc(int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDesc(page);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByName(String name, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByName(page,name);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByName(String name, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByName(page,name);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscBySurname(String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscBySurname(page,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescBySurname(String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescBySurname(page,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByName(String name, String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByName(page,name,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByName(String name, String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByName(page,name,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByName(String name, String surname, String patronymic, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByName(page,name,surname,patronymic);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByName(String name, String surname, String patronymic, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByName(page,name,surname,patronymic);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskType(String taskType, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByTaskType(page,taskType);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskType(String taskType, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByTaskType(page,taskType);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskTypeAndName(String taskType, String name, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByTaskTypeAndName(page,taskType,name);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskTypeAndName(String taskType, String name, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByTaskTypeAndName(page,taskType,name);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskTypeAndSurname(String taskType, String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByTaskTypeAndSurname(page,taskType,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskTypeAndSurname(String taskType, String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByTaskTypeAndSurname(page,taskType,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskTypeAndName(String taskType, String name,String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByTaskTypeAndName(page,taskType,name,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskTypeAndName(String taskType, String name,String surname, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByTaskTypeAndName(page,taskType,name,surname);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateAscByTaskTypeAndName(String taskType, String name,String surname, String patronymic, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateAscByTaskTypeAndName(page,taskType,name,surname,patronymic);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

    public ResponseDto getAllCreateDateDescByTaskTypeAndName(String taskType, String name,String surname, String patronymic, int page) {
        Page<TaskHist> tasksPage = taskHistService.getAllTasksCreateDateDescByTaskTypeAndName(page,taskType,name,surname,patronymic);
        List<TaskHist> tasks = tasksPage.getContent();
        PaginationDto paginationDto = new PaginationDto(page, tasksPage.getTotalPages());
        return ResponseDto.successPageable(histEntityMapper.toTaskHistDTO(tasks), paginationDto);
    }

}
