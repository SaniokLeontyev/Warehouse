package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.User;
import kz.setdata.warehousemanager.model.dto.UserDetailsDTO;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User,Long> {
    User findAllById(long id);
    boolean existsUserByNameAndSurnameAndPatronymic(String name, String surname, String patronymic);

    @Query("SELECT new kz.setdata.warehousemanager.model.dto.UserDetailsDTO(u,a.document) FROM users u left join accounts a on u.id = a.user.id where u.id = :id")
    UserDetailsDTO findUserDetailsById(@Param("id") Long id);

    @Query("SELECT u from users u left join accounts a on u.id = a.user.id where a.username = :login")
    User findUserByLogin(String login);
}
