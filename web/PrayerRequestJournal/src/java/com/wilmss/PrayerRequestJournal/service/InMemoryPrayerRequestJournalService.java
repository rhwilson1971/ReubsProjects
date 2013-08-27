/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.service;

import com.wilmss.PrayerRequestJournal.domain.interfaces.IDisposition;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import com.wilmss.PrayerRequestJournal.service.interfaces.IPrayerRequestJournalService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author wilsonr1
 */
public class InMemoryPrayerRequestJournalService implements IPrayerRequestJournalService {

    Map<IPrayerRequestor,List<IPrayerRequest>> requestorToRequests =
            new HashMap<IPrayerRequestor, List<IPrayerRequest>>();
    
    List<IPrayerRequestor> requestors = new ArrayList<IPrayerRequestor>();
    
    public InMemoryPrayerRequestJournalService () {
        
        IPrayerRequestor r1 = new com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequestor();
        r1.setRequestorId(1);
        r1.setName("Jane");
        r1.setEmail("jane.tapper@wilmss.com");
        r1.setIsactive(1);
        r1.setPassword("");
        r1.setIsadmin(0);
        
        IPrayerRequestor r2 = new com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequestor();
        r2.setRequestorId(2);
        r2.setName("Jane");
        r2.setEmail("jane.tapper@wilmss.com");
        r2.setIsactive(1);
        r2.setPassword("");
        r2.setIsadmin(0);
        
        IPrayerRequest req1 = new com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequest();
        req1.setRequestId(1);
        req1.setRequestorId(r1.getRequestorId());
        req1.setTitle("Prayer for world peace");
        req1.setRequest("I pray for peace everywhere.  This world has become senseless");
        
        IPrayerRequest req2 = new com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequest();
        req2.setRequestId(2);
        req2.setRequestorId(r1.getRequestorId());
        req2.setTitle("Prayer healing of Cancer");
        req2.setRequest("Cancer is so widespread");
        
        IPrayerRequest req3 = new com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequest();
        req3.setRequestId(3);
        req3.setRequestorId(r1.getRequestorId());
        req3.setTitle("Prayer Spiritual guidance");
        req3.setRequest("I pray for peace everywhere.  This world has become senseless");
        
        IPrayerRequest req4 = new com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequest();
        req4.setRequestId(4);
        req4.setRequestorId(r2.getRequestorId());
        req4.setTitle("Prayer for Job");
        req4.setRequest("Bills piling up.  Need help!");        
        
        ArrayList<IPrayerRequest> requests1 = new ArrayList<IPrayerRequest>();
        requests1.add(req1);
        requests1.add(req2);
        requests1.add(req3);
        
        ArrayList<IPrayerRequest> requests2 = new ArrayList<IPrayerRequest>();
        requests2.add(req4);
        
        requestorToRequests.put(r1,requests1);
        requestorToRequests.put(r2,requests2);
        
        requestors.add(r1);
        requestors.add(r2);
    }
    
    
    @Override
    public List<IPrayerRequestor> getRequestors() {
        return requestors;
    }

    @Override
    public List<IPrayerRequest> getRequestsByRequestor(IPrayerRequestor requestor) {
        return requestorToRequests.get(requestor);
    }

    
    public List<IPrayerResponse> getResponsesByRequestor(IPrayerResponse requestor) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Boolean addRequestor(IPrayerRequestor requestor) {
        requestors.add(requestor);
        return true;
    }

    @Override
    public Boolean addRequest(IPrayerRequest request) {
        //List<IPrayerRequest> requests = requestorToRequests.get(requestor);
        //requests.add(request);
        return true;
    }

    
    public Boolean addResponse(IPrayerRequestor requestor, IPrayerResponse response) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<IPrayerRequest> getRequestsByEmail(String email) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<IPrayerRequest> getRequestsByRequestsByRequestorId(int requestorId) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public IPrayerRequest getRequestByRequestId(int requestId) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Boolean deleteRequestById(int id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
	
	@Override
	public IPrayerRequestor getRequestorByEmail(String email){
		throw new UnsupportedOperationException("Not supported yet.");
	}
	
	@Override
	public IPrayerRequestor getRequestorById(int requestorId){
		throw new UnsupportedOperationException("Not supported yet.");
	}

    @Override
    public IPrayerRequestor getRequestorByUserNameAndPassword(String username, String password) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<IPrayerResponse> getResponsesByRequest(IPrayerRequest request) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Boolean addResponse(IPrayerResponse response) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<IDisposition> getDispositions() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

	
}
