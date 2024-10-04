package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.repository.ConstructorRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class ConstructorService {

    private final ConstructorRepository constructorRepository;

    public ConstructorService(ConstructorRepository constructorRepository) {
        this.constructorRepository = constructorRepository;
    }

    public List<Constructor> getAll(){
        return (List<Constructor>) constructorRepository.findAll();
    }

    @Transactional
    public Constructor save(Constructor constructor){
        return constructorRepository.save(constructor);
    }

    public Constructor getById(long id){
        return constructorRepository.findAllById(id);
    }

    @Transactional
    public void delete(long constructorId){
        constructorRepository.deleteById(constructorId);
    }

    @Transactional
    public void deleteConstructor(long constructorId){
        constructorRepository.deleteConstructor(constructorId);
    }
}
