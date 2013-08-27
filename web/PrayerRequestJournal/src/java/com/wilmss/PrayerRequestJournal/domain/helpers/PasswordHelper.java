/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.domain.helpers;

/**
 *
 * @author wilsonr1
 */
public class PasswordHelper {

  String password;
  String passwordConfirm;
  
  public PasswordHelper(String password){
    this.password = password;
    this.passwordConfirm = password;
  }
  
  public String getPassword(){
    return this.password;
  }
  
  public void setPassword(String password){
    this.password = password;
  }
  
  public String getPasswordConfirm(){
    return this.passwordConfirm;
  }
  
  public void setPasswordConfirm(String password){
    this.passwordConfirm = password;
  }
  
  public String confirmPassword(){
    if (password==null || password.isEmpty())
      return "Password required";
    
    if(passwordConfirm == null || passwordConfirm.isEmpty())
      return "Confirm password";
      
    if ( password.compareTo(passwordConfirm) != 0 )
        return "Passwords do not match";
    
    return "Password accepted";
  }
}

