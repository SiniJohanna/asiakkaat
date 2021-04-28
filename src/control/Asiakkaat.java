package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Asiakas;
import model.dao.Dao;

@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;

   
    public Asiakkaat() {
        System.out.println("Asiakkaat.Asiakkaat()");
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		String pathInfo = request.getPathInfo();
		System.out.println("polku: " + pathInfo);
		String hakusana = "";
		if(pathInfo!=null) {		
			hakusana = pathInfo.replace("/", "");
		}
		Dao dao = new Dao();
        ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);
		System.out.println(asiakkaat);
		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setEmail(jsonObj.getString("email"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.lisaaAsiakas(asiakas)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  //Auton lis��minen onnistui {"response":1}
		}else{
			out.println("{\"response\":0}");  //Auton lis��minen ep�onnistui {"response":0}
		}
	}

	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
	}

	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
		String pathInfo = request.getPathInfo();
		System.out.println("polku: " + pathInfo);
		String poistettavaId = "";
		if(pathInfo!=null) {		
			poistettavaId = pathInfo.replace("/", "");
			
		}
		int poistoId = Integer.parseInt(poistettavaId);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.poistaAsiakas(poistoId)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  //Auton poistaminen onnistui {"response":1}
		}else{
			out.println("{\"response\":0}");  //Auton poistaminen ep�onnistui {"response":0}
		}
	}

}
