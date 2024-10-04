package kz.setdata.warehousemanager.service.integration1C;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import kz.setdata.warehousemanager.model.dto.integration1C.NomenclatureDTO;
import kz.setdata.warehousemanager.service.ValueService;
import kz.setdata.warehousemanager.variable.Integration1CDocumentTypeEnum;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Objects;

@RequiredArgsConstructor
@Service
public class Integration1CService {

    private final ValueService valueService;

    private final RestTemplate restTemplate = new RestTemplate();

    private JsonNode toJsonNode(String jsonText){
        try {
            return new ObjectMapper().readTree(toUtf8(jsonText));
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    private String toUtf8(String json){
        byte[] bytes = json.getBytes(Charset.forName("ISO_8859_1"));
        return new String(bytes, StandardCharsets.UTF_8);
    }

    private String documentsURLBuilder(String dateFrom, String dateTo, Integration1CDocumentTypeEnum documentTypeEnum){
        return valueService.getRest1CGetDocumentsURL()
                + "DateB=" + dateFrom +
                "&DateE=" + dateTo +
                "&Type=" + documentTypeEnum.getValue();
    }

    public List<NomenclatureDTO> getNomenclatures(){
        ResponseEntity<String> response
                = restTemplate.getForEntity(valueService.getRest1CGetNomenclaturesURL(), String.class);
        List<NomenclatureDTO> nomenclatureDTO;
        try {
            nomenclatureDTO = new ObjectMapper().readValue(
                    toUtf8(Objects.requireNonNull(response.getBody())),
                    new TypeReference<>() {
            });
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return nomenclatureDTO;
    }

    public List<NomenclatureDTO> getNomenclatureByUUID(String uuid){
        String requestBody = null;
        HttpEntity<String> request =
                new HttpEntity<>(requestBody);
        String response
                = restTemplate.postForObject(valueService.getRest1CGetNomenclatureByUUID() + uuid,request, String.class);
        try {
            return new ObjectMapper().readValue(
                    toUtf8(Objects.requireNonNull(response)),
                    new TypeReference<>() {
                    });
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    public NomenclatureDTO getNomenclatureByName(List<NomenclatureDTO> nomenclatureDTO, String name){
        return nomenclatureDTO.stream()
                .filter(n -> name.equals(n.getName()))
                .findAny()
                .orElse(null);
    }

    public JsonNode getWarehouses(){
        ResponseEntity<String> response
                = restTemplate.getForEntity(valueService.getRest1CGetWarehousesURL(), String.class);
        return toJsonNode(response.getBody());
    }

    public JsonNode getMeasures(){
        ResponseEntity<String> response
                = restTemplate.getForEntity(valueService.getRest1CGetMeasuresURL(), String.class);
        return toJsonNode(response.getBody());
    }

    public JsonNode getBuyingDocuments(String dateFrom, String dateTo){
        String url = documentsURLBuilder(dateFrom,dateTo,Integration1CDocumentTypeEnum.BUYING);
        String response =
                restTemplate.postForObject(url, new HttpEntity<String>(new HttpHeaders()), String.class);
        return toJsonNode(response);
    }

    public JsonNode getSaleDocuments(String dateFrom, String dateTo){
        String url = documentsURLBuilder(dateFrom,dateTo,Integration1CDocumentTypeEnum.SALE);
        String response =
                restTemplate.postForObject(url, new HttpEntity<String>(new HttpHeaders()), String.class);
        return toJsonNode(response);
    }

    public JsonNode getMovingDocuments(String dateFrom, String dateTo){
        String url = documentsURLBuilder(dateFrom,dateTo,Integration1CDocumentTypeEnum.MOVING);
        String response =
                restTemplate.postForObject(url, new HttpEntity<String>(new HttpHeaders()), String.class);
        return toJsonNode(response);
    }

    public JsonNode getInventoryDocuments(String dateFrom, String dateTo){
        String url = documentsURLBuilder(dateFrom,dateTo,Integration1CDocumentTypeEnum.INVENTORY);
        String response =
                restTemplate.postForObject(url, new HttpEntity<String>(new HttpHeaders()), String.class);
        return toJsonNode(response);
    }

    public JsonNode getWritingOfDocuments(String dateFrom, String dateTo){
        String url = documentsURLBuilder(dateFrom,dateTo,Integration1CDocumentTypeEnum.WRITING_OFF);
        String response =
                restTemplate.postForObject(url, new HttpEntity<String>(new HttpHeaders()), String.class);
        return toJsonNode(response);
    }
}
