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
import com.wilmss.android.PrayerRequestJournal.domain.PrayerResponse;
import com.wilmss.android.PrayerRequestJournal.repository.helpers.PrayerResponseSqliteHelper;


public class PrayerResponseRepositorySqlite {
	private SQLiteDatabase database;
	private PrayerResponseSqliteHelper dbHelper;
	
	private String[] allColumns = { 
		PrayerResponseSqliteHelper.COLUMN_ID,
		PrayerResponseSqliteHelper.COLUMN_DISPOSITION,
		PrayerResponseSqliteHelper.COLUMN_RESPONSE_DETAIL,
		PrayerResponseSqliteHelper.COLUMN_REQUEST_ID,
		PrayerResponseSqliteHelper.COLUMN_DATE_ENTERED 
	};

	public PrayerResponseRepositorySqlite(Context  context) {
		dbHelper = new PrayerResponseSqliteHelper(context);
	}
	
	public void open() throws SQLException {
		database = dbHelper.getWritableDatabase();
	}
		
	public void close(){
		dbHelper.close();
	}
		
	public PrayerResponse createPrayerResponse(PrayerRequest request, String disposition, String responseDetail){
		
		return this.createPrayerResponse((int)request.getId(), disposition, responseDetail);
	}
	
	public PrayerResponse createPrayerResponse(int requestId, String disposition, String responseDetail){
		ContentValues values = new ContentValues();
		
		int i = (int) new Date().getTime();
		
		values.put(PrayerResponseSqliteHelper.COLUMN_DISPOSITION, disposition);
		values.put(PrayerResponseSqliteHelper.COLUMN_RESPONSE_DETAIL, responseDetail);
		values.put(PrayerResponseSqliteHelper.COLUMN_REQUEST_ID, requestId); 
		values.put(PrayerResponseSqliteHelper.COLUMN_DATE_ENTERED, i);
		
		long id = database.insert(PrayerResponseSqliteHelper.TABLE_PRAYER_RESPONSE, null, values);
		
		Cursor cursor = database.query(PrayerResponseSqliteHelper.TABLE_PRAYER_RESPONSE,
			allColumns, PrayerResponseSqliteHelper.COLUMN_ID + " = " + id, null, null, null, null);
			
		cursor.moveToFirst();
		
		PrayerResponse response = cursorToResponse(cursor);
		
		cursor.close();
		
		return response;
		
	}
	
	private PrayerResponse cursorToResponse(Cursor cursor)
	{
		PrayerResponse response = new PrayerResponse();
		
		response.setId(cursor.getInt(0));
		response.setDisposition(cursor.getString(1));
		response.setResponse(cursor.getString(2));
		response.setPrayerRequestId(cursor.getLong(3));
		Date date = new Date(cursor.getInt(4) * 1000L);
		response.setDateEntered(date);
		return response;
	}
	
	public List<PrayerResponse> getAllRequests(){
		List<PrayerResponse> responses = new ArrayList<PrayerResponse>();
		
		Cursor cursor = database.query(PrayerResponseSqliteHelper.TABLE_PRAYER_RESPONSE, allColumns, null, 
				null, null, null, null);
		
		cursor.moveToFirst();
		
	    while (!cursor.isAfterLast()) {
	      PrayerResponse response = cursorToResponse(cursor);
	      responses.add(response);
	      cursor.moveToNext();
	    }
	    // Make sure to close the cursor
	    cursor.close();
	    
	    return responses;	
	}
}

