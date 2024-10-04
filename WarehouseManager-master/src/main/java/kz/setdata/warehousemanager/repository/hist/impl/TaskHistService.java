package kz.setdata.warehousemanager.repository.hist.impl;

import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.User;
import kz.setdata.warehousemanager.model.hist.TaskHist;
import kz.setdata.warehousemanager.repository.hist.TaskHistRepository;
import kz.setdata.warehousemanager.service.ValueService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskHistService {
    private final TaskHistRepository taskHistRepository;

    private ValueService valueService;

    @Autowired
    private void setValueService(ValueService valueService) {
        this.valueService = valueService;
    }

    @Transactional
    public TaskHist save(TaskHist task) {
        return taskHistRepository.save(task);
    }

    public TaskHist findById(Long id) {
        return taskHistRepository.findById(id).orElse(null);
    }

    public List<TaskHist> findAll() {
        return (List<TaskHist>) taskHistRepository.findAll();
    }

    public Page<TaskHist> getAllTasks(int page){
        return taskHistRepository.findAll(PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAsc(int page){
        return taskHistRepository.findAllOrderByAsk(PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDesc(int page){
        return taskHistRepository.findAllOrderByDesc(PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByName(int page, String name){
        return taskHistRepository.findAllOrderByAndNameAsk(name,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByName(int page, String name){
        return taskHistRepository.findAllOrderByAndNameDesc(name,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscBySurname(int page, String surname){
        return taskHistRepository.findAllOrderByAndSurnameAsk(surname,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescBySurname(int page, String surname){
        return taskHistRepository.findAllOrderByAndSurnameDesc(surname,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByName(int page, String name,String surname){
        return taskHistRepository.findAllOrderByAndNameAsk(name,surname,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByName(int page, String name, String surname){
        return taskHistRepository.findAllOrderByAndNameDesc(name,surname,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByName(int page, String name,String surname, String patronymic){
        return taskHistRepository.findAllOrderByAndNameAsk(name,surname,patronymic,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByName(int page, String name,String surname, String patronymic){
        return taskHistRepository.findAllOrderByAndNameDesc(name,surname,patronymic,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }


    public Page<TaskHist> getAllTasksCreateDateAscByTaskType(int page, String taskType){
        return taskHistRepository.findAllOrderByAndTaskTypeAsk(taskType,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByTaskType(int page, String taskType){
        return taskHistRepository.findAllOrderByAndTaskTypeDesc(taskType,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByTaskTypeAndName(int page, String taskType, String name){
        return taskHistRepository.findAllOrderByAndTaskTypeAndNameAsk(taskType,name,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByTaskTypeAndName(int page, String taskType, String name){
        return taskHistRepository.findAllOrderByAndTaskTypeAndNameDesc(taskType,name, PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByTaskTypeAndSurname(int page, String taskType, String surname){
        return taskHistRepository.findAllOrderByAndTaskTypeAndSurnameAsk(taskType,surname,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByTaskTypeAndSurname(int page, String taskType, String surname){
        return taskHistRepository.findAllOrderByAndTaskTypeAndSurnameDesc(taskType,surname, PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByTaskTypeAndName(int page, String taskType, String name, String surname){
        return taskHistRepository.findAllOrderByAndTaskTypeAndNameAsk(taskType,name,surname,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByTaskTypeAndName(int page, String taskType, String name, String surname){
        return taskHistRepository.findAllOrderByAndTaskTypeAndNameDesc(taskType,name,surname, PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateAscByTaskTypeAndName(int page, String taskType, String name, String surname, String patronymic){
        return taskHistRepository.findAllOrderByAndTaskTypeAndNameAsk(taskType,name,surname,patronymic,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<TaskHist> getAllTasksCreateDateDescByTaskTypeAndName(int page, String taskType, String name, String surname, String patronymic){
        return taskHistRepository.findAllOrderByAndTaskTypeAndNameDesc(taskType,name,surname,patronymic, PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }
}
