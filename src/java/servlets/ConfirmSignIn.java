/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.manager.UserManager;
import javax.servlet.http.HttpSession;

/**
 *
 * @author seang_000
 */
@WebServlet(name = "confirmSignIn", urlPatterns = {"/confirmSignIn"})
public class ConfirmSignIn extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //retrieves value from forms
        String user = request.getParameter("email");
        String password = request.getParameter("pass");
        
        //retrieves bean from index.jsp
        UserManager db = (UserManager) request.getSession().getAttribute("db");
        try (PrintWriter out = response.getWriter()) {
        
            //method that authenticates user
            if(db.authenticateUser(user, password)){
                HttpSession session = request.getSession();
                //user information is stores to populate bean on home.jsp
                session.setAttribute("user", user);
                session.setAttribute("first", db.getFirstName());
                session.setAttribute("last", db.getLastName());
                session.setAttribute("admin", db.getAdmin());
                response.sendRedirect("home.jsp");
            }
            else{
                //error message if user or password is incorrect
                HttpSession session = request.getSession();
                session.setAttribute("fail", "Sorry! Invalid username or password! Try again.");
                response.sendRedirect("index.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
