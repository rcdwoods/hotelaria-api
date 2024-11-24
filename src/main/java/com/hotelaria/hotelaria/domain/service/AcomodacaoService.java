package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import com.hotelaria.hotelaria.domain.exception.AcomodacaoNotFoundException;
import com.hotelaria.hotelaria.domain.repository.AcomodacaoRepository;
import io.swagger.model.AcomodacaoRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AcomodacaoService {
  private final AcomodacaoRepository acomodacaoRepository;
  private final PoliticaDeUsoService politicaDeUsoService;

  public Map<LocalDate, List<Acomodacao>> retrieveAvailabilityFromHotelBetween(Long hotelId, LocalDate from, LocalDate to) {
    Set<LocalDate> dateInterval = extractInterval(from, to);

    return dateInterval.stream()
      .map(date -> Map.entry(date, retrieveAvailableBetweenFromHotel(hotelId, from, to)))
      .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
  }

  private List<Acomodacao> retrieveAvailableBetweenFromHotel(Long hotelId, LocalDate from, LocalDate to) {
    LocalDateTime dateFrom = from.atStartOfDay();
    LocalDateTime dateTo = to.atTime(23, 59, 59);

    return acomodacaoRepository.retrieveAllAvailableBetween(hotelId, dateFrom, dateTo).stream()
      .peek(acomodacao -> {
        List<PoliticaDeUso> politicasDeUso = politicaDeUsoService.retrieveAllByAcomodacaoFromHotel(acomodacao.getAcomodacaoId().getNumero(), hotelId);
        acomodacao.setPoliticasDeUso(politicasDeUso);
      }).collect(Collectors.toList());
  }

  public Acomodacao retrieveByNumeroAndHotelId(Long numero, Long hotelId) {
    Acomodacao acomodacaoFound = acomodacaoRepository.retrieveByNumeroAndHotel(numero, hotelId)
      .orElseThrow(() -> new AcomodacaoNotFoundException(numero));

    acomodacaoFound.setPoliticasDeUso(politicaDeUsoService.retrieveAllByAcomodacaoFromHotel(acomodacaoFound.getAcomodacaoId().getNumero(), hotelId));

    return acomodacaoFound;
  }

  public List<Acomodacao> retrieveAllByHotel(Long hotelId) {
    return acomodacaoRepository.retrieveAllByHotelId(hotelId).stream().map(acomodacao -> {
      acomodacao.setPoliticasDeUso(politicaDeUsoService.retrieveAllByAcomodacaoFromHotel(acomodacao.getAcomodacaoId().getNumero(), hotelId));
      return acomodacao;
    }).collect(Collectors.toList());
  }

  @Transactional
  public void create(AcomodacaoRequest acomodacao, Long hotelId) {
    acomodacaoRepository.insert(
      acomodacao.getNumero(),
      hotelId,
      BigDecimal.valueOf(acomodacao.getValorDiaria()),
      acomodacao.getTipo().toString(),
      acomodacao.getCapacidade()
    );

    attachPoliticasDeUso(acomodacao.getNumero(), hotelId, acomodacao.getPoliticasDeUso());
  }

  private void attachPoliticasDeUso(Long numeroAcomodacao, Long hotelId, List<Long> politicasDeUso) {
    politicasDeUso.forEach(politicaDeUso -> {
      if (!politicaDeUsoService.existsById(politicaDeUso)) {
        throw new IllegalArgumentException("Politica de uso não existe");
      }

      acomodacaoRepository.attachPoliticaDeUsoToAcomodacao(numeroAcomodacao, hotelId, politicaDeUso);
    });
  }

  @Transactional
  public void removeAllFromHotel(Long hotelId) {
    politicaDeUsoService.removeAllFromHotel(hotelId);
    acomodacaoRepository.deleteAllByHotelId(hotelId);
  }

  private Set<LocalDate> extractInterval(LocalDate from, LocalDate to) {
    Set<LocalDate> dates = new HashSet<>();
    dates.add(from);

    LocalDate currentDate = from.plusDays(1);
    while (currentDate.isBefore(to) || currentDate.isEqual(to)) {
      dates.add(currentDate);
      currentDate = currentDate.plusDays(1);
    }

    return dates;
  }
}
