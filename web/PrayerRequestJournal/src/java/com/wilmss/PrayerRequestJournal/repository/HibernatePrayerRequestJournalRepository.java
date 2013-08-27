/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.repository;

import com.wilmss.PrayerRequestJournal.domain.entities.PrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IDisposition;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequest;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerRequestor;
import com.wilmss.PrayerRequestJournal.domain.interfaces.IPrayerResponse;
import com.wilmss.PrayerRequestJournal.repository.interfaces.IPrayerRequestJournalRepository;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author wilsonr1
 */
public class HibernatePrayerRequestJournalRepository implements IPrayerRequestJournalRepository {

    Session session = null;
    static Logger logger = LogManager.getLogger(HibernatePrayerRequestJournalRepository.class);
    
    public HibernatePrayerRequestJournalRepository(){
        
        
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    @Override
    public List<IPrayerRequestor> getAllRequestors() {
        
        List<IPrayerRequestor> requestors = null;

        try {
            
            this.session = HibernateUtil.getSessionFactory().getCurrentSession();
            
            
            org.hibernate.Transaction tx = this.session.beginTransaction();
            Query q = this.session.createQuery("from PrayerRequestor");
            requestors = (List<IPrayerRequestor>) q.list();
            
            /*
            Session session = NewHibernateUtil.getSessionFactory().openSession();
            session.beginTransaction(); 
            List<PrayerRequestor> result = (List<PrayerRequestor>)session.createQuery("from PrayerRequestor").list();
        
            for (PrayerRequestor r : result) {
                requestors.add(r);   
            }
            NewHibernateUtil.getSessionFactory().close();
            *
            */
        
        }
        catch(Exception ex){
            logger.info(ex.getMessage());
        }
    
        return requestors;
    }

    @Override
    public List<IPrayerRequest> getAllRequests() 
    {
        List<IPrayerRequest> requests = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        
        try {
            org.hibernate.Transaction tx = this.session.beginTransaction();
            Query q = this.session.createQuery("from PrayerRequest");
            requests = (List<IPrayerRequest>) q.list();            
        }
        catch(Exception e){
            logger.info(e.getMessage());
        }
        
        return requests;
    }

    @Override
    public List<IPrayerResponse> getAllResponses() {
        List<IPrayerResponse> responses = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            org.hibernate.Transaction tx = this.session.beginTransaction();
            Query q = this.session.createQuery("from PrayerResponse");
            responses = (List<IPrayerResponse>) q.list(); 
        }
        catch(HibernateException ex){
            
        }
        return responses;
    }

    @Override
    public Boolean addPrayerRequestor(IPrayerRequestor requestor) {
        
        Boolean result = false;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            
            
            
            org.hibernate.Transaction tx = this.session.beginTransaction();
            this.session.saveOrUpdate(requestor);
            
            tx.commit();
            result=true;
        }
        catch(HibernateException ex) {
            logger.error(ex.getMessage());            
        }
        return result;        
    }

    @Override
    public Boolean addPrayerRequest(IPrayerRequest request) {
        Boolean result = false;
        
        
        try {
            
            this.session = HibernateUtil.getSessionFactory().getCurrentSession();
            
            org.hibernate.Transaction tx = this.session.beginTransaction();
            this.session.saveOrUpdate(request);
            result=true;
            tx.commit();
        }
        catch(HibernateException ex) {
            logger.error(ex.getMessage());
        }
        
        return result;
    }

    @Override
    public Boolean addPrayerResponse(IPrayerResponse response) {
        Boolean result = false;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            org.hibernate.Transaction tx = this.session.beginTransaction();
            this.session.saveOrUpdate(response);
            result=true;
            tx.commit();
        }
        catch(HibernateException ex) {
            logger.error(ex.getMessage());
        }
        
        return result;        
    }

    @Override
    public List<IPrayerRequest> getPrayerRequestsByRequestorId(int id) {
        
        List<IPrayerRequest> requests = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            org.hibernate.Transaction tx = this.session.beginTransaction();
            Query q = this.session.createQuery("from PrayerRequest as pr where pr.prayerRequestor.requestorId = " + id);
            requests = (List<IPrayerRequest>) q.list();            
        }
        catch(HibernateException he){
            logger.error(he.getMessage());
        }
        
        return requests;
        
    }

    @Override
    public List<IPrayerResponse> getAllResponsesByPrayerRequestId(int id) {
        List<IPrayerResponse> responses = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            org.hibernate.Transaction tx = this.session.beginTransaction();
            Query q = this.session.createQuery("from PrayerResponse as pr where pr.requestId = " + id);
            responses = (List<IPrayerResponse>) q.list();            
        }
        catch(HibernateException he){
            logger.error(he.getMessage());
        }
        
        return responses;
    }

    @Override
    public IPrayerRequestor getRequestorByEmail(String email) {
        
        IPrayerRequestor requestor = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try{
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PrayerRequestor where email like '%" + email + "%'");
            requestor = (IPrayerRequestor)q.uniqueResult();
        }
        catch(HibernateException ex){
            logger.info(ex.getMessage());
        }
        
        
        return requestor;
        
    }

    @Override
    public IPrayerRequestor getRequestorByRequestorId(int id) {
        IPrayerRequestor requestor = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try{
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PrayerRequestor pr where pr.requestorId = " + id);
            requestor = (IPrayerRequestor)q.uniqueResult();
        }
        catch(HibernateException ex){
            logger.info(ex.getMessage());
        }
        return requestor;
    }

    @Override
    public IPrayerRequest getPrayerRequestByRequestId(int id) {
        IPrayerRequest request = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        
        try{
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PrayerRequest as pr where pr.requestId = " + id);
            request= (IPrayerRequest)q.uniqueResult();
            
        }
        catch(HibernateException ex){
            logger.info(ex.getMessage());
        }
        
        logger.info(request.getTitle());
        return request;
    }

    @Override
    public IPrayerRequestor getRequestorByUserName(String userName) {
        List<IPrayerRequestor> requestors = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try{
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PrayerRequestor where userName = '"+ userName + "'");
            requestors = (List<IPrayerRequestor>)q.list();
        }
        catch(HibernateException ex){
            logger.info(ex.getMessage());
        }
        
        if( null != requestors && requestors.size() > 0){
            return requestors.get(0);
        }
        else {
            return null;
        }
    }

    @Override
    public List<IDisposition> getDispositionList() {
        List<IDisposition> dipos = null;
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            org.hibernate.Transaction tx = this.session.beginTransaction();
            Query q = this.session.createQuery("from Disposition");
            dipos = (List<IDisposition>) q.list();            
        }
        catch(HibernateException he){
            logger.error(he.getMessage());
        }
        
        return dipos;        
    }
}
