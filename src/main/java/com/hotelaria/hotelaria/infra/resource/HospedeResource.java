package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.domain.service.HospedeService;
import com.hotelaria.hotelaria.domain.service.ReservaAcomodacaoService;
import com.hotelaria.hotelaria.infra.mapper.ReservaAcomodacaoMapper;

import javax.validation.Valid;

import io.swagger.model.ReservaAcomodacaoResponse;
import io.swagger.model.SolicitacaoReservaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/hospedes")
public class HospedeResource {
  private final HospedeService hospedeService;
  private final ReservaAcomodacaoService reservaAcomodacaoService;
  private final ReservaAcomodacaoMapper reservaAcomodacaoMapper;

  @GetMapping
  public ResponseEntity<List<Hospede>> retrieveAll() {
    return ResponseEntity.ok(hospedeService.retrieveAll());
  }

  @GetMapping("/{id}/reservas")
  public ResponseEntity<List<ReservaAcomodacaoResponse>> retrieveReservasFromHospede(@PathVariable(name = "id") Long hospedeId) {
    List<ReservaAcomodacao> reservas = reservaAcomodacaoService.retrieveReservasFromHospede(hospedeId);
    return ResponseEntity.ok(reservaAcomodacaoMapper.toResponse(reservas));
  }

  @PostMapping("/{id}/reservas")
  public ResponseEntity<ReservaAcomodacaoResponse> makeReserva(@RequestBody @Valid SolicitacaoReservaRequest solicitacaoReserva) {
    ReservaAcomodacao reservaAcomodacao = reservaAcomodacaoService.makeReservation(solicitacaoReserva);
    ReservaAcomodacaoResponse response = reservaAcomodacaoMapper.toResponse(reservaAcomodacao);
    return ResponseEntity.ok(response);
  }
}
