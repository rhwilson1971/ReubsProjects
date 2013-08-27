/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.service.interfaces;

import com.wilmss.PrayerRequestJournal.domain.interfaces.IDisposition;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import java.util.List;

/**
 *
 * @author wilsonr1
 */
public interface IPrayerRequestJournalService {
    
    List<IDisposition> getDispositions();
    
    IPrayerRequestor getRequestorByEmail(String email);
    IPrayerRequestor getRequestorById(int requestorId);
    IPrayerRequestor getRequestorByUserNameAndPassword(String username, String password);
    
    List<IPrayerRequestor> getRequestors();
    List<IPrayerRequest> getRequestsByRequestor(IPrayerRequestor requestor);
    List<IPrayerResponse> getResponsesByRequest(IPrayerRequest request);
    
    List<IPrayerRequest> getRequestsByEmail(String email);
    List<IPrayerRequest> getRequestsByRequestsByRequestorId(int requestorId);
    IPrayerRequest getRequestByRequestId(int requestId);
    
    Boolean addRequestor(IPrayerRequestor requestor);
    Boolean addRequest(IPrayerRequest request);
    Boolean addResponse(IPrayerResponse response);
    
    Boolean deleteRequestById(int id);
}
