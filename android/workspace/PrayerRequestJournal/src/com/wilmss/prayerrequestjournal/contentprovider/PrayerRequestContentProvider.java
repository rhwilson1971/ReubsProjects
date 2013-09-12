package com.wilmss.prayerrequestjournal.contentprovider;

import java.util.Arrays;
import java.util.HashSet;

import com.wilmss.prayerrequestjournal.repository.PrayerRequestSqlLiteHelper;
import com.wilmss.prayerrequestjournal.repository.PrayerRequestorSqlLiteHelper;

import android.content.ContentProvider;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.UriMatcher;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteQueryBuilder;
import android.net.Uri;


public class PrayerRequestContentProvider extends ContentProvider {

	private PrayerRequestSqlLiteHelper database;
	
	private static final int PRAYER_REQUESTS = 10;
	private static final int PRAYER_REQUEST_ID = 20;
	
	private static final String AUTHORITY = "com.wilmss.prayerrequestjournal.repository";
	
	private static final String BASE_PATH = "prayer_requests";
	  
	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + BASE_PATH);
	
	public static final String CONTENT_TYPE = ContentResolver.CURSOR_DIR_BASE_TYPE
			+ "/prayer_requests";
	
	public static final String CONTENT_ITEM_TYPE = ContentResolver.CURSOR_ITEM_BASE_TYPE
			+ "/prayer_request";
	
	private static final UriMatcher sURIMatcher = new UriMatcher(UriMatcher.NO_MATCH);
	static {
		sURIMatcher.addURI(AUTHORITY, BASE_PATH, PRAYER_REQUESTS);
		sURIMatcher.addURI(AUTHORITY, BASE_PATH + "/#", PRAYER_REQUEST_ID);
	}	

	@Override
	public boolean onCreate(){
		
		database = new PrayerRequestSqlLiteHelper(getContext());
		
		return false;
	}
	
	@Override
	public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder)
	{
		SQLiteQueryBuilder queryBuilder = new SQLiteQueryBuilder();
		
		checkColumns(projection);
		
		queryBuilder.setTables(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST);
		
		int uriType = sURIMatcher.match(uri);
		
		switch(uriType){
		
		case PRAYER_REQUESTS:
			break;
		case PRAYER_REQUEST_ID:
			// add 
			queryBuilder.appendWhere(PrayerRequestSqlLiteHelper.COLUMN_ID + "="
					+uri.getLastPathSegment());
			break;
		default :
			throw new IllegalArgumentException("Unknown uri: " + uri);
		}
		
		SQLiteDatabase db=database.getWritableDatabase();
		
		Cursor cursor = queryBuilder.query(db, projection, selection, selectionArgs, null,  null, sortOrder);
		cursor.setNotificationUri(getContext().getContentResolver(), uri);
		
		return cursor;
	}
	
	

	private void checkColumns(String[] projection) {
		// TODO Auto-generated method stub
		String [] available = { PrayerRequestSqlLiteHelper.COLUMN_DATE,
				PrayerRequestSqlLiteHelper.COLUMN_DETAILS, PrayerRequestSqlLiteHelper.COLUMN_TITLE, PrayerRequestSqlLiteHelper.COLUMN_ID };
		if( projection != null){
			
			HashSet<String> requestedColumns = new HashSet<String>(Arrays.asList(projection));
			HashSet<String> availableColumns = new HashSet<String>(Arrays.asList(available));
			
			if(!availableColumns.containsAll(requestedColumns))
				throw new IllegalArgumentException("Unknown columns in projection");
		}
	}

	@Override
	public int delete(Uri uri, String selection, String[] selectionArgs) {
		int uriType = sURIMatcher.match(uri);
		
		SQLiteDatabase db=database.getWritableDatabase();
		int rowsDeleted=0;
		
		switch(uriType){
		
		case PRAYER_REQUESTS:
			rowsDeleted = db.delete(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, selection, selectionArgs);
			break;
		
		case PRAYER_REQUEST_ID:
			String id = uri.getLastPathSegment();
			if(selection.isEmpty()){
				rowsDeleted = db.delete(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, PrayerRequestSqlLiteHelper.COLUMN_ID + "=" + id, null);
			} else {
				rowsDeleted = db.delete(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, 
						PrayerRequestSqlLiteHelper.COLUMN_ID + "=" + id + " and " + selection, 
						null);			
			}
			break;
		default:
			throw new IllegalArgumentException("Unknown URI: " + uri);
		}
		
		getContext().getContentResolver().notifyChange(uri, null);
		
		return rowsDeleted;
	}

	@Override
	public String getType(Uri arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Uri insert(Uri uri, ContentValues values) {
		int uriType = sURIMatcher.match(uri);
		
		SQLiteDatabase db = database.getWritableDatabase();
		
		long id = 0;
		
		switch(uriType){
		case PRAYER_REQUESTS:
			id = db.insert(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, null, values);
			break;
			
		default:
			throw new IllegalArgumentException("Unknown URI: " + uri);
			
		}
		
		getContext().getContentResolver().notifyChange(uri, null);
		
		return Uri.parse(BASE_PATH + "/" + id);
	}

	@Override
	public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
		int uriType = sURIMatcher.match(uri);
		
		SQLiteDatabase db=database.getWritableDatabase();
		int rowsUpdated=0;
		
		switch(uriType){
		
		case PRAYER_REQUESTS:
			rowsUpdated = db.update(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, 
					values,
					selection, 
					selectionArgs);
			break;
		
		case PRAYER_REQUEST_ID:
			String id = uri.getLastPathSegment();
			if(selection.isEmpty()){
				rowsUpdated = db.update(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST, 
						values,
						PrayerRequestSqlLiteHelper.COLUMN_ID + "=" + id, 
						null);
			} else {
				rowsUpdated = db.update(PrayerRequestSqlLiteHelper.TABLE_PRAYER_REQUEST,
						values,
						PrayerRequestSqlLiteHelper.COLUMN_ID + "=" + id + " and " + selection, 
						null);			
			}
			break;
		default:
			throw new IllegalArgumentException("Unknown URI: " + uri);
		}
		
		getContext().getContentResolver().notifyChange(uri, null);
		
		return rowsUpdated;
	}
	
}
