/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.domain.interfaces;

import java.util.Date;

/**
 *
 * @author wilsonr1
 */
public interface IPrayerRequest {

    void setRequestorId(int requestorId);
    int getRequestorId();
    
    void setRequestId(int requestorId);
    int getRequestId();
    
    void setRequest(String request);
    String getRequest();
    
    void setRequestDate(Date date);
    Date getRequestDate();
    
    void setRequestTime(Date time);
    Date getRequestTime();
    
    void setTitle(String title);
    String getTitle();
    
    void setPrayerRequestor(IPrayerRequestor requestor);
    IPrayerRequestor getPrayerRequestor();
}
