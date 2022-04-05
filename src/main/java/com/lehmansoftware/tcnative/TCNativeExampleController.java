package com.lehmansoftware.tcnative;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class TCNativeExampleController {

	
	@GetMapping("/api/status-check") 
	public String getStatusCheck(){
		return "{\"status\":\"OK\"}";
	}
}
