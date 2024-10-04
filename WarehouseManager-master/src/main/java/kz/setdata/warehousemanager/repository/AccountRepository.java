package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Account;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AccountRepository  extends CrudRepository<Account, Long> {
    Account findAllByUsernameAndPassword(String username, String password);
    Account findAllByUsername(String username);
    Account findAllByUserId(long userId);
    List<Account> findAllByRoleId(long roleId);
}
