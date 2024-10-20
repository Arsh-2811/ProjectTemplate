package base.app.service;

import base.app.entity.PermanentRecord;
import base.app.entity.Record;
import base.app.entity.TemporaryRecord;
import base.app.enums.Status;
import base.app.enums.Table;
import base.app.repository.RecordRepo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
@AllArgsConstructor
public class RecordServiceImpl implements RecordService{
    private final RecordRepo recordRepo;

    @Override
    public boolean addRecord(Record record) {
        recordRepo.save(record);
        return true;
    }

    @Override
    public boolean ApproveRecord(String recordNumber) {
        try{
            TemporaryRecord temporaryRecord = (TemporaryRecord) recordRepo.findByRecordNumber(recordNumber, Table.TEMPORARY);

            PermanentRecord permanentRecord = PermanentRecord.builder()
                    .recordNumber(temporaryRecord.getRecordNumber())
                    .dataField1(temporaryRecord.getDataField1())
                    .dataField2(temporaryRecord.getDataField2())
                    .status(Status.APPROVED)
                    .build();

            recordRepo.delete(temporaryRecord);
            recordRepo.save(permanentRecord);
            return true;

        } catch (Exception e){
            System.out.println(e.getMessage());
            return false;
        }
    }

    @Override
    public boolean rejectRecord(String recordNumber) {
        return false;
    }

    @Override
    public boolean editRecord(String recordNumber, Record modifiedRecord) {
        return false;
    }

    @Override
    public boolean deleteRecord(String recordNumber) {
        return false;
    }
}