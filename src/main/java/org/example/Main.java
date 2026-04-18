package org.example;

import com.formdev.flatlaf.FlatLightLaf;
import org.example.ui.DashboardFrame;
import org.example.util.DBConnection;

import javax.swing.*;
import java.awt.*;

public class Main {
    public static void main(String[] args) {
        // Set FlatLaf look and feel
        try {
            UIManager.setLookAndFeel(new FlatLightLaf());
        } catch (Exception ex) {
            System.err.println("Failed to initialize FlatLaf: " + ex.getMessage());
        }

        // Validate database connection before launching
        System.out.println("Checking database connection...");
        DBConnection.DBResult dbResult = DBConnection.checkConnection();

        if (!dbResult.isSuccess()) {
            // Show blocking error dialog — app will NOT start
            showDatabaseErrorDialog(dbResult);
            System.exit(1);
            return;
        }

        System.out.println("Database connection OK. Launching dashboard...");

        // Launch the dashboard on the EDT
        SwingUtilities.invokeLater(() -> {
            DashboardFrame dashboard = new DashboardFrame();
            dashboard.setVisible(true);
        });
    }

    /**
     * Shows a blocking, user-friendly error dialog when the database is unreachable.
     * The application will exit after the dialog is dismissed.
     */
    private static void showDatabaseErrorDialog(DBConnection.DBResult result) {
        // Build a detailed error panel
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        // Header with icon
        JPanel headerPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 0));
        JLabel iconLabel = new JLabel(UIManager.getIcon("OptionPane.errorIcon"));
        JLabel headerLabel = new JLabel("<html><b style='font-size:14px;'>Database Connection Failed</b><br>"
                + "<span style='font-size:12px;'>The application cannot start without a database.</span></html>");
        headerPanel.add(iconLabel);
        headerPanel.add(headerLabel);
        panel.add(headerPanel, BorderLayout.NORTH);

        // Error details in a scrollable text area
        JTextArea detailsArea = new JTextArea(result.getMessage());
        detailsArea.setEditable(false);
        detailsArea.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        detailsArea.setLineWrap(true);
        detailsArea.setWrapStyleWord(true);
        detailsArea.setBackground(new Color(255, 250, 250));
        detailsArea.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(200, 200, 200), 1),
                BorderFactory.createEmptyBorder(8, 8, 8, 8)
        ));

        JScrollPane scrollPane = new JScrollPane(detailsArea);
        scrollPane.setPreferredSize(new Dimension(500, 180));
        panel.add(scrollPane, BorderLayout.CENTER);

        // Troubleshooting tips
        String tips = "<html>"
                + "<b>Quick Checklist:</b><br>"
                + "&nbsp;&nbsp;1. Ensure PostgreSQL service is running<br>"
                + "&nbsp;&nbsp;2. Verify db.properties settings (host, port, database name)<br>"
                + "&nbsp;&nbsp;3. Check username and password<br>"
                + "&nbsp;&nbsp;4. Confirm network/firewall rules allow the connection"
                + "</html>";
        JLabel tipsLabel = new JLabel(tips);
        tipsLabel.setFont(new Font("Segoe UI", Font.PLAIN, 11));
        tipsLabel.setBorder(BorderFactory.createEmptyBorder(10, 5, 5, 5));
        panel.add(tipsLabel, BorderLayout.SOUTH);

        // Show modal dialog
        JOptionPane optionPane = new JOptionPane(
                panel,
                JOptionPane.ERROR_MESSAGE,
                JOptionPane.DEFAULT_OPTION,
                null,
                new String[]{"Exit"},
                "Exit"
        );

        JDialog dialog = optionPane.createDialog(null, "Database Connection Error");
        dialog.setModal(true);
        dialog.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
        dialog.setVisible(true);
    }
}
