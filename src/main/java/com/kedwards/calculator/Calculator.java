package com.kedwards.calculator;
import org.springframework.stereotype.Service;
import org.springframework.cache.annotation.Cacheable;

/**
 * Main Spring Application.
 */
@Service
public class Calculator {
     @Cacheable("sum")
     int sum(int a, int b) {
          return a + b;
     }
}