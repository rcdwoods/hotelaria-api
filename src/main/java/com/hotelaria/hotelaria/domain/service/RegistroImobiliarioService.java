package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Georreferenciamento;
import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.repository.HotelRepository;
import com.hotelaria.hotelaria.domain.repository.RegistroImobiliarioRepository;
import io.swagger.model.RegistroImobiliarioRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RegistroImobiliarioService {
  private final RegistroImobiliarioRepository registroImobiliarioRepository;
  private final GeorreferenciamentoService georreferenciamentoService;

  public RegistroImobiliario create(RegistroImobiliarioRequest registroImobiliario) {
    Georreferenciamento georreferenciamento = georreferenciamentoService.create(registroImobiliario.getGeorreferenciamento());

    registroImobiliarioRepository.insert(
      registroImobiliario.getNumeroRegistroPrefeitura(),
      registroImobiliario.getDataRegistro(),
      georreferenciamento.getId()
    );

    return registroImobiliarioRepository.retrieveLastCreated();
  }
}
