package kz.setdata.warehousemanager.repository.hist;

import kz.setdata.warehousemanager.model.hist.TaskFileHist;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskFileHistRepository extends CrudRepository<TaskFileHist, Long> {
    List<TaskFileHist> findByTaskId(Long taskId);
}
