package kz.setdata.warehousemanager.repository.hist;

import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.User;
import kz.setdata.warehousemanager.model.hist.TaskHist;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskHistRepository extends CrudRepository<TaskHist,Long> {
    Page<TaskHist> findAll(Pageable pageable);

    @Query("SELECT t from TaskHist t order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAsk(Pageable pageable);

    @Query("SELECT t from TaskHist t order by t.createDate desc ")
    Page<TaskHist> findAllOrderByDesc(Pageable pageable);

    @Query("SELECT t from TaskHist t where t.managerName = :managerName order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndNameAsk(String managerName, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.managerName = :managerName and t.managerSurname =:managerSurname  order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndNameDesc(String managerName,Pageable pageable);

    @Query("SELECT t from TaskHist t where t.managerSurname = :managerSurname order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndSurnameAsk(String managerSurname, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.managerSurname = :managerSurname and t.managerSurname =:managerSurname  order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndSurnameDesc(String managerSurname,Pageable pageable);


    @Query("SELECT t from TaskHist t where t.managerName = :managerName and t.managerSurname =:managerSurname order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndNameAsk(String managerName, String managerSurname, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.managerName = :managerName and t.managerSurname =:managerSurname  order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndNameDesc(String managerName, String managerSurname, Pageable pageable);

    @Query("SELECT t from TaskHist t" +
            " where t.managerName = :managerName and t.managerSurname =:managerSurname and t.managerPatronymic = :patronymic " +
            "order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndNameAsk(String managerName, String managerSurname, String patronymic, Pageable pageable);

    @Query("SELECT t from TaskHist t" +
            " where t.managerName = :managerName and t.managerSurname =:managerSurname and t.managerPatronymic = :patronymic " +
            " order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndNameDesc(String managerName, String managerSurname, String patronymic, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.taskType = :taskType  order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAsk(String taskType, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.taskType = :taskType  order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndTaskTypeDesc(String taskType, Pageable pageable);



    @Query("SELECT t from TaskHist t where t.taskType = :taskType and t.managerName = :name order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndNameAsk(String taskType, String name, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.taskType = :taskType and t.managerName = :name order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndNameDesc(String taskType, String name, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.taskType = :taskType and t.managerSurname = :surname order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndSurnameAsk(String taskType, String surname, Pageable pageable);

    @Query("SELECT t from TaskHist t where t.taskType = :taskType and t.managerSurname = :surname order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndSurnameDesc(String taskType, String surname, Pageable pageable);

    @Query("SELECT t from TaskHist t where" +
            " t.taskType = :taskType and t.managerName = :name and t.managerSurname = :surname" +
            " order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndNameAsk(String taskType, String name, String surname, Pageable pageable);

    @Query("SELECT t from TaskHist t where " +
            "t.taskType = :taskType and t.managerName = :name and t.managerSurname = :surname" +
            " order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndNameDesc(String taskType, String name, String surname, Pageable pageable);

    @Query("SELECT t from TaskHist t where" +
            " t.taskType = :taskType and t.managerName = :name and t.managerSurname = :surname and t.managerPatronymic = :patronymic" +
            " order by t.createDate asc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndNameAsk(String taskType, String name, String surname, String patronymic, Pageable pageable);

    @Query("SELECT t from TaskHist t where " +
            "t.taskType = :taskType and t.managerName = :name and t.managerSurname = :surname and t.managerPatronymic = :patronymic" +
            " order by t.createDate desc ")
    Page<TaskHist> findAllOrderByAndTaskTypeAndNameDesc(String taskType, String name, String surname,String patronymic, Pageable pageable);


}
