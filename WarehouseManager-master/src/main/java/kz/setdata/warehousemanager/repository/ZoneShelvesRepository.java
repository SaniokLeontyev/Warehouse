package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.ZoneShelves;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface ZoneShelvesRepository extends CrudRepository<ZoneShelves, Long> {
    List<ZoneShelves> findAllByZoneId(long zoneId);
    List<ZoneShelves> findAllByShelfId(long shelfId);
    @Transactional
    @Modifying
    @Query("DELETE FROM ZoneShelves zs WHERE zs.shelf.id IN (SELECT s.id FROM Shelf s WHERE s.constructor.id = :id)")
    void deleteZoneShelvesByConstructorId(Long id);
}
