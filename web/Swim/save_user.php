<?php 
    // header('Content-type: text/plain; charset=utf-8');
    $db_hostname="localHost";
    $db_user="root";
    $db_password="Pr@y3r$";

    $db_name="swim";
    
    /*
    $pdo = new PDO('mysql:host=example.com;dbname=database', 'user', 'password');
    $statement = $pdo->query("SELECT 'Hello, dear MySQL user!' AS _message FROM DUAL");
    $row = $statement->fetch(PDO::FETCH_ASSOC);
    echo htmlentities($row['_message']);
    */
    
    $pdo = new PDO('mysql:host=localhost;dbname=$db_name', $db_user, $db_password ) or die("error connecting to database " . mysql_error());
    
    $first_name=$_POST["first_name"];
    $last_name=$_POST["last_name"];
    $email=$_POST["email"];
    $password=$_POST["password"];
    
    $statement = $pdo->exec("insert into swim_user(first_name, last_name, email, password) values('$first_name','$last_name','$email','$password')");

    $last_id = PDO::lastInsertId();
    
    If ($last_id )
    {    
        echo "<h1>Thank you</h1>";
        echo "your Information was saved";
    
	// The value of the variable name is found
        echo "<h1>Hello 2" . $first_name . "</h1>";
        echo "<h1>LastID=" . $last_id . "</h1>";
    }
    else
    {
        echo "<h1>Error</h1>";
        echo "were sorry but your request cannot be completed at this time";
    }
    // echo utf8_encode($message);
?>
