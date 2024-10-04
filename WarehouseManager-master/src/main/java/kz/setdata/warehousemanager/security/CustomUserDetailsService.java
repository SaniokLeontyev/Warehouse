package kz.setdata.warehousemanager.security;

import kz.setdata.warehousemanager.model.Account;
import kz.setdata.warehousemanager.model.Role;
import kz.setdata.warehousemanager.repository.impl.AccountService;
import kz.setdata.warehousemanager.repository.impl.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private AccountService accountService;

    @Autowired
    private void setAccountService(AccountService accountService) {
        this.accountService = accountService;
    }

    private RoleService roleService;

    @Autowired
    private void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        Account account = accountService.getAccountByLogin(login);
        List<Role> roles = new ArrayList<>();
        roles.add(roleService.getRoleById(account.getRoleId()));
        return UserDetailsImpl.build(account,roles);
    }

}
