package kz.setdata.warehousemanager.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import kz.setdata.warehousemanager.model.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDetailsDTO {
    private long id;
    private String name;
    private String surname;
    private String patronymic;
    private String jobTitle;
    @JsonProperty("file_url")
    private String document;

    public UserDetailsDTO(User user, String document) {
        this.id = user.getId();
        this.name = user.getName();
        this.surname = user.getSurname();
        this.patronymic = user.getPatronymic();
        this.jobTitle = user.getJobTitle();
        this.document = document;
    }
}
