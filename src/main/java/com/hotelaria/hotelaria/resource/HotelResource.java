package com.hotelaria.hotelaria.resource;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.service.HotelService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/hoteis")
@RequiredArgsConstructor
public class HotelResource {

  private final HotelService hotelService;

  @GetMapping
  public ResponseEntity<List<Hotel>> retrieveAll() {
    return ResponseEntity.ok(hotelService.retrieveAll());
  }
}
