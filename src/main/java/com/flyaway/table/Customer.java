package com.flyaway.table;


import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="tbl_customers")
public class Customer {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int customer_Id;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private Date dateOfBirth;
	private String st_address;
	private int age;
	private String gender;
	private String id_type;
	private String id_num;
	private Date id_exp_date;
	
	@OneToMany(mappedBy="customer",cascade=CascadeType.ALL)
	private List<FlightRegistry> customers;
	
	public Customer() {
		super();
	}

	public Customer(String firstName, String lastName, String email, String password, Date dateOfBirth, String st_address, String gender,
			String id_type, String id_num, Date id_exp_date) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.dateOfBirth = dateOfBirth;
		this.st_address = st_address;
		this.age =  setAge(dateOfBirth);
		this.gender = gender;
		this.id_type = id_type;
		this.id_num = id_num;
		this.id_exp_date = id_exp_date;
		customers= new ArrayList<FlightRegistry>();
	}
	
	public void setFlightRegistry(FlightRegistry customer) {
		customers.add(customer);
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getSt_address() {
		return st_address;
	}

	public void setSt_address(String st_address) {
		this.st_address = st_address;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getId_type() {
		return id_type;
	}

	public void setId_type(String id_type) {
		this.id_type = id_type;
	}

	public String getId_num() {
		return id_num;
	}

	public void setId_num(String id_num) {
		this.id_num = id_num;
	}

	public Date getId_Exp_date() {
		return id_exp_date;
	}

	public void setId_Exp_date(Date exp_date) {
		this.id_exp_date = exp_date;
	}

	public int getCustomer_Id() {
		return customer_Id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	private static int setAge(Date dateOfBirth) {
		//code copied from: https://www.tutorialspoint.com/how-to-find-the-age-when-date-of-birth-is-known-using-java
	    //Converting obtained Date object to LocalDate object
	    Instant instant = dateOfBirth.toInstant();
	    ZonedDateTime zone = instant.atZone(ZoneId.systemDefault());
	    LocalDate givenDate = zone.toLocalDate();
	    //Calculating the difference between given date to current date.
	    Period period = Period.between(givenDate, LocalDate.now());
	    int age = period.getYears();
	    return age;
	}
}
	
