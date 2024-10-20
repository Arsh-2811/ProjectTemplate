package base.app.service;

import base.app.entity.Record;

public interface RecordService {
    boolean addRecord(Record record);

    boolean ApproveRecord(String recordNumber);

    boolean rejectRecord(String recordNumber);

    boolean editRecord(String recordNumber, Record modifiedRecord);

    boolean deleteRecord(String recordNumber);
}