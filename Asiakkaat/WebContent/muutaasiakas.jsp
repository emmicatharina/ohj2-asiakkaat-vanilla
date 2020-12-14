<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Muuta asiakkaan tiedot</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
    <table>
        <thead>
            <tr>
                <th colspan="3" id="ilmo"></th>
                <th colspan="2" class="oikealle"><a href="listaaasiakkaat.jsp">Takaisin listaukseen</a></th>
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
                <td><input type="text" name="sposti" id="sposti"></td>
                <td><input type="button" name="nappi" id="tallenna" value="Tallenna" onclick="paivitaTiedot()"></td>
            </tr>    
        </tbody>
    </table>
    <input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmo"></span>
<script>
function tutkiKey(event) {
    if (event.keyCode == 13) {
        paivitaTiedot();
    }
}

document.getElementById("etunimi").focus();

var asiakas_id = requestURLParam("asiakas_id");
fetch("asiakkaat/haeyksi/" + asiakas_id, {
    method: 'GET'
})
.then( function (response) {
    return response.json()
})
.then( function (responseJson) {
    document.getElementById("etunimi").value = responseJson.etunimi;		
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("sposti").value = responseJson.sposti;	
	document.getElementById("asiakas_id").value = responseJson.asiakas_id;	
});

function paivitaTiedot() {
    var ilmo = "";
    var etunimi = document.getElementById("etunimi").value;
	var sukunimi = document.getElementById("sukunimi").value;
	var puhelin = document.getElementById("puhelin").value;
    var sposti = document.getElementById("sposti").value;

    if (document.getElementById("etunimi").value.length < 1) {
        ilmo = "Etunimi on liian lyhyt!";
    } else if (document.getElementById("sukunimi").value.length < 1) {
        ilmo = "Sukunimi on liian lyhyt!";
    } else if (document.getElementById("puhelin").value.length < 4) {
        ilmo = "Puhelinnumero on liian lyhyt!";
    } else if (document.getElementById("sposti").value.length < 6) {
        ilmo = "Sähköpostiosoite on liian lyhyt!";
    }
    if (ilmo != "") {
        document.getElementById("ilmo").innerHTML = ilmo;
        setTimeout(function() { document.getElementById("ilmo").innerHTML = ""; }, 3000);
        return;
    }
    document.getElementById("etunimi").value = siivoa(document.getElementById("etunimi").value);
    document.getElementById("sukunimi").value = siivoa(document.getElementById("sukunimi").value);
    document.getElementById("puhelin").value = siivoa(document.getElementById("puhelin").value);
    document.getElementById("sposti").value = siivoa(document.getElementById("sposti").value);

    var formJsonStr = formDataToJSON(document.getElementById("tiedot"));

    fetch("asiakkaat",{
	      method: 'PUT',
	      body: formJsonStr
	    })
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;		
		if (vastaus == 0) {
			document.getElementById("ilmo").innerHTML= "Asiakkaan päivittäminen epäonnistui.";
        } else if (vastaus == 1) {	        	
        	document.getElementById("ilmo").innerHTML= "Asiakkaan päivittäminen onnistui.";			      	
		}	
	});	
}
</script>
</body>
</html>