package com.wilmss.android.PRJ2.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Helper class for providing sample content for user interfaces created by
 * Android template wizards.
 * <p>
 * TODO: Replace all uses of this class before publishing your app.
 */
public class PrayerRequestRepository {

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
        addItem(new PrayerRequestItem("3", "Rain", "Rain for crops"));
        addItem(new PrayerRequestItem("4", "Spelling Bee", "Good showing at spelling bee"));
        addItem(new PrayerRequestItem("5", "Audi", "Pray to get a brand new Audi"));
        addItem(new PrayerRequestItem("6", "House", "House"));
        addItem(new PrayerRequestItem("7", "Lose Weight", "Loose 30 lbs"));
        addItem(new PrayerRequestItem("8", "Bills", "Help with Bills"));
        addItem(new PrayerRequestItem("9", "Trip", "Safe travels"));
        addItem(new PrayerRequestItem("10", "Business", "Successful business venture"));
    }

    private static void addItem(PrayerRequestItem item) {
        ITEMS.add(item);
        ITEM_MAP.put(item.id, item);
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
