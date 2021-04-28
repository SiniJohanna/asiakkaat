package model;

public class Asiakas {
	private int id;
	private String etunimi, sukunimi, puhelin, email;
	
	public Asiakas() {
		super();
	}

	public Asiakas(int id, String etunimi, String sukunimi, String puhelin, String email) {
		super();
		this.id = id;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puhelin = puhelin;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEtunimi() {
		return etunimi;
	}

	public void setEtunimi(String etuimi) {
		this.etunimi = etuimi;
	}

	public String getSukunimi() {
		return sukunimi;
	}

	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}

	public String getPuhelin() {
		return puhelin;
	}

	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Asiakas [id=" + id + ", etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puhelin=" + puhelin
				+ ", email=" + email + "]";
	}

	
	
	

}
