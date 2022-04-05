package com.lehmansoftware.TCNativeExample;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import com.lehmansoftware.tcnative.TcNativeExampleApplication;

@SpringBootTest(classes = TcNativeExampleApplication.class)
@ActiveProfiles("test")
class TcNativeExampleApplicationTests {

	@Test
	void contextLoads() {
	}

}
