<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th>Hakusana:</th>
			<th><input type ="text" id="haku"></th>
			<th><button>Hae</button></th>
		</tr>				
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	$.ajax({url:"asiakkaat", type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		console.log(result);
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.eNimi+"</td>";
        	htmlStr+="<td>"+field.sNimi+"</td>";
        	htmlStr+="<td>"+field.puhNo+"</td>";
        	htmlStr+="<td>"+field.email+"</td>";  
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
});	

</script>
</body>
</html>