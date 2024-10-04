package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.ItemAttrShelf;
import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskNomenclature;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface TaskNomenclatureRepository extends CrudRepository<TaskNomenclature,Long> {
    List<TaskNomenclature> findAllByTaskId(long taskId);
    TaskNomenclature findAllByTaskIdAndItemAttrShelfId(long taskId,long taskAttributeId);
    List<TaskNomenclature> findAllByTaskIn(List<Task> tasks);
    List<TaskNomenclature> findAllByItemAttrShelfIn(List<ItemAttrShelf> itemAttributes);

    @Transactional
    @Modifying
    @Query("DELETE FROM TaskNomenclature tn WHERE tn.task.id IN (SELECT t.id FROM Task t WHERE t.constructor.id = :id)")
    void deleteTaskNomenclatureByConstructorId(Long id);
}
