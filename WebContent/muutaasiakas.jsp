<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.3/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakastiedon päivitys</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="2"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="email" id="email"></td> 
				<td><input type="button" id="tallenna" value="Hyväksy" onclick="vieTiedot()"></td>
			</tr>
		</tbody>
	</table>
	<input type = "hidden" name ="id" id="id">
</form>
<span id="ilmo"></span>
</body>
<script>

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		vieTiedot();
	}		
}

document.getElementById("etunimi").focus();

var asiakas_id = requestURLParam("id"); //Funktio löytyy scripts/main.js 
console.log(asiakas_id);
fetch("asiakkaat/haeyksi/" + asiakas_id,{//Lähetetään kutsu backendiin
      method: 'GET'	      
    })
.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastausteksti objektiksi
	return response.json()
})
.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä	
	console.log(responseJson);
	document.getElementById("etunimi").value = responseJson.etunimi;		
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("email").value = responseJson.email;	
	document.getElementById("id").value = asiakas_id;	
});	

function vieTiedot(){	
	var ilmo="";
	if(document.getElementById("etunimi").value.length<3){
		ilmo="Nimi on liian lyhyt!";		
	}else if(document.getElementById("sukunimi").value.length<2){
		ilmo="Nimi on liian lyhyt!";		
	}else if(document.getElementById("puhelin").value.length<1){
		ilmo="Numero on liian lyhyt!";		
	}else if(document.getElementById("puhelin").value*1!=document.getElementById("puhelin").value){
		ilmo="pitää olla numeroita!";		
	}else if(document.getElementById("email").value.length<5){
		ilmo="Sähköposti on liian lyhyt!";		
	}
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
		return;
	}
	document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
	document.getElementById("email").value=siivoa(document.getElementById("email").value);
	
	var formJsonStr = formDataToJSON(document.getElementById("tiedot")); //muutetaan lomakkeen tiedot json-stringiksi
	//Lähetään uudet tiedot backendiin
	
	console.log(formJsonStr);
	fetch("asiakkaat",{//Lähetetään kutsu backendiin
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi		
		return response.json()
	})
	.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Asiakastiedon muuttaminen epäonnistui";
      	}else if(vastaus==1){	        	
      		document.getElementById("ilmo").innerHTML= "Asiakastiedon muuttaminen onnistui";			      	
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset(); //tyhjennetään tiedot -lomake
}

function siivoa(teksti){
	teksti=teksti.replace("<","");
	teksti=teksti.replace(";","");
	teksti=teksti.replace("'","''");
	return teksti;
}

function formDataToJSON(data){
	var returnStr="{";
	for(var i=0; i<data.length; i++){		
		returnStr+="\"" +data[i].name + "\":\"" + data[i].value + "\",";
	}	
	returnStr = returnStr.substring(0, returnStr.length - 1); //poistetaan viimeinen pilkku
	returnStr+="}";
	return returnStr;
}

function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

</script>
</html>