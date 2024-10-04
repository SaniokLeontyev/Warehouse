package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Zone;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ZoneRepository extends CrudRepository<Zone,Long> {
    List<Zone> findAllByConstructor_Id(long constructorId);
    boolean existsAllByConstructor_IdAndCoordinateXAndCoordinateY(long constructorId, String x, String y);
    Zone findAllById(long id);
    Zone findAllByName(String name);
    List<Zone> findAllByIdIn(List<Long> zoneIds);
    void deleteAllByConstructor_Id(long constructorId);
}
