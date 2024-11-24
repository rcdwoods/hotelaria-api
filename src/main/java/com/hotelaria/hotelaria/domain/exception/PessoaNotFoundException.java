package com.hotelaria.hotelaria.domain.exception;

public class PessoaNotFoundException extends EntityNotFoundException {
  public PessoaNotFoundException(Long id) {
    super(String.format("Pessoa com id %d não encontrado", id));
  }
}
