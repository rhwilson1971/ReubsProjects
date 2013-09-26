package com.wilmss.android.PrayerRequestJournal.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import com.wilmss.android.PrayerRequestJournal.domain.PrayerRequest;
import com.wilmss.android.PrayerRequestJournal.domain.PrayerRequestor;
import com.wilmss.android.PrayerRequestJournal.repository.helpers.PrayerRequestSqliteHelper;

public class PrayerRequestRepositorySqlLite {

	private SQLiteDatabase database;
	private PrayerRequestSqliteHelper dbHelper;
	
	private String[] allColumns = { 
		PrayerRequestSqliteHelper.COLUMN_ID,
		PrayerRequestSqliteHelper.COLUMN_TITLE,
		PrayerRequestSqliteHelper.COLUMN_DETAILS,
		PrayerRequestSqliteHelper.COLUMN_DATE, 
		PrayerRequestSqliteHelper.COLUMN_CONFIDENCE,
		PrayerRequestSqliteHelper.COLUMN_REQUESTOR_ID,
		PrayerRequestSqliteHelper.COLUMN_DATE_COMPLETED
	};

	public PrayerRequestRepositorySqlLite(Context  context) {
		dbHelper = new PrayerRequestSqliteHelper(context);
	}
	
	public void open() throws SQLException {
		database = dbHelper.getWritableDatabase();
	}
		
	public void close(){
		dbHelper.close();
	}
		
	public PrayerRequest createPrayerRequest(PrayerRequestor requestor, String title, String detail, int confidence){		

		return this.createPrayerRequest(requestor.getId(), title, detail, confidence);
	}
	
	public PrayerRequest createPrayerRequest(long requestorId, String title, String detail, int confidence){
		
		ContentValues values = new ContentValues();
		
		int i = (int) new Date().getTime();
		
		values.put(PrayerRequestSqliteHelper.COLUMN_TITLE, title);
		values.put(PrayerRequestSqliteHelper.COLUMN_DETAILS, detail);
		values.put(PrayerRequestSqliteHelper.COLUMN_DATE, i); 
		values.put(PrayerRequestSqliteHelper.COLUMN_REQUESTOR_ID, requestorId);
		values.put(PrayerRequestSqliteHelper.COLUMN_CONFIDENCE, confidence);
		
		long id = database.insert(PrayerRequestSqliteHelper.TABLE_PRAYER_REQUEST, null, values);
		
		Cursor cursor = database.query(PrayerRequestSqliteHelper.TABLE_PRAYER_REQUEST,
			allColumns, PrayerRequestSqliteHelper.COLUMN_ID + " = " + id, null, null, null, null);
			
		cursor.moveToFirst();
		
		PrayerRequest request = cursorToRequest(cursor);
		
		cursor.close();
		
		return request;		
	}
	
	private PrayerRequest cursorToRequest(Cursor cursor)
	{
		PrayerRequest request = new PrayerRequest();
		
		request.setId(cursor.getLong(0));
		request.setTitle(cursor.getString(1));
		request.setDetail(cursor.getString(2));
		request.setRequestorId(cursor.getInt(3));
		request.setConfidence(cursor.getInt(4));
		
		Date date = new Date(cursor.getInt(3) * 1000L);
		request .setDateRequested(date);
		
		return request;
	}
	
	public List<PrayerRequest> getAllRequests(){
		List<PrayerRequest> prayerRequests = new ArrayList<PrayerRequest>();
		
		Cursor cursor = database.query(PrayerRequestSqliteHelper.TABLE_PRAYER_REQUEST, allColumns, null, 
				null, null, null, null);
		
		cursor.moveToFirst();
		
	    while (!cursor.isAfterLast()) {
	      PrayerRequest request = cursorToRequest(cursor);
	      prayerRequests.add(request);
	      cursor.moveToNext();
	    }
	    // Make sure to close the cursor
	    cursor.close();
	    
	    return prayerRequests;
	}
}

	