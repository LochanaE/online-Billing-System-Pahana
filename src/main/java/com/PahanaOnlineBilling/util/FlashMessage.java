package com.PahanaOnlineBilling.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class FlashMessage {

    private static final String FLASH_KEY = "FLASH_MESSAGE";

    // Set flash message
    public static void setMessage(HttpServletRequest request, String message, String type) {
        HttpSession session = request.getSession();
        session.setAttribute(FLASH_KEY, new Flash(message, type));
    }

    // Get and remove flash message
    public static Flash getMessage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Flash flash = (Flash) session.getAttribute(FLASH_KEY);
        if(flash != null) {
            session.removeAttribute(FLASH_KEY); // Remove after reading
        }
        return flash;
    }

    // Inner class to hold message content and type
    public static class Flash {
        private String message;
        private String type; // e.g., "success", "error", "info"

        public Flash(String message, String type) {
            this.message = message;
            this.type = type;
        }

        public String getMessage() {
            return message;
        }

        public String getType() {
            return type;
        }
    }
}
