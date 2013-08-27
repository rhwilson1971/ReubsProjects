/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.controller;

import com.wilmss.PrayerRequestJournal.domain.interfaces.IDisposition;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import com.wilmss.PrayerRequestJournal.service.HibernatePrayerRequestService;
import com.wilmss.PrayerRequestJournal.service.interfaces.IPrayerRequestJournalService;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.event.ActionEvent;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
 
/**
 *
 * @author wilsonr1
 */

public class ShowPrayerRequestBean implements Serializable {

    Integer requestId;
    Integer requestorId;
    
    private String disposition;
    IPrayerRequestJournalService service = null;
    
    IPrayerRequestor requestor = null;
    IPrayerRequest request = null;
    IPrayerResponse response = null;
    List<IPrayerResponse> responses = null;
    
    static Logger logger = LogManager.getLogger(ShowPrayerRequestBean.class);
    
    /**
     * Creates a new instance of NewJSFManagedBean
     */
    public ShowPrayerRequestBean(){
        
        this.service = new HibernatePrayerRequestService();
        
        if( this.requestId != null ) {
            
            if( this.requestId == -1 )  {
                this.request = com.wilmss.PrayerRequestJournal.domain.helpers.PrayerRequestJournalFactory.createRequest();
            }
            else {
                this.request = service.getRequestByRequestId(requestId);
                this.requestorId = request.getRequestorId();
                
                this.responses = this.service.getResponsesByRequest(request);
            }
        }
        else {
            this.request = this.service.getRequestsByEmail("anonymous@wilmss.com").get(0);
            this.requestorId = this.request.getRequestorId();
        }
    }
    
    public void setTitle(String title){
        if(null != this.request){
            this.request.setTitle(title);
        }
    }
    
    public String getTitle(){
        if( null != this.request ) {
            return this.request.getTitle();
        }
        
        return "<Enter request title>";
    }
    
    public void setRequest(String request){
        if(null != this.request){
            this.request.setRequest(request);
        }
    }
    
    public String getRequest() {
        
        if(null != this.request ) {
            return request.getRequest();
        }
        
        return "<Enter request details>";
    }
    
    public String save(){
        
        if(this.request.getRequestorId()==0){
            if( 0 == this.request.getRequestorId()){
                this.request.setRequestorId(requestorId);
            }
        }
        
        if(this.request.getPrayerRequestor() == null) {
            if( null == this.requestor ) {
                this.requestor = this.service.getRequestorById(this.requestorId);
            }
            request.setPrayerRequestor(this.requestor);
        }
        
        if( !this.service.addRequest(this.request)) {
            // return "index.jsf?faces-redirect=true";
            return "index";
        }
       //return "index.jsf?faces-redirect=true";
        return "index";
    }
    
    /**
     * Property method that returns a string with the Current prayer response
     * 
     * @return 
     */
    public String getResponse() {
        
        String myResponse;
        
        if( null == this.response ){
            this.response = com.wilmss.PrayerRequestJournal.domain.helpers.PrayerRequestJournalFactory.createResponse();
            myResponse = "";
        }
        else{
            myResponse = this.response.getDetail();
        }
        
        return myResponse;
    }
    
    /**
     * Sets the response 
     * @param response 
     */
    public void setResponse(String response){
        
        if(null == this.response ){
            this.response = com.wilmss.PrayerRequestJournal.domain.helpers.PrayerRequestJournalFactory.createResponse();
        }
        
        this.response.setDetail(response);
    }
    
    public String saveResponse(){
        
        this.response.setRequestId(this.request.getRequestId());
        this.response.setDisposition(this.disposition);
        Date today = Calendar.getInstance().getTime();
        this.response.setResponseDate(today);
        this.response.setResponseTime(today);
        
        if( !service.addResponse(this.response)){
            return null;
        }
        
       return "last-request";
    }    
    
  /**
   * 
  */   
  public void viewRequestAction(ActionEvent event){
      Integer requestId1 = (Integer) event.getComponent().getAttributes().get("requestId"); 
      this.request = this.service.getRequestByRequestId(requestId1);
  }    
  
