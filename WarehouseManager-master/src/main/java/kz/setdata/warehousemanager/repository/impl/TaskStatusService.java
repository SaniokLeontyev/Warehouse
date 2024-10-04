package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.TaskStatus;
import kz.setdata.warehousemanager.repository.TaskStatusRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class TaskStatusService {

    private final TaskStatusRepository taskStatusRepository;

    public TaskStatus getStatusById(long id){
        return taskStatusRepository.findAllById(id);
    }

    public TaskStatus getClosedStatus(){
        return taskStatusRepository.findAllByName("closed");
    }

    public List<TaskStatus> getAll(){
        return taskStatusRepository.findAll();
    }

}
