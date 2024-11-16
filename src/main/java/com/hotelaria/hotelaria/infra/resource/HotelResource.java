package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.service.HotelService;
import com.hotelaria.hotelaria.infra.mapper.HotelMapper;
import com.hotelaria.hotelaria.infra.resource.dto.HotelResponse;
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
  private final HotelMapper hotelMapper;

  @GetMapping
  public ResponseEntity<List<HotelResponse>> retrieveAll() {
    List<Hotel> hoteisEncontrados = hotelService.retrieveAll();
    List<HotelResponse> hoteisConvertidos = hotelMapper.toResponse(hoteisEncontrados);
    return ResponseEntity.ok(hoteisConvertidos);
  }
}
