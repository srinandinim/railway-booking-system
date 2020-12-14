package com.cs336.pkg;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Train {
	
	String transitLine;
	int trainId;
	int origin;
	int destination;
	String originDT;
	String destinationDT;
	String stops;
	double fare;
	
	public Train(String transitLine, int trainId, int origin, int destination, String originDT, String destinationDT) {
		super();
		this.transitLine = transitLine;
		this.trainId = trainId;
		this.origin = origin;
		this.destination = destination;
		this.originDT = originDT;
		this.destinationDT = destinationDT;
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
	public String getOriginDT() {
		return originDT;
	}
	public void getOriginDT(String originDT) {
		this.originDT = originDT;
	}
	public String getDestinationDT() {
		return destinationDT;
	}
	public void setDestinationDT(String destinationDT) {
		this.destinationDT = destinationDT;
	}
	public String getStops() {
		return stops;
	}
	public void setStops(String stops) {
		this.stops = stops;
	}
	public double getFare() {
		return fare;
	}
	public void setFare(double fare) {
		this.fare = fare;
	}
	
	public long getDuration() {
		String time1 = originDT.split(" ")[1];
		String time2 = destinationDT.split(" ")[1];
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
		return transitLine + "//" + trainId + "//" + origin + "//" + originDT + "//" + destination + "//" + destinationDT + "//" + fare;
	}
}
