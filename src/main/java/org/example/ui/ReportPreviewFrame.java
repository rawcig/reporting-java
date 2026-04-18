package org.example.ui;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.*;
import net.sf.jasperreports.swing.JRViewer;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;

/**
 * Report preview dialog with export buttons.
 * Uses JDialog with MODELESS to avoid blocking the Event Dispatch Thread (EDT).
 * Manually disables the owner to simulate modal behavior safely.
 */
public class ReportPreviewFrame extends JDialog {

    private final JasperPrint jasperPrint;
    private final Frame parentFrame;

    public ReportPreviewFrame(Frame owner, JasperPrint jasperPrint, String title) {
        super(owner, title, ModalityType.MODELESS);
        this.jasperPrint = jasperPrint;
        this.parentFrame = owner;
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        getContentPane().setBackground(Color.WHITE);

        // Ensure the dashboard is re-enabled when this preview is closed
        addWindowListener(new WindowAdapter() {
            @Override
            public void windowOpened(WindowEvent e) {
                // Parent is already disabled by caller
            }

            @Override
            public void windowClosed(WindowEvent e) {
                // Re-enable dashboard
                if (parentFrame != null) {
                    SwingUtilities.invokeLater(() -> {
                        parentFrame.setEnabled(true);
                        parentFrame.toFront();
                        parentFrame.requestFocusInWindow();
                    });
                }
            }
        });

        initComponents();
    }

