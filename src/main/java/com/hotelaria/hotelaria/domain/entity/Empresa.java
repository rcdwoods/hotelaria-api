package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;

import java.util.List;

@Entity
public class Empresa {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(unique = true)
  private String cnpj;
  @OneToMany(mappedBy = "empresa")
  private List<ContratoAluguel> contratosDeAluguel;
  @Enumerated(EnumType.STRING)
  @Column(name = "tipo_empresa")
  private TipoEmpresaEnum tipoEmpresa;
}
