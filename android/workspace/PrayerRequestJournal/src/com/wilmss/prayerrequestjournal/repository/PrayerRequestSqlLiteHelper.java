package com.wilmss.prayerrequestjournal.repository;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;


public class PrayerRequestSqlLiteHelper extends SQLiteOpenHelper {

	public static final String TABLE_PRAYER_REQUEST="prayer_request";
	public static final String COLUMN_ID = "_id";
	public static final String COLUMN_TITLE = "title";
	public static final String COLUMN_DETAILS = "details";
	public static final String COLUMN_DATE = "dateRequested";
	
	private static final String DATABASE_NAME = "prayer_request_journal.db";
	private static final int DATABASE_VERSION=-1;
	
	private static final String DATABASE_CREATE = "create table "
		+ TABLE_PRAYER_REQUEST + "(" + COLUMN_ID 
		+ " integer primary key autoincrement, " + COLUMN_TITLE
		+ " text not null, " + COLUMN_DETAILS 
		+ " text, " + COLUMN_DATE
		+ " integer not null);";
		
	
	public PrayerRequestSqlLiteHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}
	
	@Override
	public void onCreate(SQLiteDatabase db)
	{
		db.execSQL(DATABASE_CREATE);
	}
	
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion){
		Log.w(PrayerRequestSqlLiteHelper.class.getName(), "Upgrading database from version " + oldVersion
			+ " to " + newVersion + ", Which will destroy old data");
			
		db.execSQL("DROP TABLE IF EXISTS " + TABLE_PRAYER_REQUEST);
		
		onCreate(db);
	}
}
