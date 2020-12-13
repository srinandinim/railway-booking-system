package com.cs336.pkg;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Train {
	
	String transitLine;
	int trainId;
	String origin;
	String destination;
	String stops;
	int fare;
	
	public Train (String line, int id, String org, String dep) {
		transitLine = line;
		trainId = id;
		origin = org;
		destination = dep;
		stops = "";
		fare = 0;
	}
	
	public String getTransitLine() {
		return transitLine;
	}
	public void setTransitLine(String transitLine) {
		this.transitLine = transitLine;
	}
	public int getTrainId() {
		return trainId;
	}
	public void setTrainId(int train_id) {
		this.trainId = train_id;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getStops() {
		return stops;
	}
	public void setStops(String stops) {
		this.stops = stops;
	}
	public int getFare() {
		return fare;
	}
	public void setFare(int fare) {
		this.fare = fare;
	}
	
	public long getDuration() {
		String time1 = origin.split(" ")[1];
		String time2 = destination.split(" ")[1];
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
		try {
			Date date1 = format.parse(time1);
			Date date2 = format.parse(time2);
			long difference = date2.getTime() - date1.getTime(); 
			return (long) Math.ceil((difference/60000));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public String toString() {
		return transitLine + " " + trainId + " " + origin + " " + destination;
	}
}
