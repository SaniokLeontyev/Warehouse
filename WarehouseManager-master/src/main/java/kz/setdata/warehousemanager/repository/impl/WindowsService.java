package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Doorways;
import kz.setdata.warehousemanager.model.Walls;
import kz.setdata.warehousemanager.model.Windows;
import kz.setdata.warehousemanager.repository.WindowsRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class WindowsService {

    private final WindowsRepository windowsRepository;

    public WindowsService(WindowsRepository windowsRepository) {
        this.windowsRepository = windowsRepository;
    }

    public List<Windows> getWarehouseWindows(long constructorId){
        return windowsRepository.findAllByConstructor_Id(constructorId);
    }

    @Transactional
    public List<Windows> saveWindows(List<Windows> windows){
        return (List<Windows>) windowsRepository.saveAll(windows);
    }

    public boolean checkIfPossibleAddWindowByCoordinates(Windows windows, long constructorId){
        return windowsRepository.existsAllByConstructor_IdAndCoordinateXAndCoordinateY(
                constructorId, windows.getCoordinateX(), windows.getCoordinateY());
    }

    public List<Windows> getAll(){
        return (List<Windows>) windowsRepository.findAll();
    }

    @Transactional
    public void deleteWindows(List<Windows> windows){
        windowsRepository.deleteAll(windows);
    }

    @Transactional
    public List<Windows> updateWindows(List<Windows> windows){
        windows.removeIf(wall -> !windowsRepository.existsById(wall.getId()));
        saveWindows(windows);
        return windows;
    }

    public List<Windows> getAll(List<Long> windowsIds){
        return windowsRepository.findAllByIdIn(windowsIds);
    }

    @Transactional
    public void delete(long constructorId){
        windowsRepository.deleteAllByConstructor_Id(constructorId);
    }
}
