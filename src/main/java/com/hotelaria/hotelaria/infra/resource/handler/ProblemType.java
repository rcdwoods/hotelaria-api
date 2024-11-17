package com.hotelaria.hotelaria.infra.resource.handler;

import lombok.Getter;

@Getter
public enum ProblemType {

    INVALID_DATA("/invalid-date","Invalid Data"),
    METHOD_NOT_SUPPORTED("/method-not-supported", "HTTP Method not supported"),
    SYSTEM_ERROR("/system-error","System Error"),
    INVALID_PARAMETER("/invalid-parameter","Invalid Parameter"),
    UNREADABLE_MESSAGE("/unreadable-message", "Unreadable Message"),
    RESOURCE_NOT_FOUND("/resource-not-found","Resource Not Found"),
    BUSINESS_ERROR("/business-error", "Violation of business rule"),
    ACCESS_DENIED("/access-denied", "Access Denied");


    private final String title;
    private final String uri;

    ProblemType(String path, String title) {
        this.uri = "https://hotelaria.com" + path;
        this.title = title;
    }
}
