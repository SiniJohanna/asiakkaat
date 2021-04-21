package model;

public class Asiakas {
	private int id;
	private String eNimi, sNimi, puhNo, email;
	
	public Asiakas() {
		super();
	}

	public Asiakas(int id, String eNimi, String sNimi, String puhNo, String email) {
		super();
		this.id = id;
		this.eNimi = eNimi;
		this.sNimi = sNimi;
		this.puhNo = puhNo;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String geteNimi() {
		return eNimi;
	}

	public void seteNimi(String eNimi) {
		this.eNimi = eNimi;
	}

	public String getsNimi() {
		return sNimi;
	}

	public void setsNimi(String sNimi) {
		this.sNimi = sNimi;
	}

	public String getPuhNo() {
		return puhNo;
	}

	public void setPuhNo(String puhNo) {
		this.puhNo = puhNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Asiakas [id=" + id + ", eNimi=" + eNimi + ", sNimi=" + sNimi + ", puhNo=" + puhNo + ", email=" + email
				+ "]";
	}
	
	

}
