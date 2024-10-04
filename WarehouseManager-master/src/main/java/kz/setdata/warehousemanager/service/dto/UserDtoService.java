package kz.setdata.warehousemanager.service.dto;

import kz.setdata.warehousemanager.model.Account;
import kz.setdata.warehousemanager.model.User;
import kz.setdata.warehousemanager.model.dto.UserDto;
import kz.setdata.warehousemanager.repository.impl.AccountService;
import kz.setdata.warehousemanager.repository.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class UserDtoService {

    private UserService userService;

    @Autowired
    private void setUserService(UserService userService) {
        this.userService = userService;
    }

    private AccountService accountService;

    @Autowired
    public void setAccountService(AccountService accountService) {
        this.accountService = accountService;
    }

    public ArrayList<UserDto> getAll() {
        ArrayList<User> dbUsers = userService.getAll();
        ArrayList<UserDto> userDtos = new ArrayList<>();
        for (User dbUser : dbUsers) {
            Account account = accountService.getAccountByUserId(dbUser.getId());
            userDtos.add(new UserDto(dbUser,account.getUsername()));
        }
        return userDtos;
    }
}
