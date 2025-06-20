package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.ComplaintDAO;
import org.example.DAO.UserDAO;
import org.example.Model.Complaint;
import org.example.Model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/user-details")
public class UserDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println(">> user-details servlet reached");

        try {
            UserDAO userDAO = new UserDAO();
            List<User> users = userDAO.getAllUsers();

            System.out.println("user count: " + users.size());

            HttpSession session = req.getSession(false);

//            if (session == null || session.getAttribute("userId") == null) {
//                System.out.println("The user Id is null");
//                // resp.sendRedirect(resp.encodeRedirectURL( req.getContextPath() + "/login.jsp"));
//                return;
//            }    String userId = session.getAttribute("userId").toString();
//            System.out.println("The user Id is: "+ userId);

            req.setAttribute("users", users);
            req.getRequestDispatcher("/userList.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Failed to load complaint list.");
            req.getRequestDispatcher("/userList.jsp").forward(req, resp);
        }
    }


}