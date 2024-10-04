package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.TaskType;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskTypeRepository extends CrudRepository<TaskType,Long> {

    TaskType findAllByName(String name);
}
