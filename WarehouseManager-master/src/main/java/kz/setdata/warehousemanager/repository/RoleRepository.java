package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Role;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends CrudRepository<Role,Long> {
    Role findAllById(long id);
    Role findAllByRole(String role);
}
