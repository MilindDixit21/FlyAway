package com.flyaway.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class HibernateUtil {
	
	private static SessionFactory sessionFactory;
	
	static {
		
		try {
			
		StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();
		Metadata metadata = new MetadataSources(ssr).getMetadataBuilder().build();
		sessionFactory = metadata.getSessionFactoryBuilder().build();
		
		} catch (Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}
	
	public static SessionFactory getsessionFactory() {
		return sessionFactory;
	}
	
}
