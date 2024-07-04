package com.videostore.videostore.controller;

import org.neo4j.driver.types.MapAccessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.neo4j.driver.Result;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/reports")
public class ReportController {

    @Autowired
    private Driver driver;

    @GetMapping("/old-movies")
    public List<Map<String, Object>> getOldMovies() {
        try (Session session = driver.session()) {
            String query = "MATCH (m:Movie) " +
                    "WHERE m.year <= date().year - 10 " +
                    "RETURN m.title AS Movie, m.year AS Year";
            Result result = session.run(query);
            return result.list(MapAccessor::asMap);
        }
    }

    @GetMapping("/rental-history")
    public List<Map<String, Object>> getRentalHistory() {
        try (Session session = driver.session()) {
            String query = "MATCH (r:Rental)-[:RENTED_BY]->(c:Customer), (r)-[:RENTS]->(m:Movie) " +
                    "RETURN r.id AS RentalId, c.name AS Customer, m.title AS Movie, r.rentDate AS RentDate, r.returnDate AS ReturnDate " +
                    "ORDER BY r.rentDate DESC";
            Result result = session.run(query);
            return result.list(MapAccessor::asMap);
        }
    }

    @GetMapping("/currently-rented-movies")
    public List<Map<String, Object>> getCurrentlyRentedMovies() {
        try (Session session = driver.session()) {
            String query = "MATCH (r:Rental)-[:RENTS]->(m:Movie) " +
                    "WHERE r.returnDate IS NULL " +
                    "RETURN m.title AS MovieTitle, m.genre AS Genre, m.year AS Year, m.director AS Director ";

            Result result = session.run(query);
            return result.list(MapAccessor::asMap);
        }
    }
}
