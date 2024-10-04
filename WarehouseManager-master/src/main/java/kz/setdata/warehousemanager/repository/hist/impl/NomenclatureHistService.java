package kz.setdata.warehousemanager.repository.hist.impl;

import kz.setdata.warehousemanager.model.hist.NomenclatureHist;
import kz.setdata.warehousemanager.repository.hist.NomenclatureHistRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NomenclatureHistService {
    private final NomenclatureHistRepository nomenclatureHistRepository;

    @Transactional
    public void save(List<NomenclatureHist> nomenclatureHists) {
        nomenclatureHistRepository.saveAll(nomenclatureHists);
    }
}
