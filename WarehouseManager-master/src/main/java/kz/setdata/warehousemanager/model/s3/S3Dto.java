package kz.setdata.warehousemanager.model.s3;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class S3Dto {
    private String objectKey;
    private String category;
    private String base64;

    public S3Dto(String objectKey, String base64){
        this.base64 = base64;
        this.objectKey = objectKey;
    }
}
