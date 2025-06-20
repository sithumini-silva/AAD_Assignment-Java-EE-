package org.example.Servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.DAO.ComplaintDAO;
import org.example.Model.Complaint;

import java.io.IOException;
import java.util.*;

@WebServlet("/complaint-details")
public class ComplaintDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println(">> complaint-details servlet reached");

        try {
            ComplaintDAO complaintDAO = new ComplaintDAO();
            List<Complaint> complaints = complaintDAO.getAllComplaints();

            System.out.println("Complaint count: " + complaints.size());

            HttpSession session = req.getSession(false);

            if (session == null || session.getAttribute("userId") == null) {
                System.out.println("The user Id is null");
                // resp.sendRedirect(resp.encodeRedirectURL( req.getContextPath() + "/login.jsp"));
                return;
            }    String userId = session.getAttribute("userId").toString();
            System.out.println("The user Id is: "+ userId);

            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("/complaintList.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Failed to load complaint list.");
            req.getRequestDispatcher("/complaintList.jsp").forward(req, resp);
        }
    }


}