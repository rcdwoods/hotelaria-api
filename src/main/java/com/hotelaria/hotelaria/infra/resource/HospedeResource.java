package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.service.HospedeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/hospedes")
public class HospedeResource {
  private final HospedeService hospedeService;

  @GetMapping
  public ResponseEntity<List<Hospede>> retrieveAll() {
    return ResponseEntity.ok(hospedeService.retrieveAll());
  }
}
