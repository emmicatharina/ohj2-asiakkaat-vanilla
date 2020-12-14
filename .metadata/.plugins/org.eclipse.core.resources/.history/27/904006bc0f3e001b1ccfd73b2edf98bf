<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaat</title>
</head>
<body>
<table id="listaus">
    <thead>
        <tr>
            <th colspan="5" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
        </tr>
        <tr>
            <th class="oikealle">Hakusana:</th>
            <th colspan="3"><input type="text" id="hakusana" placeholder="Kirjoita hakusana..."></th>
            <th class="vasemmalle"><input type="button" value="Hae" id="hakunappi"></th>
        </tr>
        <tr>
            <th class="vasemmalle">Etunimi</th>
            <th class="vasemmalle">Sukunimi</th>
            <th class="vasemmalle">Puhelin</th>
            <th class="vasemmalle">Sähköposti</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<script>
$(document).ready(function() {
    $("#uusiAsiakas").click(function() {
        document.location="lisaaasiakas.jsp";
    });
    
    haeAsiakkaat();
    $("#hakunappi").click(function() {
        haeAsiakkaat();
    });

    $(document.body).on("keydown", function(event) {
        if (event.which == 13) {
            haeAsiakkaat();
        }
    });
    $("#hakusana").focus();
});

function haeAsiakkaat() {
    $("#listaus tbody").empty();
    $.ajax({url:"asiakkaat/" + $("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {
            $.each(result.asiakkaat, function(i, field) {
                var htmlStr;
                htmlStr += "<tr id='rivi_" + field.asiakas_id + "'>";
                htmlStr += "<td>" + field.etunimi + "</td>";
                htmlStr += "<td>" + field.sukunimi + "</td>";
                htmlStr += "<td>" + field.puhelin + "</td>";
                htmlStr += "<td>" + field.sposti + "</td>";
                htmlStr += "<td><a href='muutaasiakas.jsp?asiakas_id=" + field.asiakas_id + "'>Muuta</a>&nbsp;";
                htmlStr += "<span class='poista' onclick=poista(" + field.asiakas_id + ",'" + field.etunimi + "','" + field.sukunimi + "')>Poista</span></td>";
                htmlStr += "<tr>";
                $("#listaus tbody").append(htmlStr);    
            });
        }});
}

function poista(asiakas_id, etunimi, sukunimi) {
    if (confirm("Poista asiakas " + etunimi + " " + sukunimi + "?")) {
    	$.ajax({url:"asiakkaat/" + asiakas_id, type:"DELETE", dataType:"json", success:function(result) {
    		if (result.response == 0) {
          		$("#ilmo").html("Asiakkaan poisto epäonnistui.");
            } else if (result.response == 1) {			
          		$("#rivi_" + asiakas_id).css("background-color", "#FF0000");
          		alert("Asiakkaan " + etunimi + " " + sukunimi + " poisto onnistui.");
          		haeAsiakkaat();
    	    }
    	}});
    }
}
</script>
</body>
</html>