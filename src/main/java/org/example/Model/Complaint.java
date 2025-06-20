package org.example.Model;

public class Complaint {
    private int complaintId;
    private int userId;
    private String employeeName;
    private String title;
    private String description;
    private String status;

    // Constructors
    public Complaint() {
    }

    public Complaint(int userId, String employeeName, String title, String description, String status) {
        this.userId = userId;
        this.employeeName = employeeName;
        this.title = title;
        this.description = description;
        this.status = status;
    }

    // Getters and Setters
    public int getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(int complaintId) {
        this.complaintId = complaintId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}