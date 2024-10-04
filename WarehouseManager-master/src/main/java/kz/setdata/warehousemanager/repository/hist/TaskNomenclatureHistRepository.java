package kz.setdata.warehousemanager.repository.hist;

import kz.setdata.warehousemanager.model.hist.TaskNomenclatureHist;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskNomenclatureHistRepository extends CrudRepository<TaskNomenclatureHist, Long> {
    List<TaskNomenclatureHist> findByTaskId(Long taskId);
}
