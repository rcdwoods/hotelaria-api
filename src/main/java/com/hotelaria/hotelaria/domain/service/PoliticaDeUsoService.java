package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.PoliticaDeUso;
import com.hotelaria.hotelaria.domain.repository.PoliticaDeUsoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PoliticaDeUsoService {
  private final PoliticaDeUsoRepository politicaDeUsoRepository;

  public PoliticaDeUso create(PoliticaDeUso politicaDeUso) {
    politicaDeUsoRepository.insert(politicaDeUso.getNome(), politicaDeUso.getDescricao());
    return politicaDeUsoRepository.retrieveLastCreated();
  }

  public void removeAllFromHotel(Long hotelId) {
    politicaDeUsoRepository.removeAllFromHotel(hotelId);
  }

  public boolean existsById(Long politicaDeUsoId) {
    return politicaDeUsoRepository.existsById(politicaDeUsoId);
  }

  public List<PoliticaDeUso> retrieveAllByAcomodacaoFromHotel(Long acomodacaoId, Long hotelId) {
    return politicaDeUsoRepository.retrieveAllByAcomodacaoFromHotel(acomodacaoId, hotelId);
  }
}
