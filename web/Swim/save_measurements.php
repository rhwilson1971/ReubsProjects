<?php
    /*
     * 
     * date_recorded DATETIME NOT NULL,
    chest_size DOUBLE,
    waist_size DOUBLE,
    hips_size DOUBLE,
    skin_fold DOUBLE,
    weight DOUBLE,
    heart_rate DOUBLE,
    bp_diastolic DOUBLE,
    bp_systolic DOUBLE,
     * 
     * 
     */
     

    $db_hostname="localhost";
    $db_user="root";
    $db_password="Pr@y3r$";

    $db_name="swim";

    $pdo = new PDO('mysql:host=localhost;dbname=swim;charset=utf8', $db_user, $db_password ) or die("error connecting to database " . mysql_error());
    $date_recorded = new \DateTime( 'now' );
    
    $swim_user_id = filter_input(INPUT_POST, 'user_id', FILTER_SANITIZE_NUMBER_INT);
    $chest_size = filter_input(INPUT_POST, 'last_name', FILTER_SANITIZE_NUMBER_FLOAT);
    $waist_size = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_NUMBER_FLOAT);
    $hips_size = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_NUMBER_FLOAT);
    $skin_fold = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_NUMBER_FLOAT); 
    $weight = filter_input(INPUT_POST, 'weight', FILTER_SANITIZE_NUMBER_FLOAT);
    $heart_rate = filter_input(INPUT_POST, 'heart_rate', FILTER_SANITIZE_NUMBER_FLOAT);
    $bp_diastolic = filter_input(INPUT_POST, 'bp_diastolic', FILTER_SANITIZE_NUMBER_FLOAT);
    $bp_systolic = filter_input(INPUT_POST, 'bp_systolic', FILTER_SANITIZE_NUMBER_FLOAT);
	
    $ret = 
    $pdo->exec("insert into swim_measurements(date_recorded, swim_user_id, chest_size, waist_size, hips_size, skin_fold, weight, heart_rate, bp_diastolic, bp_systolic) values('$date_recorded', $swim_user, $chest_size, $waist_size, $hips_size, $skin_fold, $weight, $heart_rate, $bp_diastolic, $bp_systolic)");
     
    if ($ret==1)
    {   	
	$lastid = $pdo->lastInsertId();	
        
        $mystuff = array(':swim_measurement_id' => $lastid);
        
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


