package kz.setdata.warehousemanager.service;

import kz.setdata.warehousemanager.model.s3.S3Dto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class S3Service {

    private ValueService valueService;

    @Autowired
    private void setValueService(ValueService valueService) {
        this.valueService = valueService;
    }

    private final RestTemplate restTemplate = new RestTemplate();

    public String uploadObject(String key, String base64){
        S3Dto s3Dto = new S3Dto(key,base64);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<S3Dto> request =
                new HttpEntity<>(s3Dto, headers);
        return restTemplate.postForObject(valueService.getS3UploadURL(),
                        request, String.class);
    }

    public void deleteObject(String s3Url){
        String key = s3Url.substring(s3Url.lastIndexOf("/"));
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> request =
                new HttpEntity<>(key, headers);
        restTemplate.exchange(valueService.getS3DeleteURL(),
                        HttpMethod.DELETE,
                        request, String.class);
    }
}
