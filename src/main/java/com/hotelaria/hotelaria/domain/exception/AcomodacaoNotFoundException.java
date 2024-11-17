package com.hotelaria.hotelaria.domain.exception;

public class AcomodacaoNotFoundException extends EntityNotFoundException {
  public AcomodacaoNotFoundException(Long id) {
    super(String.format("Acomodacao com id %d não encontrada", id));
  }
}
