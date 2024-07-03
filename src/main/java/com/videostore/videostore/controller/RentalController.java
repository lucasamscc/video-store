package com.videostore.videostore.controller;

import com.videostore.videostore.model.Rental;
import com.videostore.videostore.request.RentalRequest;
import com.videostore.videostore.service.RentalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rentals")
public class RentalController {

    @Autowired
    private RentalService rentalService;

    @GetMapping
    public List<Rental> findAll() {
        return rentalService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Rental> findById(@PathVariable Long id) {
        Rental rental = rentalService.getRental(id);
        return rental != null ? ResponseEntity.ok(rental) : ResponseEntity.notFound().build();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Rental createRental(@RequestBody RentalRequest rentalRequest) {
        return rentalService.createRental(rentalRequest.getCustomerId(), rentalRequest.getMovieId());
    }

    @PutMapping("/{rentalId}/end")
    public Rental endRental(@PathVariable Long rentalId) {
        return rentalService.endRental(rentalId);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id) {
        rentalService.deleteRental(id);
        return ResponseEntity.noContent().build();
    }
}
