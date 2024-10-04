package kz.setdata.warehousemanager.service;

import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;

import java.util.List;

public interface WarehouseCRUD {
    ConstructorDTO getAll();
    ConstructorDTO save(ConstructorDTO constructorDTO,long constructorId);
    boolean delete(List<Long> ids);
    ConstructorDTO update(ConstructorDTO constructorDTO);
}
