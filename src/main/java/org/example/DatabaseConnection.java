package org.example;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {
    public static Connection getConnection() throws Exception {
        Properties props = new Properties();
        InputStream input = DatabaseConnection.class.getClassLoader().getResourceAsStream("application.properties");
        props.load(input);
        String DB_URL = props.getProperty("db.url");
        String DB_USER = props.getProperty("db.username");
        String DB_PASSWORD = props.getProperty("db.password");
        String DB_DRIVER = props.getProperty("db.driver");
        try {
            Class.forName(DB_DRIVER);
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver not found", e);
        }
    }
}
