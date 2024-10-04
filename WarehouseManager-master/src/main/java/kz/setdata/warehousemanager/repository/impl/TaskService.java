package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskType;
import kz.setdata.warehousemanager.model.User;
import kz.setdata.warehousemanager.repository.TaskRepository;
import kz.setdata.warehousemanager.service.ValueService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepository;

    private final ValueService valueService;
    private UserService userService;

    @Autowired
    private void setUserService(UserService userService) {
        this.userService = userService;
    }

    public Page<Task> getAllTasks(int page){
        return taskRepository.findAll(PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    @Transactional
    public Task save(Task task){
        return taskRepository.save(task);
    }

    public Task getById(long id){
        return taskRepository.findAllById(id);
    }

    @Transactional
    public void delete(Task task){
        taskRepository.delete(task);
    }

    @Transactional
    public void deleteAll(List<Task> tasks){
        taskRepository.deleteAll(tasks);
    }

    public List<Task> getAllByUserId(long userId){
        return taskRepository.findAllByUserId(userId);
    }

    public Page<Task> getAllByUserId(long userId, int page){
        //Sort sort = Sort.by("user_name").ascending();
        return taskRepository.findAllByUserId(
                userId,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByTaskType(TaskType taskType, int page){
        return taskRepository.findAllByTaskType(taskType,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getByDateBetweenAsc(LocalDateTime from, LocalDateTime to, int page){
        return taskRepository.findAllByCreateDateBetween(from,to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber(),
                        Sort.by("createDate").ascending()));
    }

    public Page<Task> getByDateBetweenDesc(LocalDateTime from, LocalDateTime to, int page){
        return taskRepository.findAllByCreateDateBetween(from,to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber(),
                        Sort.by("createDate").descending()));
    }

    public Page<Task> getByDateFromAsc(LocalDateTime from, int page){
        return taskRepository.findAllByCreateDateGreaterThanEqual(from,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber(),
                        Sort.by("createDate").ascending()));
    }

    public Page<Task> getByDateFromDesc(LocalDateTime from, int page){
        return taskRepository.findAllByCreateDateGreaterThanEqual(from,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber(),
                        Sort.by("createDate").descending()));
    }

    public Page<Task> getByDateBefore(LocalDateTime to, int page){
        return taskRepository.findAllByCreateDateLessThanEqual(to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber(),
                        Sort.by("createDate").descending()));
    }

    public Page<Task> getAllTasksCreateDateAsc(int page){
        return taskRepository.findAllOrderByAsk(PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllTasksCreateDateAscByLogin(int page, String login){
        User creator = userService.getUserByLogin(login);
        return taskRepository.findAllOrderByAndLoginAsk(creator,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllTasksCreateDateDescByLogin(int page, String login){
        User creator = userService.getUserByLogin(login);
        return taskRepository.findAllOrderByAndLoginDesc(creator,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllTasksCreateDateAscByTaskType(int page, String taskType){
        return taskRepository.findAllOrderByAndTaskTypeAsk(taskType,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllTasksCreateDateDescByTaskType(int page, String taskType){
        return taskRepository.findAllOrderByAndTaskTypeDesc(taskType,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllTasksCreateDateAscByTaskTypeAndLogin(int page, String taskType, String login){
        User creator = userService.getUserByLogin(login);
        return taskRepository.findAllOrderByAndTaskTypeAndLoginAsk(taskType,creator,PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllTasksCreateDateDescByTaskTypeAndLogin(int page, String taskType, String login){
        User creator = userService.getUserByLogin(login);
        return taskRepository.findAllOrderByAndTaskTypeAndLoginDesc(taskType,creator, PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> findAllOrderByDesc(int page){
        return taskRepository.findAllOrderByDesc(PageRequest.of(
                page,
                valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByUserAndTaskType(User user, TaskType taskType, int page){
        //Sort sort = Sort.by("user_name").ascending();
        return taskRepository.findAllByUserAndTaskType(
                user,
                taskType,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByUserAndTaskTypeBetweenDates(User user, TaskType taskType, LocalDateTime from, LocalDateTime to, int page){
        return taskRepository.findAllByUserAndTaskTypeAndCreateDateBetween(
                user,
                taskType,
                from,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByUserAndTaskTypeFromDate(User user, TaskType taskType, LocalDateTime from, int page){
        return taskRepository.findAllByUserAndTaskTypeAndCreateDateGreaterThanEqual(
                user,
                taskType,
                from,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByUserAndTaskTypeBeforeDate(User user, TaskType taskType, LocalDateTime to, int page){
        return taskRepository.findAllByUserAndTaskTypeAndCreateDateLessThanEqual(
                user,
                taskType,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByTaskTypeBeforeDate(TaskType taskType, LocalDateTime to, int page){
        return taskRepository.findAllByTaskTypeAndCreateDateLessThanEqual(
                taskType,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByTaskTypeAfterDate(TaskType taskType, LocalDateTime to, int page){
        return taskRepository.findAllByTaskTypeAndCreateDateGreaterThanEqual(
                taskType,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByTaskTypeBetweenDate(TaskType taskType, LocalDateTime from, LocalDateTime to, int page){
        return taskRepository.findAllByTaskTypeAndCreateDateBetween(
                taskType,
                from,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByLoginTypeBetweenDate(User user, LocalDateTime from, LocalDateTime to, int page){
        return taskRepository.findAllByUserAndCreateDateBetween(
                user,
                from,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByLoginTypeGreaterDate(User user, LocalDateTime from, int page){
        return taskRepository.findAllByUserAndCreateDateGreaterThanEqual(
                user,
                from,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    public Page<Task> getAllByLoginTypeLessDate(User user, LocalDateTime to, int page){
        return taskRepository.findAllByUserAndCreateDateLessThanEqual(
                user,
                to,
                PageRequest.of(
                        page,
                        valueService.getDefaultPaginationNumber()));
    }

    @Transactional
    public void delete(long constructorId){
        taskRepository.deleteAllByConstructor_Id(constructorId);
    }
}
