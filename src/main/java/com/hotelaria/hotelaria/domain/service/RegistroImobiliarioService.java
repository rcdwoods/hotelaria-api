package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Georreferenciamento;
import com.hotelaria.hotelaria.domain.entity.RegistroImobiliario;
import com.hotelaria.hotelaria.domain.exception.RegistroImobiliarioNotFoundException;
import com.hotelaria.hotelaria.domain.repository.RegistroImobiliarioRepository;
import io.swagger.model.RegistroImobiliarioRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

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

  @Transactional
  public void removeById(Long id) {
    Optional<RegistroImobiliario> registroImobiliario = registroImobiliarioRepository.retrieveById(id);
    if (registroImobiliario.isEmpty()) {
      throw new RegistroImobiliarioNotFoundException(id);
    }

    RegistroImobiliario registroImobiliarioEncontrado = registroImobiliario.get();

    registroImobiliarioRepository.deleteRegistroById(id);
    georreferenciamentoService.removeById(registroImobiliarioEncontrado.getGeorreferenciamento().getId());
  }
}
