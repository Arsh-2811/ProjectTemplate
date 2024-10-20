package base.app.repository;

import base.app.entity.Record;
import base.app.enums.Table;
import lombok.AllArgsConstructor;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

@Repository
@AllArgsConstructor
public class RecordRepoImpl implements RecordRepo {
    private final SessionFactory sessionFactory;

    @Override
    public String save(Record record) {
        Session session = sessionFactory.getCurrentSession();

        long number = ((Number)session.createNativeQuery("SELECT nextval('record_seq')").getSingleResult()).longValue();
        String recordNumber  = "RN" + number;
        record.setRecordNumber(recordNumber);

        session.save(record);
        return record.getRecordNumber();
    }

    @Override
    public Record findByRecordNumber(String recordNumber, Table table) {
        Session session = sessionFactory.getCurrentSession();

        Record record = null;
        try{
            record = (Record) session.createQuery("SELECT record FROM " + table + " record WHERE record.recordNumber = :recordNumber")
                    .setParameter("recordNumber", recordNumber)
                    .getSingleResult();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        return  record;
    }

    @Override
    public boolean delete(Record record) {
        Session session = sessionFactory.getCurrentSession();
        try{
            session.delete(record);
        } catch (Exception e){
            System.out.println(e);
            return false;
        }
        return true;
    }
}