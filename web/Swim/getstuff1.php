<?php

$link = mysql_pconnect("localhost", "root", "") or die("Could not connect");
mysql_select_db("test") or die("Could not select database");
 
$arr = array();
 
$rs = mysql_query("SELECT * FROM people");
 
while($obj = mysql_fetch_object($rs)) {
    $arr[] = $obj;
}
echo '{"members":'.json_encode($arr).'}';

/*
//The json object is :
{"members":[{"id":"1","title":"Mr","firstname":"Peter","surname":"Ventouris"},{"id":"2","title":"Mr","firstname":"David","surname":"Dabel"},{"id":"3","title":"Mr","firstname":"John","surname":"Merkel"},{"id":"4","title":"Mr","firstname":"James","surname":"Eltons"}]}
*/



?>