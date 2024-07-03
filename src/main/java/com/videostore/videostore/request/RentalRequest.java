package com.videostore.videostore.request;

import lombok.Data;

@Data
public class RentalRequest {
    private Long customerId;
    private Long movieId;
}
