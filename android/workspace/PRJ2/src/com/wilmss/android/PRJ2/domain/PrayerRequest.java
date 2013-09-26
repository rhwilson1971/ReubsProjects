package com.wilmss.android.PRJ2.domain;
import java.util.Date;

public class PrayerRequest {

	private long id;
	private String title;
	private String detail;
	private Date dateRequested;
	private long requestorId;
	private int confidence;
	private Date datedCompleted;
	
	public long getId(){
		return id;
	}
	
	public void setId(long id){
		this.id = id;
	}
	
	public String getTitle(){
		return title;
	}
	
	public void setTitle(String title){
		this.title = title;
	}
	
	public String getDetail(){
		return detail;
	}
	
	public void setDetail(String detail){
		this.detail = detail;
	}
	
	public long getRequestorId(){
		return this.requestorId;
	}
	
	public void setRequestorId(long id){
		this.requestorId=id;
	}
	
	public Date getDateRequested(){
		return this.dateRequested;
	}
	
	public void setDateRequested(Date dateRequested){
		this.dateRequested=dateRequested;
	}
	
	public void setConfidence(int confidence){
		this.confidence=confidence;
	}
	
	public int getConfidence(){
		return this.confidence;
	}
	
	public void setDateCompleted(Date date){
		this.datedCompleted= date;
	}
	
	public Date getDateCompleted(){
		return this.datedCompleted;
	}
	
	public String toString(){
		return this.title;
	}
}
