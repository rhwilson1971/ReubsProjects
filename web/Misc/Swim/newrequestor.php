<?php

	$db_hostname="localHost";
	$db_user="reuben";
	$db_password="Pr@y3r$";

	$db_name="PRJ";

	$dbh = mysql_connect($db_hostname, $db_user, $db_password) or die("error connecting to database " . mysql_error());

	mysql_select_db($db_name);

	$name=$_POST["name"];
	$body=$_POST["body"];

	$result= mysql_query(insert into comments(name, body) values('$name','$body')");

	if ($result)
	{    
		echo "<h1>Thank you</h1>";
		echo "your comments was received";
	}
	else{
		echo "<h1>Error</h1>"
		echo "were sorry but your request cannot be completed at this time";
	}

?>

