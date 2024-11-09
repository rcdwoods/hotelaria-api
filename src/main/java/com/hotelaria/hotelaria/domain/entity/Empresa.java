package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

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

  @OneToMany
  @JoinTable(
    name = "empresa_manutencao",
    joinColumns = @JoinColumn(name = "empresa_id"),
    inverseJoinColumns = @JoinColumn(name = "manutencao_id")
  )
  private List<Manutencao> manutencoes;
}
