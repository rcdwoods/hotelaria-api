package com.hotelaria.hotelaria.domain.service;

import com.hotelaria.hotelaria.domain.entity.Hospede;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import com.hotelaria.hotelaria.domain.repository.HospedeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HospedeService {
  private final HospedeRepository hospedeRepository;

  public List<Hospede> retrieveAll() {
    return hospedeRepository.findAll();
  }

  public Optional<Hospede> retrieveById(Long hospedeId) {
    return hospedeRepository.findById(hospedeId);
  }
}
