<?php 
    header('Content-type: text/plain; charset=utf-8');

    $db_conn = new  PDO('mysql:host=localhost;dbname=mydatabase','admin','password');
    $db_conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);  

    $message = "";
    $user = @"testUser";
    $country = ($_POST['country']); 
    $city = ($_POST['city']);
    $location = ($_POST['location']);
    $distance = ($_POST['distance']);
    $pace = ($_POST['pace']);
    $part = ($_POST['partecipant']);

    $qry = $db_conn->prepare('INSERT INTO  myTable(`user_id`,`country`,`city`,`location`,`distance`,`pace`,`max_number`) VALUES (:user,:country,:city,:location,:distance,:pace,:max_number)');
    $qry->bindParam(':user', $user);
    $qry->bindParam(':country', $country);
    $qry->bindParam(':city', $city);
    $qry->bindParam(':location', $location);
    $qry->bindParam(':distance', $distance);
    $qry->bindParam(':pace', $pace);
    $qry->bindParam(':max_number', $part);
    $qry->execute();

    if ($qry) { $message = "success"; }
    else { $message = "failed"; }

    echo utf8_encode($message);
?>
