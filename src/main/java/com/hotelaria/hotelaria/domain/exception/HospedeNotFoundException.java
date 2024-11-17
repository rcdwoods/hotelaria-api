package com.hotelaria.hotelaria.domain.exception;

public class HospedeNotFoundException extends EntityNotFoundException {
  public HospedeNotFoundException(Long id) {
    super(String.format("Hospede com id %d não encontrado", id));
  }
}
