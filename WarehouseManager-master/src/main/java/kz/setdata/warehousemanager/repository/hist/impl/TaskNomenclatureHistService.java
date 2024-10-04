package kz.setdata.warehousemanager.repository.hist.impl;

import kz.setdata.warehousemanager.model.hist.TaskNomenclatureHist;
import kz.setdata.warehousemanager.repository.hist.TaskNomenclatureHistRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskNomenclatureHistService {
    private final TaskNomenclatureHistRepository taskNomenclatureHistRepository;

    @Transactional
    public void save(List<TaskNomenclatureHist> taskNomenclatureHist) {
        taskNomenclatureHistRepository.saveAll(taskNomenclatureHist);
    }

    public List<TaskNomenclatureHist> getByTaskId(Long taskId) {
        return taskNomenclatureHistRepository.findByTaskId(taskId);
    }

    public List<TaskNomenclatureHist> findAll(){
        return (List<TaskNomenclatureHist>) taskNomenclatureHistRepository.findAll();
    }
}
