/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.manager.UserManager;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;

/**
 *
 * @author seang_000
 */
@WebServlet(name = "confirmRegistration", urlPatterns = {"/confirmRegistration"})
public class ConfirmRegistration extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    //private final UserManager db;

    public ConfirmRegistration() {
        
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String user = request.getParameter("email");
        String firstName = request.getParameter("first");
        String lastName = request.getParameter("last");
        String password = request.getParameter("pass");
        String confirm = request.getParameter("confirm");
        
        UserManager db = (UserManager) request.getSession().getAttribute("db");
        try (PrintWriter out = response.getWriter()) {
            if(confirm.equals(password)){
                if(db.createNewUser(user, firstName, lastName, password)){
                HttpSession session = request.getSession();
                session.setAttribute("first", firstName);
                session.setAttribute("last", lastName);
                response.sendRedirect("registrationSuccess.jsp");
                }
                else{
                HttpSession session = request.getSession();
                String failMessage = db.getError();
                session.setAttribute("fail", failMessage);
                response.sendRedirect("registrationFailure.jsp");
                }
            }//end of checking password matches
            else if (!confirm.equals(password)){
                HttpSession session = request.getSession();
                String failMessage = "Passwords do not match!";
                session.setAttribute("fail", failMessage);
                response.sendRedirect("registrationFailure.jsp");
            }
        }// end of try
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
