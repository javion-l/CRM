package cn.myfourm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@MapperScan("cn.myfourm.mapper")
@SpringBootApplication
public class FourmApplication {

    public static void main(String[] args) {
        SpringApplication.run(FourmApplication.class,args);
    }
}
