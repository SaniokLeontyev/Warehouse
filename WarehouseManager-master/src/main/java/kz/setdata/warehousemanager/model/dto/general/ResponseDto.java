package kz.setdata.warehousemanager.model.dto.general;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ResponseDto {
    private HttpStatus httpStatus;
    private String message;
    private Object body;
    @JsonProperty("pagination")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationDto paginationDto;

    public ResponseDto(HttpStatus httpStatus, String message, Object body){
        this.httpStatus = httpStatus;
        this.message = message;
        this.body = body;
    }

    public static ResponseDto success(Object body){
        return new ResponseDto(HttpStatus.OK,"Success", body);
    }

    public static ResponseDto successPageable(Object body, PaginationDto paginationDto){
        return new ResponseDto(HttpStatus.OK,"Success", body, paginationDto);
    }

    public static ResponseDto error(String message){
        return new ResponseDto(HttpStatus.BAD_REQUEST,message,null);
    }
}
