package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Controler {

    @GetMapping("/test")
    @ResponseBody
    public String mup() {
        return "Witaj w sekcji test!";
    }

    @GetMapping("/student")
    @ResponseBody
    public String student() {
        return "Witaj w sekcji studenta!";
    }

    @GetMapping("/")
    @ResponseBody
    public String hello() {
        return "Hello World";
    }
}
