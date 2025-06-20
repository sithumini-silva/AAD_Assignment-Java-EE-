package org.example.DAO;

import org.apache.commons.dbcp2.BasicDataSource;
import org.example.Model.Complaint;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public List<Complaint> getAllComplaints() throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT complaint_id, user_id, employee_name, title, description, status FROM complaints";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Complaint c = new Complaint();
                c.setComplaintId(rs.getInt("complaint_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setEmployeeName(rs.getString("employee_name"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                complaints.add(c);
            }
        }
        return complaints;
    }

    public boolean saveComplaint(Complaint complaint) throws SQLException {
        String sql = "INSERT INTO complaints (user_id, employee_name, title, description, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, complaint.getUserId());
            stmt.setString(2, complaint.getEmployeeName());
            stmt.setString(3, complaint.getTitle());
            stmt.setString(4, complaint.getDescription());
            stmt.setString(5, complaint.getStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating complaint failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    complaint.setComplaintId(generatedKeys.getInt(1));
                }
            }
            return true;
        }
    }
    public Complaint getComplaintById(int complaintId) throws SQLException {
        String sql = "SELECT * FROM complaints WHERE complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaintId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Complaint complaint = new Complaint();
                    complaint.setComplaintId(rs.getInt("complaint_id"));
                    complaint.setUserId(rs.getInt("user_id"));
                    complaint.setTitle(rs.getString("title"));
                    complaint.setDescription(rs.getString("description"));
                    complaint.setStatus(rs.getString("status"));
                    complaint.setEmployeeName(rs.getString("employee_name"));  // if column exists
                    return complaint;
                }
            }
        }
        return null;
    }

    public boolean updateComplaintFull(int complaintId, String title, String description, String status) throws SQLException {
        String sql = "UPDATE complaints SET title = ?, description = ?, status = ? WHERE complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, status);
            stmt.setInt(4, complaintId);
            return stmt.executeUpdate() > 0;
        }
    }

    public static int deleteComplaint(String cid,BasicDataSource ds) {
        try (Connection connection = ds.getConnection();
             PreparedStatement pstm = connection.prepareStatement("DELETE FROM complaints WHERE cid = ?")) {

            pstm.setString(1, cid);
            return pstm.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting complaint: " + e.getMessage(), e);
        }

    }

    public boolean deleteComplaint(int complaintId) throws SQLException {
        String sql = "DELETE FROM complaints WHERE complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaintId);
            return stmt.executeUpdate() > 0;
        }
    }

//    public Complaint getComplaintById(int complaintId) throws SQLException {
//        String sql = "SELECT complaint_id, user_id, employee_name, title, description, status FROM complaints WHERE complaint_id = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setInt(1, complaintId);
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    Complaint c = new Complaint();
//                    c.setComplaintId(rs.getInt("complaint_id"));
//                    c.setUserId(rs.getInt("user_id"));
//                    c.setEmployeeName(rs.getString("employee_name"));
//                    c.setTitle(rs.getString("title"));
//                    c.setDescription(rs.getString("description"));
//                    c.setStatus(rs.getString("status"));
//                    return c;
//                }
//            }
//        }
//        return null;
//    }
}