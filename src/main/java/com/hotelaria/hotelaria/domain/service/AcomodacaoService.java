package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.repository.AcomodacaoRepository;
import io.swagger.model.AcomodacaoRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AcomodacaoService {
  private final AcomodacaoRepository acomodacaoRepository;

  public Map<LocalDate, List<Acomodacao>> retrieveAvailableFromHotelBetween(Long hotelId, LocalDate from, LocalDate to) {
    Set<LocalDate> dateInterval = extractInterval(from, to);

    return dateInterval.stream().map(date -> {
      LocalDateTime dateFrom = date.atStartOfDay();
      LocalDateTime dateTo = date.atTime(23, 59, 59);

      return Map.entry(date, acomodacaoRepository.retrieveAllAvailableBetween(hotelId, dateFrom, dateTo));
    }).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
  }

  public Optional<Acomodacao> retrieveByHotelAndNumber(Long hotelId, Long number) {
    return acomodacaoRepository.retrieveByHotelIdAndNumber(hotelId, number);
  }

  public Acomodacao create(AcomodacaoRequest acomodacao, Long hotelId) {
    acomodacaoRepository.insert(
      acomodacao.getNumero(),
      hotelId,
      BigDecimal.valueOf(acomodacao.getValorDiaria()),
      acomodacao.getTipo().toString(),
      acomodacao.getCapacidade()
    );
    return acomodacaoRepository.retrieveByHotelIdAndNumber(hotelId, acomodacao.getNumero()).get();
  }

  public void removeAllByHotelId(Long hotelId) {
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
