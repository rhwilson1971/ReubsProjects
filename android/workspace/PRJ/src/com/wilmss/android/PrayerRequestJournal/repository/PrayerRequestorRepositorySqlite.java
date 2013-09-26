package com.wilmss.android.PrayerRequestJournal.repository;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import com.wilmss.android.PrayerRequestJournal.domain.PrayerRequestor;
import com.wilmss.android.PrayerRequestJournal.repository.helpers.PrayerRequestSqliteHelper;
import com.wilmss.android.PrayerRequestJournal.repository.helpers.PrayerRequestorSqliteHelper;

public class PrayerRequestorRepositorySqlite {
	
	private SQLiteDatabase database;
	private PrayerRequestorSqliteHelper dbHelper;
	
	private String[] allColumns = { 
			PrayerRequestorSqliteHelper.COLUMN_ID,
			PrayerRequestorSqliteHelper.COLUMN_FIRST_NAME,
			PrayerRequestorSqliteHelper.COLUMN_LAST_NAME,
			PrayerRequestorSqliteHelper.COLUMN_EMAIL, 
	};

	public PrayerRequestorRepositorySqlite (Context  context) {
		dbHelper = new PrayerRequestorSqliteHelper(context);
	}
	
	public void open() throws SQLException {
		database = dbHelper.getWritableDatabase();
	}
		
	public void close(){
		dbHelper.close();
	}
		
	public PrayerRequestor createPrayerRequestor(String firstName, String lastName, String email){		
		ContentValues values = new ContentValues();
		
		values.put(PrayerRequestorSqliteHelper.COLUMN_FIRST_NAME, firstName);
		values.put(PrayerRequestorSqliteHelper.COLUMN_LAST_NAME, lastName);
		values.put(PrayerRequestorSqliteHelper.COLUMN_EMAIL, email); 
		
		long id = database.insert(PrayerRequestorSqliteHelper.TABLE_PRAYER_REQUESTOR, null, values);
		
		Cursor cursor = database.query(PrayerRequestorSqliteHelper.TABLE_PRAYER_REQUESTOR,
			allColumns, PrayerRequestSqliteHelper.COLUMN_ID + " = " + id, null, null, null, null);
			
		cursor.moveToFirst();
		
		PrayerRequestor request = cursorToRequestor(cursor);
		
		cursor.close();
		
		return request;
	}
	
	private PrayerRequestor cursorToRequestor(Cursor cursor)
	{
		PrayerRequestor requestor = new PrayerRequestor();
		
		requestor.setRequestorId(cursor.getInt(0));
		requestor.setFirstName(cursor.getString(1));
		requestor.setLastNamse(cursor.getString(2));
		requestor.setEmai(cursor.getString(3));
	
		return requestor;
	}
	
	public List<PrayerRequestor> getAllRequestors(){
		List<PrayerRequestor> prayerRequestors = new ArrayList<PrayerRequestor>();
		
		Cursor cursor = database.query(PrayerRequestSqliteHelper.TABLE_PRAYER_REQUEST, allColumns, null, 
				null, null, null, null);
		
		cursor.moveToFirst();
		
	    while (!cursor.isAfterLast()) {
	      PrayerRequestor request = cursorToRequestor(cursor);
	      prayerRequestors.add(request);
	      cursor.moveToNext();
	    }
	    // Make sure to close the cursor
	    cursor.close();
	    
	    return prayerRequestors;
	}	

}
