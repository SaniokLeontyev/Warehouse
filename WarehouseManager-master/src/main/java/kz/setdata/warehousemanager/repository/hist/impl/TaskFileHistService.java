package kz.setdata.warehousemanager.repository.hist.impl;

import kz.setdata.warehousemanager.model.hist.TaskFileHist;
import kz.setdata.warehousemanager.repository.hist.TaskFileHistRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskFileHistService {
    private final TaskFileHistRepository taskFileHistRepository;

    @Transactional
    public void save(List<TaskFileHist> taskFileHist) {
        taskFileHistRepository.saveAll(taskFileHist);
    }

    public List<TaskFileHist> getTaskFileHistByTaskId(Long taskId) {
        return taskFileHistRepository.findByTaskId(taskId);
    }
}
