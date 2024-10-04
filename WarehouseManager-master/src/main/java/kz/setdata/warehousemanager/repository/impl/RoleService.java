package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Role;
import kz.setdata.warehousemanager.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class RoleService {

    private RoleRepository roleRepository;

    @Autowired
    private void setRoleRepository(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public Role getRoleById(long id){
        return roleRepository.findAllById(id);
    }

    public Role getRoleByName(String name){
        return roleRepository.findAllByRole(name);
    }

    public ArrayList<Role> getAll(){
        return (ArrayList<Role>) roleRepository.findAll();
    }
}
