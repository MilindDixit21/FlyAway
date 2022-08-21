package com.flyaway.table;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="tbl_flights")
public class Flights {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int flight_id;
	private String flightNo;
	private String departCity;
	private String arriveCity;
	private double price;
	private String airlineName;
	private int capacity;
	private String date;
	
	@OneToMany(mappedBy="flight",cascade=CascadeType.ALL)
	private List<FlightRegistry> flights; 
	
	public Flights() {
		super();
	}


	public Flights(String flightNo, String departCity, String arriveCity, double price, String airlineName,
			int capacity, String date) {
		super();
		this.flightNo = flightNo;
		this.departCity = departCity;
		this.arriveCity = arriveCity;
		this.price = price;
		this.airlineName = airlineName;
		this.capacity = capacity;
		this.date = date;
		flights = new ArrayList<FlightRegistry>();
	}
	
	public List<FlightRegistry> getFlights() {
		return flights;
	}

	public void setFlightRegistry(FlightRegistry flight) {
		flights.add(flight);
	}

	public String getFlightNo() {
		return flightNo;
	}

	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}

	public String getDepartCity() {
		return departCity;
	}

	public void setDepartCity(String departCity) {
		this.departCity = departCity;
	}

	public String getArriveCity() {
		return arriveCity;
	}

	public void setArriveCity(String arriveCity) {
		this.arriveCity = arriveCity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getAirlineName() {
		return airlineName;
	}

	public void setAirlineName(String airlineName) {
		this.airlineName = airlineName;
	}

	public int getFlight_id() {
		return flight_id;
	}
	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	
	
}
	