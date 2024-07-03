package com.videostore.videostore.model;

import lombok.Data;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

import java.time.LocalDate;

@Data
@Node
public class Rental {
    @Id
    @GeneratedValue
    private Long id;
    private LocalDate rentDate;
    private LocalDate returnDate;

    @Relationship(type = "RENTED_BY", direction = Relationship.Direction.OUTGOING)
    private Customer customer;

    @Relationship(type = "RENTS", direction = Relationship.Direction.OUTGOING)
    private Movie movie;
}
