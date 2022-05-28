#include QMK_KEYBOARD_H

enum layer_number {
  _BASE,
  _NUM,
  _NAV,
};
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_BASE] = LAYOUT(
    KC_ESC,      KC_1,        KC_2,        KC_3,        KC_4,        KC_5,                                    KC_6,        KC_7,        KC_8,        KC_9,        KC_0,        KC_ESC,      
    LGUI(KC_TAB), KC_Q,        KC_W,        KC_F,        KC_P,        KC_B,                                    KC_J,        KC_L,        KC_U,        KC_Y,        KC_QUOT,     LCTL(KC_T),  
    LCTL_T(KC_ESC), KC_A,        KC_R,        KC_S,        KC_T,        KC_G,                                    KC_M,        KC_N,        KC_E,        KC_I,        KC_O,        KC_SCLN,     
    KC_CAPS,     KC_Z,        KC_X,        KC_C,        KC_D,        KC_V,        KC_NO,         KC_NO,       KC_K,        KC_H,        KC_COMMA,    KC_DOT,      KC_SLSH,     LCTL(KC_TAB), 
                                           KC_NO,       LT(_NAV, KC_ESC), LGUI_T(KC_SPC), SFT_T(KC_TAB),   LCTL_T(KC_ENT), LT(_NUM, KC_BSPC), KC_LALT,     KC_NO        
    
  ),
  [_NUM] = LAYOUT(
    KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,                                   KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       
    RESET,       KC_LBRC,     KC_7,        KC_8,        KC_9,        KC_RBRC,                                 KC_LCBR,     KC_LPRN,     KC_ASTR,     KC_AMPR,     KC_RCBR,     KC_NO,       
    KC_NO,       KC_0,        KC_4,        KC_5,        KC_6,        KC_EQL,                                  KC_PLUS,     KC_CIRC,     KC_PERC,     KC_DLR,      KC_RPRN,     KC_NO,       
    KC_NO,       KC_GRV,      KC_1,        KC_2,        KC_3,        KC_BSLS,     KC_NO,         KC_NO,       KC_PIPE,     KC_HASH,     KC_AT,       KC_EXLM,     KC_TILD,     KC_NO,       
                                           KC_NO,       KC_UNDS,     KC_SPC,      KC_MINS,       KC_ENT,      KC_TRNS,     KC_NO,       KC_NO        
    
  ),
  [_NAV] = LAYOUT(
    KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,                                   KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       
    KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,                                   KC_MPRV,     KC_VOLD,     KC_VOLU,     KC_MNXT,     KC_NO,       KC_NO,       
    KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,                                   KC_LEFT,     KC_DOWN,     KC_UP,       KC_RGHT,     KC_NO,       KC_NO,       
    KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,       KC_NO,         KC_NO,       KC_HOME,     KC_END,      KC_MPLY,     KC_MUTE,     KC_NO,       KC_NO,       
                                           KC_NO,       KC_NO,       KC_TRNS,     KC_NO,         KC_ENT,      KC_BSPC,     KC_NO,       KC_NO        
    
  )
};
