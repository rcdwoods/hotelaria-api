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

  public List<PoliticaDeUso> retrieveAll() {
    return politicaDeUsoRepository.retrieveAll();
  }
}
