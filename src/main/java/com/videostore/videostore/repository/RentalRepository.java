package com.videostore.videostore.repository;

import com.videostore.videostore.model.Rental;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface RentalRepository extends Neo4jRepository<Rental, Long> {
}
