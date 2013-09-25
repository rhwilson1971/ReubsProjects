package com.wilmss.android.PrayerRequestJournal.repository.helpers;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class PrayerResponseSqliteHelper extends SQLiteOpenHelper{
	public static final String TABLE_PRAYER_RESPONSE="prayer_response";
	public static final String COLUMN_ID = "_id";
	public static final String COLUMN_DISPOSITION = "disposition";
	public static final String COLUMN_RESPONSE_DETAIL= "response_detail";
	public static final String COLUMN_DATE_ENTERED = "date_entered";
	public static final String COLUMN_REQUEST_ID = "request_id";
	
	private static final String DATABASE_NAME = "prayer_response_journal.db";
	private static final int DATABASE_VERSION=-1;
	
	private static final String DATABASE_CREATE = "create table "
		+ TABLE_PRAYER_RESPONSE + "(" 
		+ COLUMN_ID + " integer primary key autoincrement, " 
		+ COLUMN_DISPOSITION + " text not null, " 
		+ COLUMN_RESPONSE_DETAIL + " text not null, "
		+ COLUMN_DATE_ENTERED + " integer not null,"
		+ COLUMN_REQUEST_ID + " integer not null);";
	
	public PrayerResponseSqliteHelper(Context context) {
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
			
		db.execSQL("DROP TABLE IF EXISTS " + TABLE_PRAYER_RESPONSE);
		
		onCreate(db);
	}
}
