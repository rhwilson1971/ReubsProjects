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
public interface IPrayerResponse {
    
    void setResponseId(int id);
    int getResponseId();
    
    void setRequestId(int id);
    int getRequestId();
    
    void setDetail(String detail);
    String getDetail();
    
    void setDisposition(String disposition);
    String getDisposition();
    
    void setResponseDate(Date date);
    Date getResponseDate();
    
    void setResponseTime(Date time);
    Date getResponseTime();    
}
