/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.repository.interfaces;

import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IDisposition;
import java.util.List;

/**
 *
 * @author wilsonr1
 */
public interface IPrayerRequestJournalRepository {
    
    public List<IDisposition> getDispositionList();
    
    public List<IPrayerRequest> getPrayerRequestsByRequestorId(int id);
    public List<IPrayerRequestor> getAllRequestors();
    public List<IPrayerRequest> getAllRequests();
    public List<IPrayerResponse> getAllResponses();
    public List<IPrayerResponse> getAllResponsesByPrayerRequestId(int id);
    
    public IPrayerRequestor getRequestorByEmail(String email);
    public IPrayerRequestor getRequestorByUserName(String userName);
    public IPrayerRequestor getRequestorByRequestorId(int id);
    public IPrayerRequest getPrayerRequestByRequestId(int id);
    
    public Boolean addPrayerRequestor(IPrayerRequestor requestor);
    public Boolean addPrayerRequest(IPrayerRequest request);
    public Boolean addPrayerResponse(IPrayerResponse response);
    
}
