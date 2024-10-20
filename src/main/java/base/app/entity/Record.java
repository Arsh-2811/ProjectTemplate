package base.app.entity;

import base.app.enums.Status;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.persistence.*;

@Entity
@Data
@SuperBuilder
@NoArgsConstructor

@Table(name = "records")
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Record {
    @Id @GeneratedValue(strategy = GenerationType.AUTO) protected Long id;
    protected String recordNumber;
    protected String dataField1;
    protected String dataField2;
    @Enumerated(EnumType.STRING) protected Status status;

    protected Record(String dataField1, String dataField2, Status status){
        this.dataField1 = dataField1;
        this.dataField2 = dataField2;
        this.status = status;
    }
}