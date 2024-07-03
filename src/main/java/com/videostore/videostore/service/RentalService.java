package com.videostore.videostore.service;

import com.videostore.videostore.model.Customer;
import com.videostore.videostore.model.Movie;
import com.videostore.videostore.model.Rental;
import com.videostore.videostore.repository.RentalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class RentalService {

    @Autowired
    private RentalRepository rentalRepository;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private MovieService movieService;

    public Rental createRental(Long customerId, Long movieId) {
        Customer customer = customerService.findById(customerId);
        Movie movie = movieService.getMovieById(movieId);

        if (movie == null || !movie.isAvailable()) {
            throw new RuntimeException("Movie is not available for rent.");
        }

        Rental rental = new Rental();
        rental.setCustomer(customer);
        rental.setMovie(movie);
        rental.setRentDate(LocalDate.now());

        movie.setAvailable(false); // Set movie as unavailable
        movieService.save(movie);

        return rentalRepository.save(rental);
    }

    public Rental endRental(Long rentalId) {
        Optional<Rental> rentalOpt = rentalRepository.findById(rentalId);

        if (rentalOpt.isEmpty()) {
            throw new RuntimeException("Rental not found.");
        }

        Rental rental = rentalOpt.get();
        rental.setReturnDate(LocalDate.now());

        Movie movie = rental.getMovie();
        movie.setAvailable(true); // Set movie as available
        movieService.save(movie);

        return rentalRepository.save(rental);
    }

    public void deleteRental(Long rentalId) {
        rentalRepository.deleteById(rentalId);
    }

    public Rental getRental(Long rentalId) {
        return rentalRepository.findById(rentalId).orElse(null);
    }

    public List<Rental> findAll() {
        return (List<Rental>) rentalRepository.findAll();
    }
}
