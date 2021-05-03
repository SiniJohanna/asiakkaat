<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan=5><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th>Hakusana:</th>
			<th colspan=3><input type ="text" id="haku"></th>
			<th><input type="button" value="Hae" id="btn"></th>
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
	</tbody>
</table>
<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function() {
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#btn").click(function() {
		console.log($("#haku").val());
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event) {
		if (event.which == 13) {
			haeAsiakkaat();
		}
	});
	$("#haku").focus();
	
	
});	
function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#haku").val(), type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		console.log(result);
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.email+"</td>"; 
        	htmlStr+="<td><a href='muutaasiakas.jsp?id="+field.id+"'>Muuta</a>&nbsp;"; 
        	htmlStr+="<span class='poista' onclick=poista("+field.id+")>Poista</span></td>"; 
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}
function poista(id) {
	console.log(id);
	if(confirm("Poista asiakas " + id +"?")){
		$.ajax({url:"asiakkaat/"+id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + id +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}

</script>
</body>
</html>