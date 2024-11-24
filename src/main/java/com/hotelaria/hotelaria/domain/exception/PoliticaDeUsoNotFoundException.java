package com.hotelaria.hotelaria.domain.exception;

public class PoliticaDeUsoNotFoundException extends EntityNotFoundException {
  public PoliticaDeUsoNotFoundException(Long id) {
    super(String.format("Politica de uso com id %d não encontrado", id));
  }
}
