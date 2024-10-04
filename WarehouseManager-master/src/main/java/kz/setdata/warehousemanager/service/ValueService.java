package kz.setdata.warehousemanager.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Slf4j
@Getter
@Service
public class ValueService {

    @Value("${1c.list-nomenclatures}")
    private String rest1CGetNomenclaturesURL;

    @Value("${1c.list-warehouses}")
    private String rest1CGetWarehousesURL;

    @Value("${1c.list-measures}")
    private String rest1CGetMeasuresURL;

    @Value("${1c.list-documents}")
    private String rest1CGetDocumentsURL;

    @Value("${1c.get-nomenclature}")
    private String rest1CGetNomenclatureByUUID;

    @Value("${s3.upload}")
    private String s3UploadURL;

    @Value("${s3.delete}")
    private String s3DeleteURL;

    @Value("${app.pagination-number}")
    private int defaultPaginationNumber;

    public static LocalDateTime getTime(){
        return LocalDateTime.of(LocalDate.now(), LocalTime.now());
    }

    public static String toJSON(Object object) {
        try {
            return new ObjectMapper().writer().withDefaultPrettyPrinter().writeValueAsString(object);
        } catch (JsonProcessingException e) {
            log.info("[ERROR PARSING OBJECT]");
            return null;
        }
    }
}
