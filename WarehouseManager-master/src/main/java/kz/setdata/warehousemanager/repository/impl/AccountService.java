package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Account;
import kz.setdata.warehousemanager.model.dto.UpdatePasswordDTO;
import kz.setdata.warehousemanager.repository.AccountRepository;
import kz.setdata.warehousemanager.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class AccountService{

    private PasswordEncoder passwordEncoder;

    @Autowired
    public void setPasswordEncoder(@Lazy PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    private S3Service s3Service;

    @Autowired
    private void setS3Service(S3Service s3Service) {
        this.s3Service = s3Service;
    }

    private AccountRepository accountRepository;

    @Autowired
    private void setAccountRepository(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    public Account getAccountByUserId(long userId){
        return accountRepository.findAllByUserId(userId);
    }

    public void deleteAccountByUserId(long userId){
        Account account = getAccountByUserId(userId);
        s3Service.deleteObject(account.getDocument());
        delete(account);
    }

    @Transactional
    public void delete(Account account){
        accountRepository.delete(account);
    }

    @Transactional
    public Account save(Account account){
        return accountRepository.save(account);
    }

    public Account getAccountByLogin(String login){
        return accountRepository.findAllByUsername(login);
    }

    public boolean checkIfAccountExists(Account account){
        Account acc = getAccountByLogin(account.getUsername());
        return acc != null;
    }

    public List<Account> getAdminAccounts(long roleId){
        return accountRepository.findAllByRoleId(roleId);
    }

    public long updateAccountPassword(UpdatePasswordDTO updatePasswordDTO){
        Account account = getAccountByLogin(updatePasswordDTO.getUsername());
        account.setPassword(passwordEncoder.encode(updatePasswordDTO.getPassword()));
        return accountRepository.save(account).getId();
    }
}
