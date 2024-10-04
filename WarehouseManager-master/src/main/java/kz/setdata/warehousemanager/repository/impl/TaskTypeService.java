package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.TaskType;
import kz.setdata.warehousemanager.repository.TaskTypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class TaskTypeService {

    private final TaskTypeRepository taskTypeRepository;

    public TaskType getByName(String name){
        return taskTypeRepository.findAllByName(name);
    }

    public List<TaskType> getAll(){
        return (List<TaskType>) taskTypeRepository.findAll();
    }
}