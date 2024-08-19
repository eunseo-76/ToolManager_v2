package com.kenny.test_springboot.controller.calculator;

import com.kenny.test_springboot.dto.calculator.request.CalculatorAddRequest;
import com.kenny.test_springboot.dto.calculator.request.CalculatorMultiplyRequest;
import org.springframework.web.bind.annotation.*;

// 덧셈 API 만들기
@RestController // 이 클래스를 API의 진입 지점으로 만들어 준다
public class CalculatorController {

    @GetMapping("/add") // GET /add : HTTP path를 /add로 지정한다
    public int addTwoNumbers(CalculatorAddRequest request) {    // 주어지는 쿼리를 함수 파라미터에 넣는다
        return request.getNumber1() + request.getNumber2();
    }

    @PostMapping("/multiply")   // POST /multiply
    public int multiplyTwoNumbers(@RequestBody CalculatorMultiplyRequest request) { // @RequestBody : post API 에서 HTTP BODY안의 JSON을 이 객체로 변화시키기 위함
        return request.getNumber1() * request.getNumber2();

    }
}

// 하나의 Controller 클래스에 여러 API를 추가할 수 있다.
// @RequestBody : HTTP Body로 들어오는 JSON을 CalculatorMultiplyRequest로 바꾸어 준다.
