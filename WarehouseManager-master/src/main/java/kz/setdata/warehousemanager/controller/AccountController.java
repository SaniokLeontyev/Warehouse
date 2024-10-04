package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.Account;
import kz.setdata.warehousemanager.model.dto.LoginDTO;
import kz.setdata.warehousemanager.model.dto.LoginResponseDTO;
import kz.setdata.warehousemanager.model.dto.UpdatePasswordDTO;
import kz.setdata.warehousemanager.model.dto.UserDto;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.repository.impl.AccountService;
import kz.setdata.warehousemanager.security.JwtUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;

@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/accounts")
@RestController
@Api(value = "Operations related to accounts", tags = {"Accounts"})
public class AccountController {

    private final JwtUtil jwtUtil;
    private final AuthenticationManager authenticationManager;
    private final AccountService accountService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDTO loginDTO) {
        try{
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginDTO.getUsername(), loginDTO.getPassword()));
            String username = authentication.getName();
            String token = jwtUtil.generateJwtToken(authentication);
            String role = new ArrayList<GrantedAuthority>(authentication.getAuthorities()).get(0).getAuthority();
            Account account = accountService.getAccountByLogin(username);
             new UserDto(account.getUser(),role);
            return ResponseEntity.ok(ResponseDto.success(
                    new LoginResponseDTO(
                            username,
                            token,
                            role,
                            new UserDto(account.getUser(),role),
                            account.getDocument()
                            )));
        }catch (BadCredentialsException | InternalAuthenticationServiceException exception){
            log.error("[LOGIN CONTROLLER] Exception: {}",exception.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ResponseDto.error("Invalid username or password"));
        }catch (Exception exception){
            log.error("[LOGIN CONTROLLER] Exception: {}",exception.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ResponseDto.error(exception.getMessage()));
        }
    }

    @PatchMapping("/password")
    public ResponseEntity<?> updatePassword(@Valid @RequestBody UpdatePasswordDTO updatePasswordDTO) {
        return ResponseEntity.ok(ResponseDto.success(accountService.updateAccountPassword(updatePasswordDTO)));
    }

}
