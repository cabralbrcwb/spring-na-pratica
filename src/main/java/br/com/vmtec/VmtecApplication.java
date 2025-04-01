package br.com.vmtec;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan("br.com.vmtec.model")
@EnableJpaRepositories("br.com.vmtec.repository")
public class VmtecApplication{
	public static void main(String[] args) {
		SpringApplication.run(VmtecApplication.class, args);
	}

}
