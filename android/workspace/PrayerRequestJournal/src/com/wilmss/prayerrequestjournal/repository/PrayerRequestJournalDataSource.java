package com.wilmss.prayerrequestjournal.repository;

import java.util.ArrayList;
import java.uilt.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

public class PrayerRequestJournalDataSource
{
	
	private SQLiteDatabase database;
	private PrayerREquestJournalSqlLiteHelper dbHelper;
	private String[] allColumns = { PrayerRequestJournalSqlLiteHelper.COLUMN_ID,
		PrayerRequestJournalSqlLiteHelper.COLUMN_TITLE,
		PrayerRequestJournalSqlLiteHelper.COLUMN_DETAILS,
		PrayerRequestJournalSqlLiteHelper.COLUMN_DATE };
		
		public PrayerRequestJournalDataSource (Context context){
			this.dbHelper = PrayerREquestJournalSqlLiteHelpernew (context);
		}
		
		public void open() throws SQLException {
			this.database=this.dbHelper.getWritableDatabase();
		}
		
		public void close(){
			this.dbHelper.close();
		}
		
		public PrayerRequestItem createPrayerRequestItem(String title, String details)
		{
			ContentValues value = new ContentValues();
			
			values.put(PrayerRequestJournalSqlLiteHelper.COLUMN_TITLE, title);
			values.put(PrayerRequestJournalSqlLiteHelper.COLUMN_DETAILS, details);
			
			Date d = new Date();
			
			values.put(PrayerRequestJournalSqlLiteHelper.COLUMN_DATE, d);
			
			long id = database.insert(PrayerRequestJournalSqlLiteHelper.TABLE_PRAYER_REQUEST, null, values);
			
			Cursor cursor = database.query(PrayerRequestJournalSqlLiteHelper.TABLE_PRAYER_REQUEST, this.allColumns, 
					PrayerRequestJournalSqlLiteHelper.COLUMN_ID + " = " + id, null, null, null, null);
					
			cursor.moveToFirst();
			
			PrayerRequestItem item = cursorToItem(cursor);
			
			return item;
		
		}
		
		
		
		private PrayerRequestJournalItem cursorToItem(Cursor cursor)
		{
			PrayerRequestJournalItem item = new PrayerRequestJournalItem();
			item.setId(cursor.getLong(0));
			
			
		}

}