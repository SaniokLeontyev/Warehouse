package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskType;
import kz.setdata.warehousemanager.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TaskRepository extends PagingAndSortingRepository<Task,Long> {
    Page<Task> findAll(Pageable pageable);

    @Query("SELECT t from Task t order by t.createDate asc ")
    Page<Task> findAllOrderByAsk(Pageable pageable);

    @Query("SELECT t from Task t order by t.createDate desc ")
    Page<Task> findAllOrderByDesc(Pageable pageable);

    @Query("SELECT t from Task t where t.creator = :user  order by t.createDate asc ")
    Page<Task> findAllOrderByAndLoginAsk(User user, Pageable pageable);

    @Query("SELECT t from Task t where t.creator = :user  order by t.createDate desc ")
    Page<Task> findAllOrderByAndLoginDesc(User user, Pageable pageable);

    @Query("SELECT t from Task t where t.taskType.name = :taskType  order by t.createDate asc ")
    Page<Task> findAllOrderByAndTaskTypeAsk(String taskType, Pageable pageable);

    @Query("SELECT t from Task t where t.taskType.name = :taskType  order by t.createDate desc ")
    Page<Task> findAllOrderByAndTaskTypeDesc(String taskType, Pageable pageable);

    @Query("SELECT t from Task t where t.taskType.name = :taskType and t.creator = :user order by t.createDate asc ")
    Page<Task> findAllOrderByAndTaskTypeAndLoginAsk(String taskType, User user, Pageable pageable);

    @Query("SELECT t from Task t where t.taskType.name = :taskType and t.creator = :user order by t.createDate desc ")
    Page<Task> findAllOrderByAndTaskTypeAndLoginDesc(String taskType, User user, Pageable pageable);

    Page<Task> findAllByUserId(long userId, Pageable pageable);
    List<Task> findAllByUserId(long userId);
    Page<Task> findAllByUserAndTaskType(User user, TaskType taskType, Pageable pageable);
    Page<Task> findAllByUserAndTaskTypeAndCreateDateBetween(User user, TaskType taskType,
                                                            LocalDateTime from, LocalDateTime to,
                                                            Pageable pageable);

    Page<Task> findAllByUserAndTaskTypeAndCreateDateGreaterThanEqual(User user, TaskType taskType,
                                                            LocalDateTime from,
                                                            Pageable pageable);

    Page<Task> findAllByUserAndTaskTypeAndCreateDateLessThanEqual(User user, TaskType taskType,
                                                            LocalDateTime to,
                                                            Pageable pageable);

    Page<Task> findAllByTaskTypeAndCreateDateLessThanEqual(TaskType taskType,
                                                            LocalDateTime to,
                                                            Pageable pageable);

    Page<Task> findAllByTaskTypeAndCreateDateGreaterThanEqual(TaskType taskType,
                                                            LocalDateTime from,
                                                            Pageable pageable);

    Page<Task> findAllByTaskTypeAndCreateDateBetween(TaskType taskType,
                                                            LocalDateTime from,
                                                            LocalDateTime to,
                                                            Pageable pageable);

    Page<Task> findAllByUserAndCreateDateBetween(User user,
                                                            LocalDateTime from,
                                                            LocalDateTime to,
                                                            Pageable pageable);

    Page<Task> findAllByUserAndCreateDateGreaterThanEqual(User user,
                                                            LocalDateTime from,
                                                            Pageable pageable);

    Page<Task> findAllByUserAndCreateDateLessThanEqual(User user,
                                                            LocalDateTime to,
                                                            Pageable pageable);
    Page<Task> findAllByTaskType(TaskType taskType, Pageable pageable);
    Task findAllById(long id);
    Page<Task> findAllByCreateDateBetween(LocalDateTime from, LocalDateTime to, Pageable pageable);
    Page<Task> findAllByCreateDateGreaterThanEqual(LocalDateTime from, Pageable pageable);
    Page<Task> findAllByCreateDateLessThanEqual(LocalDateTime to, Pageable pageable);
    //Page<Task> findAllByTaskStatusId(long taskStatusId, Pageable pageable);

    void deleteAllByConstructor_Id(long constructorId);
}
