<?php
  $host="localhost";  //replace with your hostname
  $username="root";   //replace with your username
  $password="Sw1m";       //replace with your password
  $db_name="demo";    //replace with your database
  
  $con=mysql_connect("$host", "$username", "$password")or die("cannot connect");
  
  mysql_select_db("$db_name") or die("cannot select DB");
  
  $sql = "select * from emp_info"; //replace emp_info with your table name
  $result = mysql_query($sql);
  
  $json = array();
  
  if(mysql_num_rows($result)){
    
    while($row=mysql_fetch_row($result)){
      $json['emp_info'][]=$row;
    }
  }
  
  mysql_close($db_name);
  
  echo json_encode($json);
  // please refer to our PHP JSON encode function tutorial for learning json_encode function in detail
  // - See more at: http://www.w3resource.com/JSON/JSON-example.php#sthash.Lb9FWPBX.dpuf
?>
