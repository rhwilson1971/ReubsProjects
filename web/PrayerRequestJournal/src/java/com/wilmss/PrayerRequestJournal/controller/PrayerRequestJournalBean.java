/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.controller;

import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.service.HibernatePrayerRequestService;
import com.wilmss.PrayerRequestJournal.service.interfaces.IPrayerRequestJournalService;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 *
 * @author wilsonr1
 */

public class PrayerRequestJournalBean implements Serializable{
    
    final int MAX_RECORDS = 7;
    
    private static Logger _logger = 
            LogManager.getLogger("PrayerRequestJournalBean");    
    
    private final String _anonEmail = "anonymous@wilmss.com";
    private final String _anonGreeting = "Welcome Prayer Requestor!";
    
    IPrayerRequestor _requestor = null;
    IPrayerRequestJournalService _service = new HibernatePrayerRequestService();
    List<IPrayerRequest> _requests = null;
    List<IPrayerRequest> _staticRequests = null;
    Integer _requestId;
    
    IPrayerRequest _request = null;
    
    String _userName;
    String _password;
    String _validationMessage = "";

    Integer _currentPage = 1;
    Integer _maxPages = 1;
    
    public PrayerRequestJournalBean(){
        _requestor = _service.getRequestorByEmail(_anonEmail);
        _staticRequests = new ArrayList<IPrayerRequest>();
        for( IPrayerRequest r : _requestor.getRequests()) {
            _staticRequests.add(r);
        }        
    }
    
    public String getPassword() {return _password;}
    public void setPassword(String password) {this._password = password;}
    public String getUserName() {return _userName;}
    public void setUserName(String userName) {this._userName = userName;}
    public String getValidationMessage() { return this._validationMessage; }
    
    /***
     * 
     * @return 
     */
    public List<IPrayerRequest> getRequests() {
        return _service.getRequestsByRequestor(_requestor);
        
    }
    
    public Integer getRows() { return 10; }
	
    /***
     * 
     * @return 
     */
    public String getGreeting() {
        String greeting = _anonGreeting;
        if (null != _requestor && 
                null != _requestor.getName() &&
                !_requestor.getName().isEmpty() &&
                _requestor.getName().compareTo("anonymous") != 0 ) {
            
            if( _requestor.getName() != null && !_requestor.getName().isEmpty() ) {
                    greeting = "Welcome, " + _requestor.getName();
            }
                
        }
        return greeting;
    }
    
    /***
     * 
     * @return 
     */
    public String login() {
        IPrayerRequestor r = _service.getRequestorByUserNameAndPassword(_userName, _password); 
        if(null != r) {
            _requestor = r;
            return "index2";
        }
        else {
            this._validationMessage = "Login information incorrect, try again.";
            return null;
        }
    }
    
    /**
     * 
     * @return 
     */
    public String logout() {
	_requestor = _service.getRequestorByEmail(_anonEmail);
        _requests = _service.getRequestsByEmail(_anonEmail);
        _userName=_requestor.getUsername();
        
        return null;
    }
    
    /**
     * 
     * @return 
     */
    public Integer getRequestorId() {
        Integer id = -1;
        if (null != _requestor) {
            id=_requestor.getRequestorId();
        }
        
        return id;
    }
    
    /**
     * 
     * @return 
     */
    public Boolean getIsAnonymous (){
        
        if( null != _requestor && _requestor.getUsername().compareTo("anon") == 0) {
            return true;
        }
        else {
            return false;
        }
    }
}
