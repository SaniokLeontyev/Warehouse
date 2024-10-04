package kz.setdata.warehousemanager.model;

import kz.setdata.warehousemanager.model.dto.LoginDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table
@Entity(name = "accounts")
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String username;
    private String password;

    private String document;


    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @Column(name = "role_id")
    private long roleId;

    public Account(LoginDTO loginDTO, User user, long roleId, String document){
        this.username = loginDTO.getUsername();
        this.password = loginDTO.getPassword();
        this.user = user;
        this.roleId = roleId;
        this.document = document;
    }

}
