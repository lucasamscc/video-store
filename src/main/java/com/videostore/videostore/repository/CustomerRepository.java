package com.videostore.videostore.repository;

import com.videostore.videostore.model.Customer;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface CustomerRepository extends Neo4jRepository<Customer, Long> {
}
