
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
function formDataToJSON(data){
	var returnStr = "{";
	for(var i = 0; i < data.length; i++){		
		returnStr += "\"" + data[i].name + "\":\"" + data[i].value + "\",";
	}	
	returnStr = returnStr.substring(0, returnStr.length - 1);
	returnStr += "}";
	return returnStr;
}	

function siivoa(teksti) {
    teksti = teksti.replace("<", "");
    teksti = teksti.replace(";", "");
    teksti = teksti.replace("'", "''");
    return teksti;
}