package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
public class EstoqueProduto {
  @EmbeddedId
  private EstoqueProdutoId id;
  private Integer quantidade;
}
