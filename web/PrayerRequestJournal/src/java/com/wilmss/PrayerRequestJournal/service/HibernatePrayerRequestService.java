/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.service;

import com.wilmss.PrayerRequestJournal.domain.interfaces.IDisposition;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import com.wilmss.PrayerRequestJournal.repository.HibernatePrayerRequestJournalRepository;
import com.wilmss.PrayerRequestJournal.service.interfaces.IPrayerRequestJournalService;
import java.util.List;

/**
 *
 * @author wilsonr1
 */
public class HibernatePrayerRequestService implements IPrayerRequestJournalService {

    HibernatePrayerRequestJournalRepository repo = new
            HibernatePrayerRequestJournalRepository();
    
    @Override
    public List<IPrayerRequestor> getRequestors() {
        return repo.getAllRequestors();
    }

    @Override
    public List<IPrayerRequest> getRequestsByRequestor(IPrayerRequestor requestor) {
        return repo.getPrayerRequestsByRequestorId(requestor.getRequestorId());   
    }

    @Override
    public List<IPrayerResponse> getResponsesByRequest(IPrayerRequest request) {
        return repo.getAllResponsesByPrayerRequestId(request.getRequestId());
    }

    @Override
    public Boolean addRequestor(IPrayerRequestor requestor) {
        return repo.addPrayerRequestor(requestor);
    }

    @Override
    public Boolean addRequest(IPrayerRequest request) {
        
        if( null == request.getRequestDate()) {
            
            java.util.Date requestDate = java.util.Calendar.getInstance().getTime();
            
            request.setRequestDate(requestDate);
            request.setRequestTime(requestDate);
        }
        
        return repo.addPrayerRequest(request);
    }

    @Override
    public Boolean addResponse(IPrayerResponse response) {
        return repo.addPrayerResponse(response);
    }

    @Override
    public List<IPrayerRequest> getRequestsByEmail(String email) {
        
        List <IPrayerRequest> requests = null;
        IPrayerRequestor requestor = repo.getRequestorByEmail(email);
        if( null != requestor ) {
            requests = repo.getPrayerRequestsByRequestorId(requestor.getRequestorId());
        }
        return requests;
    }

    @Override
    public List<IPrayerRequest> getRequestsByRequestsByRequestorId(int requestorId) {
        return repo.getPrayerRequestsByRequestorId(requestorId);
    }

    @Override
    public IPrayerRequest getRequestByRequestId(int requestId) {
        return repo.getPrayerRequestByRequestId(requestId);
    }

    @Override
    public Boolean deleteRequestById(int id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
	
	@Override
	public IPrayerRequestor getRequestorByEmail(String email){
		return repo.getRequestorByEmail(email);
	}
	
	@Override
	public IPrayerRequestor getRequestorById(int requestorId){
		return repo.getRequestorByRequestorId(requestorId);
	}

    @Override
    public IPrayerRequestor getRequestorByUserNameAndPassword(String username, String password) {
        
        IPrayerRequestor requestor = null;
        
        for(IPrayerRequestor r : repo.getAllRequestors()) {
            if(r.getUsername().compareToIgnoreCase(username) == 0 && 
                    r.getPassword().compareTo(password) == 0 ) {
                requestor = r;
                break;
            }
        }
        
        return requestor;
    }

    @Override
    public List<IDisposition> getDispositions() {
        return repo.getDispositionList();
    }
    
}

