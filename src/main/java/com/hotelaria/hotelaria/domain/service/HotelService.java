package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.repository.HotelRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HotelService {
  private final HotelRepository hotelRepository;

  public List<Hotel> retrieveAll() {
    return hotelRepository.findAll();
  }
}
