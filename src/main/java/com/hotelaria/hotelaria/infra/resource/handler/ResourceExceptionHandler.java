package com.hotelaria.hotelaria.infra.resource.handler;

import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import com.fasterxml.jackson.databind.exc.PropertyBindingException;
import com.hotelaria.hotelaria.domain.exception.BusinessException;
import com.hotelaria.hotelaria.domain.exception.EntityNotFoundException;
import com.hotelaria.hotelaria.domain.exception.ValidationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.TypeMismatchException;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.validation.UnexpectedTypeException;
import java.time.OffsetDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@ControllerAdvice
@RequiredArgsConstructor
public class ResourceExceptionHandler extends ResponseEntityExceptionHandler {

	public static final String GENERIC_MESSAGE_ERROR = "An unexpected error occur, please contact the system's administrator.";

	private final MessageSource messageSource;

	@ExceptionHandler(BusinessException.class)
	public ResponseEntity<Object> handleBusinessException(BusinessException ex, WebRequest request) {

		HttpStatus status = HttpStatus.BAD_REQUEST;
		ProblemType problemType = ProblemType.BUSINESS_ERROR;
		String detail = ex.getMessage();

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.code(ex.getCode())
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@ExceptionHandler(EntityNotFoundException.class)
	public ResponseEntity<Object> handleEntityNotFoundException(EntityNotFoundException ex,
																															WebRequest request) {

		HttpStatus status = HttpStatus.NOT_FOUND;
		ProblemType problemType = ProblemType.RESOURCE_NOT_FOUND;
		String detail = ex.getMessage();

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@ExceptionHandler(DateTimeParseException.class)
	public ResponseEntity<Object> handleDateTimeParseException(DateTimeParseException ex, WebRequest request) {
		HttpStatus status = HttpStatus.BAD_REQUEST;
		ProblemType problemType = ProblemType.INVALID_DATA;
		String detail = "The date format is invalid. Please use the pattern 'yyyy-MM-dd' or 'yyyy-MM-dd'T'HH:mm:ss'";
		String code = "INVALID_DATE_FORMAT";

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.code(code)
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@ExceptionHandler(ValidationException.class)
	public ResponseEntity<Object> handleValidationException(ValidationException ex, WebRequest request) {
		return handleValidationInternal(ex, ex.getBindingResult(), new HttpHeaders(), HttpStatus.BAD_REQUEST, request);
	}

	@ExceptionHandler(java.nio.file.AccessDeniedException.class)
	public ResponseEntity<Object> handleAccessDeniedException(java.nio.file.AccessDeniedException ex, WebRequest request) {
		HttpStatus status = HttpStatus.FORBIDDEN;
		ProblemType problemType = ProblemType.ACCESS_DENIED;
		String detail = ex.getMessage();

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.userMessage("You don't have permission to execute this operation.")
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@ExceptionHandler(Exception.class)
	public ResponseEntity<Object> handleUncaught(Exception ex, WebRequest request) {
		HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;
		ProblemType problemType = ProblemType.SYSTEM_ERROR;
		String detail = GENERIC_MESSAGE_ERROR;

		log.error(ex.getMessage(),ex);

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@ExceptionHandler(UnexpectedTypeException.class)
	public ResponseEntity<Object> handleUnexpectedTypeException(UnexpectedTypeException ex, WebRequest request) {
		HttpStatus status = HttpStatus.BAD_REQUEST;
		ProblemType problemType = ProblemType.INVALID_DATA;
		String detail = problemType.getTitle();

		log.error(ex.getMessage(),ex);

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@ExceptionHandler(IllegalArgumentException.class)
	public ResponseEntity<Object> handleIllegalArgumentException(IllegalArgumentException ex, WebRequest request) {
		HttpStatus status = HttpStatus.BAD_REQUEST;
		ProblemType problemType = ProblemType.INVALID_DATA;
		String detail = ex.getMessage();

		log.error(ex.getMessage(), ex);

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@Override
	protected ResponseEntity<Object> handleNoHandlerFoundException(NoHandlerFoundException ex,
																																 HttpHeaders headers, HttpStatus status, WebRequest request) {

		ProblemType problemType = ProblemType.RESOURCE_NOT_FOUND;
		String detail = String.format("The resource %s you tried to access does not exist.",
			ex.getRequestURL());

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(GENERIC_MESSAGE_ERROR)
			.build();

		return handleExceptionInternal(ex, problem, headers, status, request);
	}

	@Override
	protected ResponseEntity<Object> handleMissingServletRequestParameter(MissingServletRequestParameterException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
		ProblemType problemType = ProblemType.INVALID_PARAMETER;
		String detail = ex.getMessage();

		log.error(ex.getMessage(), ex);

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.build();

		return handleExceptionInternal(ex, problem, new HttpHeaders(), status, request);
	}

	@Override
	protected ResponseEntity<Object> handleHttpMediaTypeNotAcceptable(HttpMediaTypeNotAcceptableException ex,
																																		HttpHeaders headers, HttpStatus status, WebRequest request) {

		return ResponseEntity.status(status).headers(headers).build();
	}

	@Override
	protected ResponseEntity<Object> handleBindException(BindException ex, HttpHeaders headers, HttpStatus status,
																											 WebRequest request) {


		return handleValidationInternal(ex, ex.getBindingResult(), headers, status, request);
	}

	@Override
	protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
																																HttpHeaders headers, HttpStatus status, WebRequest request) {

		return handleValidationInternal(ex, ex.getBindingResult(), headers, status, request);
	}

	@Override
	protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers,
																													 HttpStatus status, WebRequest request) {

		if (body == null) {
			body = Problem.builder()
				.timestamp(OffsetDateTime.now())
				.title(status.getReasonPhrase())
				.status(status.value())
				.userMessage(GENERIC_MESSAGE_ERROR)
				.build();
		} else if (body instanceof String) {
			body = Problem.builder()
				.timestamp(OffsetDateTime.now())
				.title((String) body)
				.status(status.value())
				.userMessage(GENERIC_MESSAGE_ERROR)
				.build();
		}

		return super.handleExceptionInternal(ex, body, headers, status, request);
	}

	@Override
	protected ResponseEntity<Object> handleTypeMismatch(TypeMismatchException ex, HttpHeaders headers,
																											HttpStatus status, WebRequest request) {

		if (ex instanceof MethodArgumentTypeMismatchException) {
			return handleMethodArgumentTypeMismatch(
				(MethodArgumentTypeMismatchException) ex, headers, status, request);
		}

		return super.handleTypeMismatch(ex, headers, status, request);
	}

	@Override
	protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex,
																																HttpHeaders headers, HttpStatus status, WebRequest request) {
		Throwable rootCause = ExceptionUtils.getRootCause(ex);

		if (rootCause instanceof InvalidFormatException) {
			return handleInvalidFormat((InvalidFormatException) rootCause, headers, status, request);
		} else if (rootCause instanceof PropertyBindingException) {
			return handlePropertyBinding((PropertyBindingException) rootCause, headers, status, request);
		}

		ProblemType problemType = ProblemType.UNREADABLE_MESSAGE;
		String detail = "The request body is invalid. Check for a syntax error.";

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(GENERIC_MESSAGE_ERROR)
			.build();

		return handleExceptionInternal(ex, problem, headers, status, request);
	}

	private ResponseEntity<Object> handleMethodArgumentTypeMismatch(
		MethodArgumentTypeMismatchException ex, HttpHeaders headers,
		HttpStatus status, WebRequest request) {

		ProblemType problemType = ProblemType.INVALID_PARAMETER;

		String detail = String.format("An URL parameter '%s' received the value '%s', "
				+ "that is an invalid format. Please provide an compatible value with the type %s.",
			ex.getName(), ex.getValue(), ex.getRequiredType().getSimpleName());

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(GENERIC_MESSAGE_ERROR)
			.build();

		return handleExceptionInternal(ex, problem, headers, status, request);
	}

	private ResponseEntity<Object> handleValidationInternal(Exception ex, BindingResult bindingResult, HttpHeaders headers,
																													HttpStatus status, WebRequest request) {

		ProblemType problemType = ProblemType.INVALID_DATA;

		String detail = "One or more fields are invalid. Fill rightly and try again.";


		List<Problem.Object> problemObjects = bindingResult.getAllErrors().stream()
			.map(objectError -> {

				String message = messageSource.getMessage(objectError, LocaleContextHolder.getLocale());

				String name = objectError.getObjectName();

				if (objectError instanceof FieldError) {
					name =((FieldError) objectError).getField();
				}

				return Problem.Object.builder()
					.name(name)
					.userMessage(message)
					.build();
			})
			.collect(Collectors.toList());

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(detail)
			.objects(problemObjects)
			.build();

		return handleExceptionInternal(ex, problem, headers, status, request);
	}


	private ResponseEntity<Object> handlePropertyBinding(PropertyBindingException ex,
																											 HttpHeaders headers, HttpStatus status, WebRequest request) {

		String path = joinPath(ex.getPath());

		ProblemType problemType = ProblemType.UNREADABLE_MESSAGE;
		String detail = String.format("The property '%s' does not exists. "
			+ "Fix or remove this property and try again", path);

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(GENERIC_MESSAGE_ERROR)
			.build();

		return handleExceptionInternal(ex, problem, headers, status, request);
	}

	private ResponseEntity<Object> handleInvalidFormat(InvalidFormatException ex,
																										 HttpHeaders headers, HttpStatus status, WebRequest request) {

		String path = joinPath(ex.getPath());

		ProblemType problemType = ProblemType.UNREADABLE_MESSAGE;
		String detail = String.format("The property '%s' received the value '%s', "
				+ "that is in an invalid format. Fix it and provide an compatible value with type %s.",
			path, ex.getValue(), ex.getTargetType().getSimpleName());

		Problem problem = createProblemBuilder(status, problemType, detail)
			.userMessage(GENERIC_MESSAGE_ERROR)
			.build();

		return handleExceptionInternal(ex, problem, headers, status, request);
	}

	private Problem.ProblemBuilder createProblemBuilder(HttpStatus status,
																											ProblemType problemType, String detail) {

		return Problem.builder()
			.timestamp(OffsetDateTime.now())
			.status(status.value())
			.type(problemType.getUri())
			.title(problemType.getTitle())
			.detail(detail);
	}

	private String joinPath(List<JsonMappingException.Reference> references) {
		return references.stream()
			.map(JsonMappingException.Reference::getFieldName)
			.collect(Collectors.joining("."));
	}
}
