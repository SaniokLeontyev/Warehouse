package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.model.Account;
import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.User;
import kz.setdata.warehousemanager.model.dto.UserDetailsDTO;
import kz.setdata.warehousemanager.model.dto.form.CreateUserDto;
import kz.setdata.warehousemanager.model.dto.UserDto;
import kz.setdata.warehousemanager.repository.UserRepository;
import kz.setdata.warehousemanager.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    private S3Service s3Service;

    @Autowired
    private void setS3Service(S3Service s3Service) {
        this.s3Service = s3Service;
    }

    private UserRepository userRepository;

    @Autowired
    private void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    private AccountService accountService;

    @Autowired
    private void setAccountService(AccountService accountService) {
        this.accountService = accountService;
    }

    private TaskService taskService;

    @Autowired
    private void setTaskService(TaskService taskService) {
        this.taskService = taskService;
    }

    private TaskNomenclatureService taskNomenclatureService;

    @Autowired
    private void setTaskNomenclatureService(TaskNomenclatureService taskNomenclatureService) {
        this.taskNomenclatureService = taskNomenclatureService;
    }

    @Autowired
    public PasswordEncoder passwordEncoder;

    public ArrayList<User> getAll(){
        return (ArrayList<User>) userRepository.findAll();
    }

    public void delete(long id){
        List<Task> tasks = taskService.getAllByUserId(id);
        taskNomenclatureService.deleteByTasks(tasks);
        taskService.deleteAll(tasks);
        accountService.deleteAccountByUserId(id);
    }

    @Transactional
    public void delete(User user){
        userRepository.delete(user);
    }

    @Transactional
    public User save(User user){
        return userRepository.save(user);
    }

    public boolean checkIfUserExists(User user){
        return userRepository.existsUserByNameAndSurnameAndPatronymic(user.getName(), user.getSurname(), user.getPatronymic());
    }

    public User toUser(UserDto userDto){
        User user = new User();
        user.setName(userDto.getName());
        user.setSurname(userDto.getSurname());
        user.setPatronymic(userDto.getPatronymic());
        user.setJobTitle(userDto.getJobTitle());
        return user;
    }

    public long createUser(CreateUserDto createUserDto){
        User user = toUser(createUserDto.getUser());
        //user = save(user);
        String s3Url = s3Service.uploadObject(createUserDto.getAccount().getUsername(),createUserDto.getBase64());
        Account account = new Account(createUserDto.getAccount(),user,createUserDto.getRoleId(),s3Url);
        account.setPassword(passwordEncoder.encode(account.getPassword()));
        if (accountService.checkIfAccountExists(account)){
            throw new CRUDOperationException("Account already exists");
        }
        if (checkIfUserExists(account.getUser())){
            throw new CRUDOperationException("User already exists");
        }
        account = accountService.save(account);
        return account.getId();
    }

    public long update(CreateUserDto createUserDto){
        Account account = accountService.getAccountByLogin(createUserDto.getAccount().getUsername());
        User user = account.getUser();
        user.setSurname(createUserDto.getUser().getSurname());
        user.setName(createUserDto.getUser().getName());
        user.setPatronymic(createUserDto.getUser().getPatronymic());
        user.setJobTitle(createUserDto.getUser().getJobTitle());
        if (!createUserDto.getAccount().getPassword().isBlank() &&
                !createUserDto.getAccount().getPassword().equals(account.getPassword())){
            account.setPassword(passwordEncoder.encode(createUserDto.getAccount().getPassword()));
        }
        account = accountService.save(account);
        return account.getId();
    }

    public UserDetailsDTO getUserDetailsById(long id){
        return userRepository.findUserDetailsById(id);
    }

    public User getById(long id){
        return userRepository.findAllById(id);
    }

    public User getUserByLogin(String login){
        return userRepository.findUserByLogin(login);
    }
}