    private void initComponents() {
        // === Top toolbar ===
        JToolBar toolbar = new JToolBar();
        toolbar.setFloatable(false);
        toolbar.setBackground(new Color(245, 245, 245));
        toolbar.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createMatteBorder(0, 0, 1, 0, new Color(200, 200, 200)),
            BorderFactory.createEmptyBorder(5, 5, 5, 5)
        ));

        toolbar.add(makeBtn("  Export PDF  ", new Color(198, 40, 40), e -> exportPdf()));
        toolbar.add(makeBtn("  Export Excel  ", new Color(21, 101, 60), e -> exportExcel()));
        toolbar.add(makeBtn("  Export CSV  ", new Color(13, 71, 161), e -> exportCsv()));
        toolbar.add(makeBtn("  Export HTML  ", new Color(60, 60, 140), e -> exportHtml()));
        toolbar.addSeparator(new Dimension(20, 0));
        toolbar.add(makeBtn("  Close  ", new Color(100, 100, 100), e -> dispose()));

        // === JRViewer panel ===
        JRViewer viewer = new JRViewer(jasperPrint);
        viewer.setBackground(Color.WHITE);

        JPanel contentPanel = new JPanel(new BorderLayout());
        contentPanel.add(toolbar, BorderLayout.NORTH);
        contentPanel.add(viewer, BorderLayout.CENTER);
        contentPanel.setBackground(Color.WHITE);

        add(contentPanel);
    }

    /**
     * Show this dialog.
     * Disables the parent frame to prevent focus stealing while open.
     */
    public void showOnTop() {
        // Size to 90% of screen
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        Rectangle screenBounds = ge.getMaximumWindowBounds();
        int width = (int) (screenBounds.width * 0.9);
        int height = (int) (screenBounds.height * 0.9);
        setSize(width, height);
        
        // Center on parent
        setLocationRelativeTo(getOwner());
        
        // Bring to front BEFORE making visible
        setAlwaysOnTop(true);
        toFront();
        requestFocusInWindow();
        
        // Now make visible
        setVisible(true);
        
        // Ensure focus is on this window
        SwingUtilities.invokeLater(() -> {
            toFront();
            requestFocusInWindow();
            getRootPane().requestFocus();
        });
    }

    private JButton makeBtn(String text, Color bg, java.awt.event.ActionListener action) {
        JButton btn = new JButton(text);
        btn.setFont(new Font("Segoe UI", Font.BOLD, 11));
        btn.setForeground(Color.WHITE);
        btn.setBackground(bg);
        btn.setFocusPainted(false);
        btn.setBorderPainted(false);
        btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btn.addActionListener(action);
        return btn;
    }

    // === Export Methods ===

    private void exportPdf() {
        JFileChooser fc = new JFileChooser();
        fc.setSelectedFile(new File("report.pdf"));
        fc.setFileFilter(new FileNameExtensionFilter("PDF Files (*.pdf)", "pdf"));
        if (fc.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) { return; }
        File f = fixExt(fc.getSelectedFile(), ".pdf");
        
        // Delete existing file if it will be overwritten
        if (f.exists()) {
            int result = JOptionPane.showConfirmDialog(this,
                "File already exists. Do you want to overwrite?",
                "File Exists",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.QUESTION_MESSAGE);
            if (result != JOptionPane.YES_OPTION) { return; }
            if (!f.delete()) {
                showError("PDF", new RuntimeException("Cannot overwrite existing file: " + f.getAbsolutePath()));
                return;
            }
        }
        
        try (java.io.FileOutputStream fos = new java.io.FileOutputStream(f)) {
            JRPdfExporter ex = new JRPdfExporter();
            ex.setExporterInput(new SimpleExporterInput(jasperPrint));
            ex.setExporterOutput(new SimpleOutputStreamExporterOutput(fos));
            SimplePdfExporterConfiguration cfg = new SimplePdfExporterConfiguration();
            cfg.setCreatingBatchModeBookmarks(true);
            cfg.setMetadataAuthor("Reporting System");
            cfg.setMetadataTitle(getTitle());
            cfg.setMetadataSubject("Report");
            cfg.setEncrypted(false);
            ex.setConfiguration(cfg);
            ex.exportReport();
            
            // Flush and close is handled by try-with-resources
            if (f.exists() && f.length() > 0) {
                msg("PDF exported successfully!\n\nFile: " + f.getAbsolutePath() + "\nSize: " + (f.length() / 1024) + " KB");
            } else {
                showError("PDF", new RuntimeException("Exported file is empty (0 bytes)"));
            }
        } catch (java.io.IOException e) {
            showError("PDF", e);
        } catch (Exception e) {
            showError("PDF", e);
        }
    }

    private void exportExcel() {
        JFileChooser fc = new JFileChooser();
        fc.setSelectedFile(new File("report.xlsx"));
        fc.setFileFilter(new FileNameExtensionFilter("Excel Files (*.xlsx)", "xlsx"));
        if (fc.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) { return; }
        File f = fixExt(fc.getSelectedFile(), ".xlsx");
        try {
            JRXlsxExporter ex = new JRXlsxExporter();
            ex.setExporterInput(new SimpleExporterInput(jasperPrint));
            ex.setExporterOutput(new SimpleOutputStreamExporterOutput(f));
            SimpleXlsxReportConfiguration cfg = new SimpleXlsxReportConfiguration();
            cfg.setOnePagePerSheet(true);
            cfg.setDetectCellType(true);
            cfg.setRemoveEmptySpaceBetweenRows(true);
            cfg.setRemoveEmptySpaceBetweenColumns(true);
            cfg.setWhitePageBackground(false);
            cfg.setWrapText(true);
            cfg.setCollapseRowSpan(false);
            cfg.setShowGridLines(true);
            cfg.setFreezeColumn("A");
            ex.setConfiguration(cfg);
            ex.exportReport();
            if (f.exists() && f.length() > 1024) {
                msg("Excel exported successfully!\n\nFile: " + f.getAbsolutePath() + "\nSize: " + (f.length() / 1024) + " KB");
            } else {
                showError("Excel", new RuntimeException("Exported file is empty or too small (" + f.length() + " bytes)"));
            }
        } catch (Exception e) { showError("Excel", e); }
    }

    private void exportHtml() {
        JFileChooser fc = new JFileChooser();
        fc.setSelectedFile(new File("report.html"));
        fc.setFileFilter(new FileNameExtensionFilter("HTML Files", "html"));
        if (fc.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) { return; }
        File f = fixExt(fc.getSelectedFile(), ".html");
        try {
            HtmlExporter ex = new HtmlExporter();
            ex.setExporterInput(new SimpleExporterInput(jasperPrint));
            ex.setExporterOutput(new SimpleHtmlExporterOutput(f));
            SimpleHtmlExporterConfiguration cfg = new SimpleHtmlExporterConfiguration();
            cfg.setHtmlHeader("<html><head><meta charset=\"UTF-8\"><title>" + getTitle() + "</title></head><body>");
            cfg.setHtmlFooter("</body></html>");
            cfg.setBetweenPagesHtml("<hr style=\"page-break-after: always;\">");
            ex.setConfiguration(cfg);
            ex.exportReport();
            if (f.exists() && f.length() > 0) {
                msg("HTML exported successfully!\n\nFile: " + f.getAbsolutePath() + "\nSize: " + (f.length() / 1024) + " KB");
            } else {
                showError("HTML", new RuntimeException("Exported file is empty (0 bytes)"));
            }
        } catch (Exception e) { showError("HTML", e); }
    }

    private void exportCsv() {
        JFileChooser fc = new JFileChooser();
        fc.setSelectedFile(new File("report.csv"));
        fc.setFileFilter(new FileNameExtensionFilter("CSV Files", "csv"));
        if (fc.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) { return; }
        File f = fixExt(fc.getSelectedFile(), ".csv");
        try {
            JRCsvExporter ex = new JRCsvExporter();
            ex.setExporterInput(new SimpleExporterInput(jasperPrint));
            ex.setExporterOutput(new SimpleWriterExporterOutput(f));
            ex.exportReport();
            if (f.exists() && f.length() > 0) {
                msg("CSV exported successfully!\n\nFile: " + f.getAbsolutePath() + "\nSize: " + (f.length() / 1024) + " KB");
            } else {
                showError("CSV", new RuntimeException("Exported file is empty (0 bytes)"));
            }
        } catch (Exception e) { showError("CSV", e); }
    }

    private File fixExt(File f, String ext) {
        String p = f.getAbsolutePath();
        return p.toLowerCase().endsWith(ext) ? f : new File(p + ext);
    }

    private void msg(String s) {
        JOptionPane.showMessageDialog(this, s, "Export Complete", JOptionPane.INFORMATION_MESSAGE);
    }

    private void showError(String fmt, Exception e) {
        JTextArea ta = new JTextArea("Format: " + fmt + "\n\nError: " + e.getMessage());
        ta.setEditable(false);
        ta.setFont(new Font("Consolas", Font.PLAIN, 11));
        ta.setRows(4);
        ta.setColumns(50);
        JScrollPane sp = new JScrollPane(ta);
        JOptionPane.showMessageDialog(this, sp, "Export Error", JOptionPane.ERROR_MESSAGE);
        e.printStackTrace();
    }
}