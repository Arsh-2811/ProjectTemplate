package base.app.controller;

import base.app.entity.TemporaryRecord;
import base.app.enums.Status;
import base.app.service.RecordService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
public class HomeController {
    private final RecordService recordService;

    @RequestMapping("/")
    public String showHome(){
        TemporaryRecord temporaryRecord = new TemporaryRecord("data1", "data2", Status.NEW);

        recordService.addRecord(temporaryRecord);
        System.out.println(temporaryRecord.getRecordNumber());

        return "Home";
    }
}