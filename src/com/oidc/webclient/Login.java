package com.oidc.webclient;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String state = UUID.randomUUID().toString();
		request.getSession().setAttribute("CLIENT_LOCAL_STATE", state);
		
		String authorizationUri = "https://mobile.legend-park.com/connect/authorize";
		String clientId = "31b7732e-733b-4081-91ff-290879dd0d65b";
		String scope = "openid profile email mobile_api";
		String redirectUri = "http://localhost:8080/oidc-web-client/signin-oidc";
		String nonce = UUID.randomUUID().toString();
		
		String authorizationLocation = authorizationUri + "?response_type=code id_token"
				  + "&client_id=" + clientId
				  + "&redirect_uri=" + redirectUri
				  + "&scope=" + scope
				  + "&state=" + state
				  + "&nonce=" + nonce;
		
		response.sendRedirect(authorizationLocation);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
