package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Doorways;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoorwaysRepository extends CrudRepository<Doorways,Long> {
    List<Doorways> findAllByConstructor_Id(long constructorId);
    boolean existsAllByConstructor_IdAndCoordinateXAndCoordinateY(long constructorId, String x, String y);
    List<Doorways> findAllByIdIn(List<Long> ids);
    void deleteAllByConstructor_Id(long constructorId);
}
