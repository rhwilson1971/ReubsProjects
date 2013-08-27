package com.wilmss.prayerrequestjournal.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wilmss.prayerrequestjournal.repository.PrayerRequestRepository.PrayerRequestItem;

import android.database.sqlite.*;

public class PrayerRequestRepositorySqlLite {

	
    /**
     * An array of sample (dummy) items.
     */
    public static List<PrayerRequestItem> ITEMS = new ArrayList<PrayerRequestItem>();

    /**
     * A map of sample (dummy) items, by ID.
     */
    public static Map<String, PrayerRequestItem> ITEM_MAP = new HashMap<String, PrayerRequestItem>();

    static {
        // Add 3 sample items.
        addItem(new PrayerRequestItem("1", "Prayer for New Child", "Prayed for a new child this week that is healthy"));
        addItem(new PrayerRequestItem("2", "Arnolds's Cancer", "Arnold contracted cancer last year..."));
        addItem(new PrayerRequestItem("3", "Toby's Eyeballs", "Tony has been having streaks in his eyes"));
    }

    private static void addItem(PrayerRequestItem item) {
        ITEMS.add(item);
        ITEM_MAP.put(item.id, item);
    }
    
    private static void  GetAllItems()
    {
    	
    	
    }

    /**
     * A dummy item representing a piece of content.
     */
    public static class PrayerRequestItem {
        public String id;
        public String content;
        
        public String title;
        public String request;
        public Date dateEntered; 

        public PrayerRequestItem(String id, String title, String content) 
        {
            this.id = id;
            this.title = title;
            this.request = content;
            
            this.dateEntered = new Date();
        }
        
        @Override
        public String toString() {
            return this.title;
        }
    }	
	
	
}
