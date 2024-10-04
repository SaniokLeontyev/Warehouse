package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Windows;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WindowsRepository extends CrudRepository<Windows,Long> {
    List<Windows> findAllByConstructor_Id(long constructorId);
    boolean existsAllByConstructor_IdAndCoordinateXAndCoordinateY(long constructorId, String x, String y);
    List<Windows> findAllByIdIn(List<Long> windowsIds);
    void deleteAllByConstructor_Id(long constructorId);
}
