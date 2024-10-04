package kz.setdata.warehousemanager.exception;

public class JWTSecurityException extends RuntimeException{
    public JWTSecurityException(String message){
        super(message);
    }
}
