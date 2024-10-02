enum custom_keycodes {
    MCR0 = SAFE_RANGE,
    MCR1,
    MCR2,
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
    }
    if (record->event.pressed) {
        oled_timer = timer_read32();
        add_keylog(keycode);
    }
    return true;
};
