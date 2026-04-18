package org.example.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static String url;
    private static String username;
    private static String password;

    static {
        try (InputStream input = DBConnection.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find db.properties");
            }
            Properties props = new Properties();
            props.load(input);
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            Class.forName(props.getProperty("db.driver"));
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to load database configuration", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * Tests whether the database is reachable.
     * @return a DBResult indicating success or failure with a user-friendly message
     */
    public static DBResult checkConnection() {
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                return new DBResult(true, "Database connected successfully.", null);
            } else {
                return new DBResult(false, "Connection was established but is closed.", null);
            }
        } catch (SQLException e) {
            String userMessage = classifySqlError(e);
            return new DBResult(false, userMessage, e);
        } catch (Exception e) {
            return new DBResult(false, "Unexpected error: " + e.getMessage(), e);
        }
    }

    /**
     * Classifies common SQL/PostgreSQL errors into user-friendly messages.
     */
    private static String classifySqlError(SQLException e) {
        String state = e.getSQLState();
        String message = e.getMessage();

        if (state == null) {
            return "Unable to connect to the database.\n\nDetails: " + message;
        }

        // Connection refusal (PostgreSQL: 08001, 08006)
        if (state.equals("08001") || state.equals("08006")) {
            if (message != null && message.contains("Connection refused")) {
                return "Cannot reach the database server.\n\n"
                        + "Possible causes:\n"
                        + "  • PostgreSQL service is not running\n"
                        + "  • Wrong host or port in db.properties\n"
                        + "  • Firewall blocking the connection\n\n"
                        + "Please check your database settings and try again.";
            }
            return "Unable to establish a connection to the database.\n\nDetails: " + message;
        }

        // Authentication failure (08004, 28000, 28P01)
        if (state.equals("08004") || state.startsWith("28")) {
            return "Database authentication failed.\n\n"
                    + "  • Wrong username or password in db.properties\n"
                    + "  • The database user may not have access to this database\n\n"
                    + "Please verify your credentials and try again.";
        }

        // Database does not exist (3D000)
        if (state.equals("3D000")) {
            return "The specified database does not exist.\n\n"
                    + "  • Check the database name in db.properties\n"
                    + "  • Ensure the database has been created\n\n"
                    + "Please verify your database settings.";
        }

        // Generic SQL error
        return "Database connection failed.\n\n"
                + "SQL State: " + state + "\n"
                + "Details: " + message;
    }

    /**
     * Result wrapper for database connection checks.
     */
    public static class DBResult {
        private final boolean success;
        private final String message;
        private final Throwable cause;

        public DBResult(boolean success, String message, Throwable cause) {
            this.success = success;
            this.message = message;
            this.cause = cause;
        }

        public boolean isSuccess() {
            return success;
        }

        public String getMessage() {
            return message;
        }

        public Throwable getCause() {
            return cause;
        }
    }
}
