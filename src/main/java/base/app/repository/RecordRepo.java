package base.app.repository;

import base.app.entity.Record;
import base.app.enums.Table;

public interface RecordRepo {
    String save(Record record);
    Record findByRecordNumber(String recordNumber, Table table);
    boolean delete(Record record);
}