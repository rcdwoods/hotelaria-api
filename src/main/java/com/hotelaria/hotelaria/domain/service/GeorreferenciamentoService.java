package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Georreferenciamento;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.repository.GeorreferenciamentoRepository;
import com.hotelaria.hotelaria.domain.repository.RegistroImobiliarioRepository;
import io.swagger.model.GeorreferenciamentoRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
@RequiredArgsConstructor
public class GeorreferenciamentoService {
  private final GeorreferenciamentoRepository georreferenciamentoRepository;

  public Georreferenciamento create(GeorreferenciamentoRequest georreferenciamento) {
    georreferenciamentoRepository.insert(
      BigDecimal.valueOf(georreferenciamento.getLatitude()),
      BigDecimal.valueOf(georreferenciamento.getLongitude())
    );

    return georreferenciamentoRepository.retrieveLastCreated();
  }
}
