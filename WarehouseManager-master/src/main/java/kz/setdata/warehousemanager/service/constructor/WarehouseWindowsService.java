package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.model.Windows;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.WindowsDTO;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.WarehouseCRUD;
import kz.setdata.warehousemanager.repository.impl.ConstructorService;
import kz.setdata.warehousemanager.repository.impl.WindowsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WarehouseWindowsService implements WarehouseCRUD {

    private final WindowsService windowsService;
    private final ConstructorService constructorService;

    @Override
    public ConstructorDTO getAll() {
        ConstructorDTO constructorDTO = new ConstructorDTO();
        List<WindowsDTO> windowsDTOS = EntityMapper.mapWindowsDTO(windowsService.getAll());
        constructorDTO.setWindows(windowsDTOS);
        return constructorDTO;
    }

    @Override
    public ConstructorDTO save(ConstructorDTO constructorDTO, long constructorId) {
        Constructor constructor = constructorService.getById(constructorId);
        List<Windows> windows = EntityMapper.mapWindows(constructorDTO.getWindows(),constructor);
        windows.removeIf(window -> windowsService.checkIfPossibleAddWindowByCoordinates(window, constructorId));
        windows = windowsService.saveWindows(windows);
        List<WindowsDTO> windowsDTOS = EntityMapper.mapWindowsDTO(windows);
        constructorDTO.setWindows(windowsDTOS);
        return constructorDTO;
    }

    @Override
    public boolean delete(List<Long> windowsIds) {
        List<Windows> windows = windowsService.getAll(windowsIds);
        windowsService.deleteWindows(windows);
        return true;
    }

    @Override
    public ConstructorDTO update(ConstructorDTO constructorDTO) {
        Constructor constructor = constructorService.getById(constructorDTO.getId());
        List<Windows> windows = EntityMapper.mapWindows(constructorDTO.getWindows(),constructor);
        windows = windowsService.updateWindows(windows);
        constructorDTO.setWindows(EntityMapper.mapWindowsDTO(windows));
        return constructorDTO;
    }
}
