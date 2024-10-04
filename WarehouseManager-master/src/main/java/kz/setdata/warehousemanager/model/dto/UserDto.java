package kz.setdata.warehousemanager.model.dto;

import kz.setdata.warehousemanager.model.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    private long id;
    private String name;
    private String surname;
    private String patronymic;
    private String jobTitle;

    private String login;

    public UserDto(User user, String login){
        this.id = user.getId();
        this.name = user.getName();
        this.surname = user.getSurname();
        this.patronymic = user.getPatronymic();
        this.jobTitle = user.getJobTitle();
        this.login = login;
    }

    public String getFIO(){
        return this.surname + " " + this.name + " " + this.patronymic;
    }
}
