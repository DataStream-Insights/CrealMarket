package util;

public class TestConfigLoader {
    public static void main(String[] args) {
        System.out.println("DB URL: " + ConfigLoader.getDbUrl());
        System.out.println("DB Username: " + ConfigLoader.getDbUsername());
        System.out.println("DB Password: " + ConfigLoader.getDbPassword());
    }
}
