package com.hotelaria.hotelaria.infra.resource;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.service.AcomodacaoService;
import com.hotelaria.hotelaria.domain.service.HotelService;
import com.hotelaria.hotelaria.infra.mapper.AcomodacaoMapper;
import com.hotelaria.hotelaria.infra.mapper.HotelMapper;
import com.hotelaria.hotelaria.infra.resource.dto.DisponibilidadeResponse;
import com.hotelaria.hotelaria.infra.resource.dto.HotelResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

@RestController
@RequestMapping("/hoteis")
@RequiredArgsConstructor
public class HotelResource {

  private final HotelService hotelService;
  private final HotelMapper hotelMapper;
  private final AcomodacaoMapper acomodacaoMapper;
  private final AcomodacaoService acomodacaoService;

  @GetMapping
  public ResponseEntity<List<HotelResponse>> retrieveAll() {
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
      disponibilidadeResponse.setData(data);
      disponibilidadeResponse.setQuantidadeDisponivel(acomodacoes.size());
      disponibilidadeResponse.setAcomodacoesDisponiveis(acomodacaoMapper.toResponse(acomodacoes));
      disponibilidadeAcomodacoes.add(disponibilidadeResponse);
    });

    disponibilidadeAcomodacoes.sort(Comparator.comparing(DisponibilidadeResponse::getData));

    return disponibilidadeAcomodacoes;
  }
}
