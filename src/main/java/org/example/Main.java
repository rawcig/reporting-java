package org.example;

import com.formdev.flatlaf.FlatLightLaf;
import org.example.ui.DashboardFrame;

import javax.swing.*;

public class Main {
    public static void main(String[] args) {
        // Set FlatLaf look and feel
        try {
            UIManager.setLookAndFeel(new FlatLightLaf());
        } catch (Exception ex) {
            System.err.println("Failed to initialize FlatLaf: " + ex.getMessage());
        }

        // Launch the dashboard on the EDT
        SwingUtilities.invokeLater(() -> {
            DashboardFrame dashboard = new DashboardFrame();
            dashboard.setVisible(true);
        });
    }
}
