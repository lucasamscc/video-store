package com.videostore.videostore.model;

import lombok.Data;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;

@Data
@Node
public class Movie {
    @Id
    @GeneratedValue
    private Long id;
    private String title;
    private String genre;
    private int year;
    private String director;
    private boolean available;
}
