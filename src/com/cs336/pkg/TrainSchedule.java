package com.cs336.pkg;

public class TrainSchedule {
	String transitLine;
	String departureDatetime;
	String arrivalDatetime;
	String fare;
	String originStationID;
	String destinationStationID;
	String trainID;

	public TrainSchedule(String transitLine, String departureDatetime, String arrivalDatetime, String fare,
			String originStationID, String destinationStationID, String trainID) {
		this.transitLine = transitLine;
		this.departureDatetime = departureDatetime;
		this.arrivalDatetime = arrivalDatetime;
		this.fare = fare;
		this.originStationID = originStationID;
		this.destinationStationID = destinationStationID;
		this.trainID = trainID;
	}

	public String getTransitLine() {
		return transitLine;
	}

	public void setTransitLine(String transitLine) {
		this.transitLine = transitLine;
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

	public String getFare() {
		return fare;
	}

	public void setFare(String fare) {
		this.fare = fare;
	}

	public String getOriginStationID() {
		return originStationID;
	}

	public void setOriginStationID(String originStationID) {
		this.originStationID = originStationID;
	}

	public String getDestinationStationID() {
		return destinationStationID;
	}

	public void setDestinationStationID(String destinationStationID) {
		this.destinationStationID = destinationStationID;
	}

	public String getTrainID() {
		return trainID;
	}

	public void setTrainID(String trainID) {
		this.trainID = trainID;
	}
	
}
