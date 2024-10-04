package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskFile;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface TaskFileRepository extends CrudRepository<TaskFile, Long> {
    List<TaskFile> findByTaskId(Long taskId);
    List<TaskFile> findAllByTaskIn(List<Task> tasks);

    @Transactional
    @Modifying
    @Query("DELETE from TaskFile tf where tf.task.id =:taskId")
    void deleteTaskFile(@Param("taskId") Long taskId);
}
