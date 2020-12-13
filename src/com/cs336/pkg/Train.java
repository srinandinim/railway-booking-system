package com.cs336.pkg;

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

	public String toString() {
		return transitLine + " " + trainId + " " + origin + " " + destination;
	}
}
