package com.hotelaria.hotelaria.infra.resource.handler;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@JsonInclude(Include.NON_NULL)
public class Problem {
  private Integer status;
  private String type;
  private String title;
  private String detail;
  private String userMessage;
  private String code;
  private OffsetDateTime timestamp;
  private List<Object> objects;

  @Getter
  @Builder
  public static class Object {
    private String name;
    private String userMessage;
  }
}
