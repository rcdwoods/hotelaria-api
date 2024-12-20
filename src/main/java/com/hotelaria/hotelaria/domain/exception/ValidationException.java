package com.hotelaria.hotelaria.domain.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.validation.BindingResult;

@Getter
@AllArgsConstructor
public class ValidationException extends RuntimeException {

	private BindingResult bindingResult;
}
