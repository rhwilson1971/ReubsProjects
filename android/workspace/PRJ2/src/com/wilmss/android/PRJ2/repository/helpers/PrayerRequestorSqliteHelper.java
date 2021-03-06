package com.wilmss.android.PRJ2.repository.helpers;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class PrayerRequestorSqliteHelper extends SQLiteOpenHelper {
	public static final String TABLE_PRAYER_REQUESTOR="prayer_requestor";
	public static final String COLUMN_ID = "_id";
	public static final String COLUMN_FIRST_NAME = "first_name";
	public static final String COLUMN_LAST_NAME = "last_name";
	public static final String COLUMN_EMAIL = "email";
	
	private static final String DATABASE_NAME = "prayer_requestor_journal.db";
	private static final int DATABASE_VERSION=-1;
	
	private static final String DATABASE_CREATE = "create table "
		+ TABLE_PRAYER_REQUESTOR + "(" 
		+ COLUMN_ID + " integer primary key autoincrement, " 
		+ COLUMN_FIRST_NAME + " text not null, " 
		+ COLUMN_LAST_NAME + " text not null, " 
		+ COLUMN_EMAIL + " text not null);";
	
	public PrayerRequestorSqliteHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}
	
	@Override
	public void onCreate(SQLiteDatabase db)
	{
		db.execSQL(DATABASE_CREATE);
	}
	
	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion){
		Log.w(PrayerRequestSqliteHelper.class.getName(), "Upgrading database from version " + oldVersion
			+ " to " + newVersion + ", Which will destroy old data");
			
		db.execSQL("DROP TABLE IF EXISTS " + TABLE_PRAYER_REQUESTOR);
		
		onCreate(db);
	}
}
