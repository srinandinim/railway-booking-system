package com.cs336.pkg;

public class TrainSchedule {
	String transitLine;
	String trainID;
	String stopID;
	String destinationID;
	String originID;
	String departureDatetime;
	String arrivalDatetime;



	public TrainSchedule(String transitLine, String trainID, String stopID, String originID,
			String destinationID, String departureDatetime, String arrivalDatetime) {
		this.transitLine = transitLine;
		this.trainID = trainID;
		this.stopID = stopID;
		this.originID = originID;
		this.destinationID = destinationID;
		this.departureDatetime = departureDatetime;
		this.arrivalDatetime = arrivalDatetime;
	}

	public String getTransitLine() {
		return transitLine;
	}

	public void setTransitLine(String transitLine) {
		this.transitLine = transitLine;
	}
	
	public String gettrainID() {
		return trainID;
	}
	public void settrainID(String trainID) {
		this.trainID = trainID;
	}
	
	public String getstopID() {
		return stopID;
	}

	public void setstopID(String stopID) {
		this.stopID = stopID;
	}
	
	public String getOriginID() {
		return originID;
	}

	public void setOriginID(String originID) {
		this.originID = originID;
	}
	
	public String getDestinationID() {
		return destinationID;
	}

	public void setDestinationID(String destinationID) {
		this.destinationID = destinationID;
	}
	

	public String getDepartureDatetime() {
		return departureDatetime;
	}

	public void setDepartureDatetime(String departureDatetime) {
		this.departureDatetime = departureDatetime;
	}

	public String getArrivalDatetime() {
		return arrivalDatetime;
	}

	public void setArrivalDatetime(String arrivalDatetime) {
		this.arrivalDatetime = arrivalDatetime;
	}

	
	public String getTrainID() {
		return trainID;
	}

	public void setTrainID(String trainID) {
		this.trainID = trainID;
	}
	
}
