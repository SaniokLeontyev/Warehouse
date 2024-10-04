package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.repository.impl.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/roles")
@RestController
@Api(value = "Operations related to user's roles", tags = {"Roles"})
public class RoleController {

    private RoleService roleService;

    @Autowired
    private void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    @GetMapping("/getAll")
    //@PreAuthorize("hasAuthority('ADMINISTRATOR')")
    public ResponseEntity<?> getAll(){
        return ResponseEntity.ok(roleService.getAll());
    }
}
