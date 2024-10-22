enum custom_keycodes {
    MCR0 = SAFE_RANGE,
    MCR1,
    MCR2,
    AF4,
    CADEL,
    TTY1,
    TTY2,
    TTY3,
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
    case MCR0:
        if (record->event.pressed) {
            // when keycode MCR0 is pressed
            SEND_STRING("yudhabosse12");
        } else {
            // when keycode MCR0 is released
            SEND_STRING(SS_TAP(X_ENT));
        }
        break;

    case MCR1:
        if (record->event.pressed) {
            // when keycode MCR1 is pressed
            SEND_STRING("Exaverious7");
        } else {
            // when keycode MCR1 is released
            SEND_STRING(SS_TAP(X_ENT));
        }
        break;

    case MCR2:
        if (record->event.pressed) {
            // when keycode MCR2 is pressed
            SEND_STRING("wzQUpR&8ehsy7w]Cm+YDxCcbuxmghN");
        } else {
            // when keycode MCR2 is released
            SEND_STRING(SS_TAP(X_ENT));
        }
        break;

    case AF4:
        if (record->event.pressed) {
            // when keycode AF4 is pressed
            SEND_STRING(SS_DOWN(X_LALT));
            SEND_STRING(SS_DOWN(X_F4));
        } else {
            // when keycode AF4 is released
            SEND_STRING(SS_UP(X_LALT));
            SEND_STRING(SS_UP(X_F4));
        }
        break;

    case CADEL:
        if (record->event.pressed) {
            // when keycode CADEL is pressed
            SEND_STRING(SS_DOWN(X_LCTL));
            SEND_STRING(SS_DOWN(X_LALT));
            SEND_STRING(SS_DOWN(X_DEL));
        } else {
            // when keycode CADEL is released
            SEND_STRING(SS_UP(X_LCTL));
            SEND_STRING(SS_UP(X_LALT));
            SEND_STRING(SS_UP(X_DEL));
        }
        break;

    case TTY1:
        if (record->event.pressed) {
            // when keycode TTY1 is pressed
            SEND_STRING(SS_DOWN(X_LCTL));
            SEND_STRING(SS_DOWN(X_LALT));
            SEND_STRING(SS_DOWN(X_F1));
        } else {
            // when keycode TTY1 is released
            SEND_STRING(SS_UP(X_LCTL));
            SEND_STRING(SS_UP(X_LALT));
            SEND_STRING(SS_UP(X_F1));
        }
        break;

    case TTY2:
        if (record->event.pressed) {
            // when keycode TTY2 is pressed
            SEND_STRING(SS_DOWN(X_LCTL));
            SEND_STRING(SS_DOWN(X_LALT));
            SEND_STRING(SS_DOWN(X_F2));
        } else {
            // when keycode TTY2 is released
            SEND_STRING(SS_UP(X_LCTL));
            SEND_STRING(SS_UP(X_LALT));
            SEND_STRING(SS_UP(X_F2));
        }
        break;

    case TTY3:
        if (record->event.pressed) {
            // when keycode TTY3 is pressed
            SEND_STRING(SS_DOWN(X_LCTL));
            SEND_STRING(SS_DOWN(X_LALT));
            SEND_STRING(SS_DOWN(X_F3));
        } else {
            // when keycode TTY3 is released
            SEND_STRING(SS_UP(X_LCTL));
            SEND_STRING(SS_UP(X_LALT));
            SEND_STRING(SS_UP(X_F3));
        }
        break;

    }
    if (record->event.pressed) {
        oled_timer = timer_read32();
        add_keylog(keycode);
    }
    return true;
};
