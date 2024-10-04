package kz.setdata.warehousemanager.exception;

public class CRUDOperationException extends RuntimeException{
    public CRUDOperationException(String message){
        super(message);
    }
}
