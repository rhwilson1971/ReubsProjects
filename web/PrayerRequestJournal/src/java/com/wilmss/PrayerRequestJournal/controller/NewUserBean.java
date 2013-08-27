/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.controller;

import com.wilmss.PrayerRequestJournal.domain.helpers.PasswordHelper;
import com.wilmss.PrayerRequestJournal.domain.helpers.PrayerRequestJournalFactory;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.service.HibernatePrayerRequestService;
import com.wilmss.PrayerRequestJournal.service.interfaces.IPrayerRequestJournalService;

/**
 *
 * @author wilsonr1
 */

public class NewUserBean {
    
    IPrayerRequestJournalService service = new 
            HibernatePrayerRequestService();
    
    IPrayerRequestor requestor;
    
    PasswordHelper passwordHelper = new PasswordHelper("");
    
    public NewUserBean(){
        requestor = PrayerRequestJournalFactory.createRequestor();
    }
    
    public void setRequestor(IPrayerRequestor requestor) {
        this.requestor=requestor;
    }
    
    public IPrayerRequestor getRequestor() {
        if(null == this.requestor) {
            this.requestor = PrayerRequestJournalFactory.createRequestor();
        }
        return this.requestor;
    }
    
    public PasswordHelper getPasswordHelper() { 
        return this.passwordHelper;
    }
        
    public String register(){
        if ( service.addRequestor(requestor) )
            return ("home-page");
        else
            return ("create-user-page");
    }
}
