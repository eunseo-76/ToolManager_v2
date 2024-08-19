package com.kenny.test_springboot.controller.testCommunication;

import com.kenny.test_springboot.dto.MyData;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class CommunicationController {

    @GetMapping("/greeting")
    public ResponseEntity<String> getGreeting() {
        return ResponseEntity.ok("Hello, World!");
    }

    @PostMapping("/data")
    public ResponseEntity<MyData> postData(@RequestBody MyData data) {
        return ResponseEntity.ok(data);
    }
}
