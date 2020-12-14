package com.cs336.pkg;

public class Reservation {
	
	String reservationNumber;
	String fareType;
	String dateMade;
	String totalFare;
	String reservationOrigin;
	String reservationOriginDatetime;
	String reservationDestination;
	String reservationDestinationDatetime;
	String customerUsername;
	String transitLine;
	String trainId;
	
	public Reservation (String reservationNumber, String fareType, String dateMade, String totalFare, String reservationOrigin, String reservationOriginDatetime,
			String reservationDestination, String reservationDestinationDatetime, String customerUsername, String transitLine, String trainId) {
		this.reservationNumber = reservationNumber;
		this.fareType = fareType;
		this.dateMade = dateMade;
		this.totalFare = totalFare;
		this.reservationOrigin = reservationOrigin;
		this.reservationOriginDatetime = reservationOriginDatetime;
		this.reservationDestination = reservationDestination;
		this.reservationDestinationDatetime = reservationDestinationDatetime;
		this.customerUsername = customerUsername;
		this.transitLine = transitLine;
		this.trainId = trainId;
	}

	public String getReservationNumber() {
		return reservationNumber;
	}

	public void setReservationNumber(String reservationNumber) {
		this.reservationNumber = reservationNumber;
	}

	public String getFareType() {
		return fareType;
	}

	public void setFareType(String fareType) {
		this.fareType = fareType;
	}

	public String getDateMade() {
		return dateMade;
	}

	public void setDateMade(String dateMade) {
		this.dateMade = dateMade;
	}

	public String getTotalFare() {
		return totalFare;
	}

	public void setTotalFare(String totalFare) {
		this.totalFare = totalFare;
	}

	public String getReservationOrigin() {
		return reservationOrigin;
	}

	public void setReservationOrigin(String reservationOrigin) {
		this.reservationOrigin = reservationOrigin;
	}

	public String getReservationDestination() {
		return reservationDestination;
	}

	public void setReservationDestination(String reservationDestination) {
		this.reservationDestination = reservationDestination;
	}

	public String getReservationDestinationDatetime() {
		return reservationDestinationDatetime;
	}

	public void setReservationDestinationDatetime(String reservationDestinationDatetime) {
		this.reservationDestinationDatetime = reservationDestinationDatetime;
	}

	public String getCustomerUsername() {
		return customerUsername;
	}

	public void setCustomerUsername(String customerUsername) {
		this.customerUsername = customerUsername;
	}

	public String getTransitLine() {
		return transitLine;
	}

	public void setTransitLine(String transitLine) {
		this.transitLine = transitLine;
	}

	public String getTrainId() {
		return trainId;
	}

	public void setTrainId(String trainId) {
		this.trainId = trainId;
	}

	@Override
	public String toString() {
		return "Reservations [reservationNumber=" + reservationNumber + ", fareType=" + fareType + ", dateMade="
				+ dateMade + ", totalFare=" + totalFare + ", reservationOrigin=" + reservationOrigin
				+ ", reservationDestination=" + reservationDestination + ", reservationDestinationDatetime="
				+ reservationDestinationDatetime + ", customerUsername=" + customerUsername + ", transitLine="
				+ transitLine + ", trainId=" + trainId + "]";
	}

	public String getReservationOriginDatetime() {
		return reservationOriginDatetime;
	}

	public void setReservationOriginDatetime(String reservationOriginDatetime) {
		this.reservationOriginDatetime = reservationOriginDatetime;
	}
	
	
}