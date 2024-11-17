package util;

import java.io.IOException;
import java.util.Properties;

public class ConfigLoader {
    private static Properties properties = new Properties();

    static {
        try {
            // application.properties 로드
            properties.load(ConfigLoader.class.getClassLoader().getResourceAsStream("application.properties"));
            // secret.properties 로드
            properties.load(ConfigLoader.class.getClassLoader().getResourceAsStream("SECRET-KEY.properties"));

            // 변수 치환 처리
            for (String key : properties.stringPropertyNames()) {
                String value = properties.getProperty(key);
                properties.setProperty(key, resolvePlaceholders(value));
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 변수 치환 메서드
    private static String resolvePlaceholders(String value) {
        if (value == null || !value.contains("${")) {
            return value;
        }
        String result = value;
        for (String key : properties.stringPropertyNames()) {
            String placeholder = "${" + key + "}";
            if (result.contains(placeholder)) {
                result = result.replace(placeholder, properties.getProperty(key));
            }
        }
        return result;
    }

    public static String getDbUrl() {
        return properties.getProperty("db.url");
    }

    public static String getDbUsername() {
        return properties.getProperty("db.username");
    }

    public static String getDbPassword() {
        return properties.getProperty("db.password");
    }
}
