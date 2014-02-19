<?php 
    // header('Content-type: text/plain; charset=utf-8');
    
    $db_hostname="localhost";
    
    $db_user="root";
    $db_password="Pr@y3r$";
    $db_name="swim";
    /*
    $pdo = new PDO('mysql:host=example.com;dbname=database', 'user', 'password');
    $statement = $pdo->query("SELECT 'Hello, dear MySQL user!' AS _message FROM DUAL");
    $row = $statement->fetch(PDO::FETCH_ASSOC);
    echo htmlentities($row['_message']);
    */
    $pdo = new PDO('mysql:host=localhost;dbname=swim;charset=utf8', $db_user, $db_password ) or die("error connecting to database " . mysql_error());
    
    $first_name = filter_input(INPUT_POST, 'first_name', FILTER_SANITIZE_STRING);
    $last_name = filter_input(INPUT_POST, 'last_name', FILTER_SANITIZE_STRING);
    $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
    $password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);
    
    /*
    first_name VARCHAR(200) not null,
    last_name VARCHAR(200) not null,
    password VARCHAR(50) not null,
    email VARCHAR(200) not null,
    login_authentication_type INTEGER NOT NULL,
    is_active INTEGER,
    is_admin INTEGER,
    */
    
    $tp = 1;
    $isactive = 0;
    $isadmin = 0;
	
    $ret = $pdo->exec("insert into swim_users(first_name, last_name, email, password, login_authentication_type, is_admin, is_active) values('$first_name','$last_name','$email','$password', $tp, $isactive, $isadmin)");
     
    if ($ret==1)
    {   	
	$lastid = $pdo->lastInsertId();	
        
        $mystuff = array('swim_user_id' => $lastid);
        
        $json_data = json_encode($mystuff);
        
        echo $json_data;
    }
    else
    {
        $arr = $pdo->errorInfo();
        
        foreach ($arr as &$value) {
            echo $value;
        }
        
        
        
        echo "Last id is " . $ret;
        echo "<h1>Error</h1>";
        echo "were sorry but your request cannot be completed at this time";
    }
    // echo utf8_encode($message);
    
