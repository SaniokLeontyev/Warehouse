package kz.setdata.warehousemanager.repository.hist;

import kz.setdata.warehousemanager.model.hist.NomenclatureHist;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NomenclatureHistRepository extends CrudRepository<NomenclatureHist,Long> {

}
