package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.service.AcomodacaoService;
import com.hotelaria.hotelaria.domain.service.HotelService;
import com.hotelaria.hotelaria.infra.mapper.AcomodacaoMapper;
import com.hotelaria.hotelaria.infra.mapper.HotelMapper;
import io.swagger.api.HoteisApi;
import io.swagger.model.DisponibilidadeResponse;
import io.swagger.model.HotelRequest;
import io.swagger.model.HotelResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

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
    Hotel createdHotel = hotelService.create(hotelRequest);
    return ResponseEntity.ok(hotelMapper.toResponse(createdHotel));
  }

  @Override
  @GetMapping
  public ResponseEntity<List<HotelResponse>> retrieveHotels() {
    List<Hotel> hoteisEncontrados = hotelService.retrieveAll();
    List<HotelResponse> hoteisConvertidos = hotelMapper.toResponse(hoteisEncontrados);
    return ResponseEntity.ok(hoteisConvertidos);
  }

  @GetMapping("/{id}/acomodacoes-disponiveis")
  public ResponseEntity<List<DisponibilidadeResponse>> retrieveAll(
    @PathVariable Long id,
    @RequestParam(name = "from") LocalDate from,
    @RequestParam(name = "to") LocalDate to
  ) {
    Map<LocalDate, List<Acomodacao>> acomodacoesEncontradas = acomodacaoService.
      retrieveAvailableFromHotelBetween(id, from, to);

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
