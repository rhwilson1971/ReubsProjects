/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.domain.helpers;

import com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.entities.PrayerResponse;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import com.wilmss.PrayerRequestJournal.repository.HibernatePrayerRequestJournalRepository;
import com.wilmss.PrayerRequestJournal.repository.interfaces.IPrayerRequestJournalRepository;
import com.wilmss.PrayerRequestJournal.service.HibernatePrayerRequestService;
import com.wilmss.PrayerRequestJournal.service.InMemoryPrayerRequestJournalService;
import com.wilmss.PrayerRequestJournal.service.interfaces.IPrayerRequestJournalService;

/**
 *
 * @author wilsonr1
 */
public class PrayerRequestJournalFactory {
    
    public static IPrayerRequestor createRequestor() {
        IPrayerRequestor requestor = new PrayerRequestor();
        return requestor;
    }
    public static IPrayerRequest createRequest() {
        IPrayerRequest request = new PrayerRequest();
        return request;
    }
    
    public static IPrayerResponse createResponse() {
        IPrayerResponse response = new PrayerResponse();
        return response;
    }
    
    public static IPrayerRequestJournalRepository getRepository(String repo){
        if( repo.compareTo("H") == 0)
            return new HibernatePrayerRequestJournalRepository();
        
        else 
            return null;
    }
    
    public static IPrayerRequestJournalService getService(String service) {
        if( service.compareTo("H") == 0)
            return new HibernatePrayerRequestService();
        else 
            return new InMemoryPrayerRequestJournalService();
    }
}
