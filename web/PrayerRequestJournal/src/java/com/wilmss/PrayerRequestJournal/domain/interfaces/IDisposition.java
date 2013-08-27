/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wilmss.PrayerRequestJournal.domain.interfaces;

import java.io.Serializable;

/**
 *
 * @author wilsonr1
 */
public interface IDisposition extends Serializable {

    String getDisposition();

    int getDispositionId();

    void setDisposition(String disposition);

    void setDispositionId(int dispositionId);
    
}
