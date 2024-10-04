package kz.setdata.warehousemanager.controller.handler;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.exception.InternalApplicationException;
import kz.setdata.warehousemanager.exception.JWTSecurityException;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class AdviceController {

    @ExceptionHandler(value = { JWTSecurityException.class})
    protected ResponseEntity<Object> handleJwtException(
            RuntimeException ex) {
        log.error("[handleJwtException] {}", ex.getMessage());
        return ResponseEntity.badRequest().body(ResponseDto.error(ex.getMessage()));
    }

    @ExceptionHandler(value = { CRUDOperationException.class})
    protected ResponseEntity<Object> handleCRUDException(
            RuntimeException ex) {
        log.error("[CRUD Operation Exception] ", ex);
        return ResponseEntity.badRequest().body(ResponseDto.error(ex.getMessage()));
    }

    @ExceptionHandler(value = { InternalApplicationException.class})
    protected ResponseEntity<Object> handleInternalApplicationException(
            RuntimeException ex) {
        log.error("[InternalApplicationException Operation Exception] ", ex);
        return ResponseEntity.badRequest().body(ResponseDto.error(ex.getMessage()));
    }
}
