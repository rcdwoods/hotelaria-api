package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HotelRepository extends JpaRepository<Hotel, Long> {
}
