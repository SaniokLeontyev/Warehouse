package kz.setdata.warehousemanager.model.dto.form;

import kz.setdata.warehousemanager.model.dto.LoginDTO;
import kz.setdata.warehousemanager.model.dto.UserDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CreateUserDto {
    private LoginDTO account;
    private UserDto user;
    private int roleId;
    private String base64;
}
