package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.UserDetailsDTO;
import kz.setdata.warehousemanager.model.dto.form.CreateUserDto;
import kz.setdata.warehousemanager.service.dto.UserDtoService;
import kz.setdata.warehousemanager.repository.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/users")
@Controller
@Api(value = "Operations related to users", tags = {"Users"})
public class UserController {

    private UserDtoService userDtoService;

    @Autowired
    private void setUserDtoService(UserDtoService userDtoService) {
        this.userDtoService = userDtoService;
    }

    private UserService userService;

    @Autowired
    private void setUserService(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/getAll")
    public ResponseEntity<?> getAllUsers(){
        return ResponseEntity.ok(userDtoService.getAll());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUserById(@PathVariable long id){
        userService.delete(id);
        return ResponseEntity.ok("ok");
    }

    @PostMapping(path = "/create")
    @PreAuthorize("hasAuthority('ADMINISTRATOR')")
    public ResponseEntity<?> create(@RequestBody CreateUserDto createUserDto){
        return ResponseEntity.ok(userService.createUser(createUserDto));
    }

    @PatchMapping
    public ResponseEntity<?> update(@RequestBody CreateUserDto createUserDto){
        return ResponseEntity.ok(userService.update(createUserDto));
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDetailsDTO> getById(@PathVariable long id){
        return ResponseEntity.ok(userService.getUserDetailsById(id));
    }
}
