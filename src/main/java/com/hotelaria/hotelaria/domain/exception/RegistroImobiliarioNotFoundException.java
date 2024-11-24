package com.hotelaria.hotelaria.domain.exception;

public class RegistroImobiliarioNotFoundException extends EntityNotFoundException {
  public RegistroImobiliarioNotFoundException(Long id) {
    super(String.format("Registro imobiliario com id %d não encontrado", id));
  }
}
