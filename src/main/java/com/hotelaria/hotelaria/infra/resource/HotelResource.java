package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.service.AcomodacaoService;
import com.hotelaria.hotelaria.domain.service.HotelService;
import com.hotelaria.hotelaria.infra.mapper.AcomodacaoMapper;
import com.hotelaria.hotelaria.infra.mapper.HotelMapper;
import io.swagger.annotations.Api;
import io.swagger.api.HoteisApi;
import io.swagger.model.DisponibilidadeResponse;
import io.swagger.model.HotelRequest;
import io.swagger.model.HotelResponse;
import io.swagger.model.UpdateHotelRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

@Api(tags = "hoteis")
@RestController
@RequestMapping("/hoteis")
@RequiredArgsConstructor
public class HotelResource implements HoteisApi {

  private final HotelService hotelService;
  private final HotelMapper hotelMapper;
  private final AcomodacaoMapper acomodacaoMapper;
  private final AcomodacaoService acomodacaoService;

  @Override
  @PostMapping
  public ResponseEntity<HotelResponse> createHotel(@RequestBody HotelRequest hotelRequest) {
    hotelService.create(hotelRequest);
    Hotel createdHotel = hotelService.retrieveLastCreated();
    return ResponseEntity.ok(hotelMapper.toResponse(createdHotel));
  }

  @Override
  @PutMapping("/{hotelId}")
  public ResponseEntity<Void> updateHotel(@PathVariable Long hotelId, @RequestBody UpdateHotelRequest body) {
    hotelService.update(hotelId, body);
    return ResponseEntity.ok().build();
  }

  @Override
  @DeleteMapping("/{hotelId}")
  public ResponseEntity<Void> removeHotel(@PathVariable Long hotelId) {
    hotelService.remove(hotelId);
    return ResponseEntity.noContent().build();
  }

  @Override
  @GetMapping("/{hotelId}")
  public ResponseEntity<HotelResponse> retrieveHotelById(@PathVariable Long hotelId) {
    Hotel hotelEncontrado = hotelService.retrieveById(hotelId);
    return ResponseEntity.ok(hotelMapper.toResponse(hotelEncontrado));
  }

  @Override
  @GetMapping
  public ResponseEntity<List<HotelResponse>> retrieveHotels() {
    List<Hotel> hoteisEncontrados = hotelService.retrieveAll();
    List<HotelResponse> hoteisConvertidos = hotelMapper.toResponse(hoteisEncontrados);
    return ResponseEntity.ok(hoteisConvertidos);
  }

  @Override
  @GetMapping("/{id}/acomodacoes-disponiveis")
  public ResponseEntity<List<DisponibilidadeResponse>> retrieveDisponibilidade(
    @PathVariable Long id,
    @RequestParam(name = "from") String from,
    @RequestParam(name = "to") String to
  ) {
    Map<LocalDate, List<Acomodacao>> acomodacoesEncontradas = acomodacaoService.
      retrieveAvailabilityFromHotelBetween(id, LocalDate.parse(from), LocalDate.parse(to));

    return ResponseEntity.ok(toDisponibilidadeResponse(acomodacoesEncontradas));
  }

  private List<DisponibilidadeResponse> toDisponibilidadeResponse(Map<LocalDate, List<Acomodacao>> acomodacoesDisponiveis) {
    List<DisponibilidadeResponse> disponibilidadeAcomodacoes = new ArrayList<>();

    acomodacoesDisponiveis.forEach((data, acomodacoes) -> {
      DisponibilidadeResponse disponibilidadeResponse = new DisponibilidadeResponse();
      disponibilidadeResponse.setData(data.toString());
      disponibilidadeResponse.setQuantidadeDisponivel(acomodacoes.size());
      disponibilidadeResponse.setAcomodacoesDisponiveis(acomodacaoMapper.toResponse(acomodacoes));
      disponibilidadeAcomodacoes.add(disponibilidadeResponse);
    });

    disponibilidadeAcomodacoes.sort(Comparator.comparing(DisponibilidadeResponse::getData));

    return disponibilidadeAcomodacoes;
  }
}
