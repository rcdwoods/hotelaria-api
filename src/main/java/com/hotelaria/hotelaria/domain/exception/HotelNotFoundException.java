package com.hotelaria.hotelaria.domain.exception;

public class HotelNotFoundException extends EntityNotFoundException {
  public HotelNotFoundException(Long id) {
    super(String.format("Hotel com id %d não encontrado", id));
  }
}
