<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Asiakaslista</title>
<style>


</style>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="4" id="ilmo"></th>
			<th><a id="uusiAsiakas" href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
		</tr>
		<tr>
			<th>Hakusana:</th>
			<th colspan=3><input type ="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi" onclick="haeAsiakkaat()"></th>
		</tr>				
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>	
			<th></th>						
		</tr>
	</thead>
	<tbody id = "tbody">
	</tbody>
</table>
<script>
haeAsiakkaat();
document.getElementById("hakusana").focus();

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		haeTiedot();
	}		
}

function haeAsiakkaat(){	
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value,{//Lähetetään kutsu backendiin
	      method: 'GET'
	    })
	.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
		return response.json()	
	})
	.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä		
		var asiakkaat = responseJson.asiakkaat;	
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++){			
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].email+"</td>";  
        	htmlStr+="<td><a href='muutaasiakas.jsp?id="+asiakkaat[i].id+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].id+"')>Poista</span></td>";
        	htmlStr+="</tr>";        	
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})	
}

function poista(id){
	if(confirm("Poista asiakas " + id +"?")){	
		fetch("asiakkaat/"+ id,{//Lähetetään kutsu backendiin
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
			return response.json()
		})
		.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakastiedon poisto epäonnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakastiedon " + id +" poisto onnistui.";
				haeAsiakkaat();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
}


</script>
</body>
</html>