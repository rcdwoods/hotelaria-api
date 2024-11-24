package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.domain.service.HospedeService;
import com.hotelaria.hotelaria.domain.service.ReservaAcomodacaoService;
import com.hotelaria.hotelaria.infra.mapper.HospedeMapper;
import com.hotelaria.hotelaria.infra.mapper.ReservaAcomodacaoMapper;

import javax.validation.Valid;

import io.swagger.annotations.Api;
import io.swagger.api.HospedesApi;
import io.swagger.model.HospedeRequest;
import io.swagger.model.HospedeResponse;
import io.swagger.model.ReservaAcomodacaoResponse;
import io.swagger.model.SolicitacaoReservaRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "hospedes")
@RestController
@RequiredArgsConstructor
@RequestMapping("/hospedes")
public class HospedeResource implements HospedesApi {
  private final HospedeService hospedeService;
  private final HospedeMapper hospedeMapper;
  private final ReservaAcomodacaoService reservaAcomodacaoService;
  private final ReservaAcomodacaoMapper reservaAcomodacaoMapper;

  @Override
  @GetMapping
  public ResponseEntity<List<HospedeResponse>> retrieveHospedes() {
    List<Hospede> hospedes = hospedeService.retrieveAll();
    return ResponseEntity.ok(hospedeMapper.toResponse(hospedes));
  }

  @GetMapping("/{id}/reservas")
  public ResponseEntity<List<ReservaAcomodacaoResponse>> retrieveReservasFromHospede(@PathVariable(name = "id") Long hospedeId) {
    List<ReservaAcomodacao> reservas = reservaAcomodacaoService.retrieveReservasFromHospede(hospedeId);
    return ResponseEntity.ok(reservaAcomodacaoMapper.toResponse(reservas));
  }

  @Override
  @GetMapping("/{hospedeId}")
  public ResponseEntity<HospedeResponse> retrieveHospedeById(@PathVariable Long hospedeId) {
    Hospede hospede = hospedeService.retrieveById(hospedeId);
    return ResponseEntity.ok(hospedeMapper.toResponse(hospede));
  }

  @Override
  @PostMapping("/{id}/reservas")
  public ResponseEntity<ReservaAcomodacaoResponse> makeReservation(@RequestBody @Valid SolicitacaoReservaRequest solicitacaoReserva) {
    ReservaAcomodacao reservaAcomodacao = reservaAcomodacaoService.makeReservation(solicitacaoReserva);
    ReservaAcomodacaoResponse response = reservaAcomodacaoMapper.toResponse(reservaAcomodacao);
    return ResponseEntity.ok(response);
  }

  @Override
  @PostMapping
  public ResponseEntity<HospedeResponse> createHospede(@RequestBody HospedeRequest body) {
    Hospede createdHospede = hospedeService.create(body);
    return ResponseEntity.ok(hospedeMapper.toResponse(createdHospede));
  }

  @Override
  @PutMapping("/{hospedeId}")
  public ResponseEntity<Void> updateHospede(@PathVariable Long hospedeId, @RequestBody HospedeRequest body) {
    hospedeService.update(hospedeId, body);
    return ResponseEntity.ok().build();
  }

  @Override
  @DeleteMapping("/{hospedeId}")
  public ResponseEntity<Void> removeHospede(Long hospedeId) {
    hospedeService.remove(hospedeId);
    return ResponseEntity.noContent().build();
  }
}
