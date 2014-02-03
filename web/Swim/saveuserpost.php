<?php 
    // header('Content-type: text/plain; charset=utf-8');
    $db_hostname="localHost";
    $db_user="root";
    $db_password="Pr@y3r$";

    $db_name="swim";

    $dbh = mysql_connect($db_hostname, $db_user, $db_password) or die("error connecting to database " . mysql_error());
    mysql_select_db($db_name);

    $first_name=$_POST["first_name"];
    $last_name=$_POST["last_name"];
    $email=$_POST["email"];
    $password=$_POST["password"];
    
    $result= mysql_query("insert into swim_user(first_name, last_name, email, password) values('$first_name','$last_name','$email','$password')");
    If ($result)
    {    
        echo "<h1>Thank you</h1>";
        echo "your Information was saved";
    
	// The value of the variable name is found
	echo "<h1>First name: POST" . $_POST["first_name"] . "</h1>";
        echo "<h1>First name: var" . $first_name . "</h1>";
    }
    else
    {
        echo "<h1>Error</h1>";
        echo "were sorry but your request cannot be completed at this time";
    }
    // echo utf8_encode($message);
?>
