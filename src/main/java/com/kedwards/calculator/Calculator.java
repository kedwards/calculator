/**
 * Main Spring Application.
 */
package com.kedwards.calculator;
import org.springframework.stereotype.Service;

@SpringBootApplication
@Service
public class Calculator {
    int sum(int a, int b) {
       return a + b;
    }
}
