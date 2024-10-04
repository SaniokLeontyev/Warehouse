package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.TaskStatus;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskStatusRepository extends CrudRepository<TaskStatus, Long> {
    List<TaskStatus> findAll();
    TaskStatus findAllByName(String name);
    TaskStatus findAllById(long id);
}
