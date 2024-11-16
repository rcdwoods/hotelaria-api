package com.hotelaria.hotelaria.infra.mapper;

import com.hotelaria.hotelaria.domain.entity.Hotel;
import com.hotelaria.hotelaria.infra.resource.dto.HotelResponse;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(uses = {AcomodacaoMapper.class})
public interface HotelMapper {
  List<HotelResponse> toResponse(List<Hotel> hotel);
}
