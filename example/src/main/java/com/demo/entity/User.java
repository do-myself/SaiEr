package com.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int id;
    private String userCode;
    private String password;
    private String userName;
    private String phoneNum;
    private int age;
    private String sex;
}
