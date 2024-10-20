package base.app.entity;

import base.app.enums.Status;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.persistence.Entity;

@Entity
@Data
@SuperBuilder
@NoArgsConstructor
public class PermanentRecord extends Record{
    public PermanentRecord(String dataField1, String dataField2, Status status){
        super(dataField1, dataField2, status);
    }

    @Override
    public String toString() {
        return "PermanentRecord{" +
                "id=" + id +
                ", recordNumber='" + recordNumber + '\'' +
                ", dataField1='" + dataField1 + '\'' +
                ", dataField2='" + dataField2 + '\'' +
                ", status=" + status +
                '}';
    }
}
