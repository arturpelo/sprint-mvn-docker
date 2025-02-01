package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Controler {

    @GetMapping("/MUP")
    @ResponseBody
    public String mup() {
        return "Witaj w sekcji MUP!";
    }

    @GetMapping("/Student")
    @ResponseBody
    public String student() {
        return "Witaj w sekcji Studenta!";
    }

    @GetMapping("/")
    @ResponseBody
    public String hello() {
        return "Hello World";
    }
}
