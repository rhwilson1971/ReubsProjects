/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.domain.interfaces;

import java.util.Date;
import java.util.Set;

/**
 *
 * @author wilsonr1
 */
public interface IPrayerRequestor {

    String getUsername();
    void setUsername(String userName);
    
    int getRequestorId();
    void setRequestorId(int id);
    
    String getName();
    void setName(String name);
    
    String getEmail();
    void setEmail(String email);
    
    void setPassword(String password);
    String getPassword();
    
    void setLastLogonDate(Date logonDate);
    Date getLastLogonDate();

    void setLastLogonTime(Date logonTime);
    Date getLastLogonTime();

    void setIsactive(Integer isActive);
    Integer getIsactive();

    void setIsadmin(Integer isAdmin);
    Integer getIsadmin();    
    
    void setRequests(Set<IPrayerRequest> requests);
    Set<IPrayerRequest> getRequests();
    
}