  /*
   * 
   */
  public void setRequestId(Integer id){
      if( null == id) {
        
          return ;
      
      }
      
      this.requestId = id; 
      
      // the request parameters are set after object construction
      // need to get the proper prayer request when property is set.
      getRequestDetails(id);
  }
  public Integer getRequestId(){ return this.requestId; }

  void getRequestDetails(Integer id) {
      
      // get request information
      if(null != id) {
          if( -1 == id ) {
              this.request = com.wilmss.PrayerRequestJournal.domain.helpers.PrayerRequestJournalFactory.createRequest();
          }
          else{
              this.request = this.service.getRequestByRequestId(this.requestId);
          }
      }
      // get corresponding response
      
      // don't get response, always make it new
      /*
      if( 0 != request.getRequestId() ) {
        responses=service.getResponsesByRequest(request);
        if( null != responses && responses.size() > 0){
            response = responses.get(0);
        }
      }
      */ 
  }
    /**
     * @return the disposition
     */
    public String getDisposition() {
        if( null == this.disposition || this.disposition.isEmpty()){
            
            this.disposition = this.getLastResponseDisposition();
        }
        return this.disposition;
    }

    /**
     * @param disposition the disposition to set
     */
    public void setDisposition(String disposition) {
        this.disposition = disposition;
    }
    
    /**
     * 
     * @return 
     */
    public List<String> getDispositionList() {
        List<String> dispositions = new ArrayList<String>();
        for(IDisposition d : this.service.getDispositions()  ) {
            dispositions.add(d.getDisposition());
        }
        
        dispositions.add("other");
        return dispositions;
    }
    
    /**
     * 
     * @param id 
     */
    public void setRequestorId(Integer id){this.requestorId = id; }
    
    /**
     * 
     * @return 
     */
    public Integer getRequestorId(){ return this.requestorId; }  
    
    /**
     * 
     * @return 
     */
    public Date getLastResponseDate(){
        Date d = new Date();
        return  d;
    } 
    
    /**
     * 
     * @return 
     */
    public String getLastResponseDisposition() {
        
        String lastDisposition = "Waiting";
        
        if( null != this.request) {
            
            List<IPrayerResponse> theResponses = this.service.getResponsesByRequest(this.request);
            
            IPrayerResponse newestResponse = null;
            
            for ( IPrayerResponse r : theResponses ) {
                
                if( null == newestResponse ) {
                    
                    newestResponse = r;
                    continue; 
                } else if( newestResponse.getResponseDate().before(r.getResponseDate())){
                    newestResponse = r;
                }
            }
            
            if (null != newestResponse && !newestResponse.getDisposition().isEmpty()) {
                lastDisposition = newestResponse.getDisposition();
            }
        }
        
        return lastDisposition;
    }
    
    /**
     * 
     * @return 
     */
    public String getLastResponse() {
        return "No response";
    }
    
    /**
     * 
     * @return 
     */
    public String updateResponse() {
        return "response2";
    }
    
    /**
     * 
     * @return 
     */
    public List<IPrayerResponse> getResponses() {
        this.responses = service.getResponsesByRequest(this.request);
        return this.responses;
    }
    
    /**
     * 
     * @return 
     */
    public String selectedResponse() {
        return null;
    }
    
    /**
     * 
     * @param event 
     */
    public void getSelectedResponseAction(ActionEvent event) {
        
        Integer responseId = (Integer) event.getComponent().getAttributes().get("rId");
        // logger.info("The nutrition action resulted in soda id: name " + nutritionSodaId);
        
        // this.sodaId = nutritionSodaId;

        //logger.info("The nutrition action resulted in soda id: name " + nutritionSodaId);
        //logger.info("The nutrition action resulted in soda id: id" + this.sodaId);
        for( IPrayerResponse r : this.responses) {
            if ( r.getResponseId() == responseId ) {
                this.response = r;
                break;
            }
        }
    }
}
