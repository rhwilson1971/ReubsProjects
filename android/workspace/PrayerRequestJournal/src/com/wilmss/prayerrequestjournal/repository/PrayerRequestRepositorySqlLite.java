package com.wilmss.prayerrequestjournal.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wilmss.prayerrequestjournal.repository.PrayerRequestRepository.PrayerRequestItem;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.*;

public class PrayerRequestRepositorySqlLite {

	private SQLiteDatabase database;
	private PrayerRequestSqlLiteHelper dbHelper;
	
	private String[] allColumns = { PrayerRequestSqlLiteHelper.COLUMN_ID,
		PrayerRequestSqlLiteHelper.COLUMN_TITLE,
		PrayerRequestSqlLiteHelper.COLUMN_DETAILS,
		PrayerRequestSqlLiteHelper.COLUMN_DATE };


	public PrayerRequestRepositorySqlLite(Context  context) {
	
		dbHelper = new PrayerRequestSqlLiteHelper(context);
		
	}
	
	public void open() throws SQLException {
		database = dbHelper.getWritableDatabase();
	}
		
	public void close(){
		dbHelper.close();
	}
		
	public PrayerRequest createPrayerRequest(String title, String detail){
		
		ContentValues values = new ContentValues();
		
		int i = (int) new Date().getTime();
		
		values.put(PrayerRequestSqlLiteHelper.COLUMN_TITLE, title);
		values.put(PrayerRequestSqlLiteHelper.COLUMN_DETAILS, detail);
		values.put(PrayerRequestSqlLiteHelper.COLUMN_DATE, i); 
		
		long id = database.insert(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, null, values);
		
		Cursor cursor = database.query(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST,
			allColumns, PrayerRequestSqlLiteHelper.COLUMN_ID + " = " + id, null, null, null, null);
			
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
		
		Date date = new Date(cursor.getInt(3) * 1000L);
		request .setDateRequested(date);
		
		return request;
	}
}

	