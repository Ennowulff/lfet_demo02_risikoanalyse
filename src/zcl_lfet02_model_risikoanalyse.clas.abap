CLASS zcl_lfet02_model_risikoanalyse DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_lfet02_model_risikoanalyse.

    ALIASES txt_rechtl_rahmenbedingung   FOR zif_lfet02_model_risikoanalyse~txt_rechtl_rahmenbedingungen.
    ALIASES txt_ressourcen_abhaengigkeit FOR zif_lfet02_model_risikoanalyse~txt_ressourcen_abhaengigkeit.
    ALIASES txt_projektumfang            FOR zif_lfet02_model_risikoanalyse~txt_projektumfang.
    ALIASES: trace FOR zif_lfet02_model_risikoanalyse~trace.

    METHODS constructor.

  PRIVATE SECTION.
    METHODS chk_ressourcen_abhaengigkeit
      IMPORTING
        i_value TYPE zif_lfet02_model_risikoanalyse=>_ressourcen_abhaengigkeit
      RAISING
        zcx_lfet02_enum_wrong_value.

    METHODS chk_rechtl_rahmenbedingungen
      IMPORTING
        i_value TYPE zif_lfet02_model_risikoanalyse=>_rechtl_rahmenbedingung
      RAISING
        zcx_lfet02_enum_wrong_value.

    METHODS chk_projektumfang
      IMPORTING
        i_value TYPE zif_lfet02_model_risikoanalyse=>_projektumfang
      RAISING
        zcx_lfet02_enum_wrong_value.

    DATA values TYPE zif_lfet02_model_risikoanalyse=>_values.
    DATA state  TYPE zif_lfet02_model_risikoanalyse=>_state.

ENDCLASS.


CLASS zcl_lfet02_model_risikoanalyse IMPLEMENTATION.
  METHOD constructor.
    trace = NEW /rbgrp/cl_trace( ).
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~is_projektumfang.
    IF values-projektumfang IS INITIAL.
      " Implement your customer code here
      values-projektumfang = zcl_lfet02_enum_risiko_18=>enum_calc_projektumfang( 4 ).
    ELSE.
      result = values-projektumfang.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~is_rechtl_rahmenbedingungen.
    IF values-rechtl_rahmenbedingung IS INITIAL.
      " Implement your customer code here

    ELSE.
*      result = values-rechtl_rahmenbedingung.
    ENDIF.

    IF values-rechtl_rahmenbedingung = input.
      result = abap_true.
    ENDIF.


  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~is_ressourcen_abhaengigkeit.
    IF values-ressourcen_abhaengigkeit IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-ressourcen_abhaengigkeit.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~set_projektumfang.
    chk_projektumfang( i_value ).
    values-projektumfang = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~set_rechtl_rahmenbedingungen.
    chk_rechtl_rahmenbedingungen( i_value ).
    values-rechtl_rahmenbedingung = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~set_ressourcen_abhaengigkeit.
    chk_ressourcen_abhaengigkeit( i_value ).
    values-ressourcen_abhaengigkeit = i_value.
  ENDMETHOD.

  METHOD chk_rechtl_rahmenbedingungen.
    IF    i_value = zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-keine
       OR i_value = zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-unklar
       OR i_value = zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-vorhanden.
      RETURN.
    ENDIF.
    RAISE EXCEPTION NEW zcx_lfet02_enum_wrong_value( ).
  ENDMETHOD.

  METHOD chk_projektumfang.
    IF    i_value = zif_lfet02_model_risikoanalyse=>c_projektumfang-gross
       OR i_value = zif_lfet02_model_risikoanalyse=>c_projektumfang-mittel
       OR i_value = zif_lfet02_model_risikoanalyse=>c_projektumfang-klein.
      RETURN.
    ENDIF.
    RAISE EXCEPTION NEW zcx_lfet02_enum_wrong_value( ).
  ENDMETHOD.

  METHOD chk_ressourcen_abhaengigkeit.
    IF    i_value = zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int1
       OR i_value = zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int2plus
       OR i_value = zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-ext1plus.
      RETURN.
    ENDIF.
    RAISE EXCEPTION NEW zcx_lfet02_enum_wrong_value( ).
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~do_risikoanalyse.
    state-risikoanalyse = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~get_risikoanalyse.
    result = state-risikoanalyse.
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~txt_projektumfang.
    result = SWITCH #( i_value
                       WHEN zif_lfet02_model_risikoanalyse=>c_projektumfang-klein  THEN '<=15 PT'
                       WHEN zif_lfet02_model_risikoanalyse=>c_projektumfang-mittel THEN '>15:<60 PT'
                       WHEN zif_lfet02_model_risikoanalyse=>c_projektumfang-gross  THEN '>60 PT'
                       ELSE                                                             'ERROR' ).
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~txt_rechtl_rahmenbedingungen.
    result = SWITCH #( i_value
                       WHEN zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-keine     THEN 'Keine'
                       WHEN zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-unklar    THEN 'Unklar'
                       WHEN zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-vorhanden THEN 'Vorhanden'
                       ELSE                                                                           'ERROR' ).
  ENDMETHOD.

  METHOD zif_lfet02_model_risikoanalyse~txt_ressourcen_abhaengigkeit.
    result = SWITCH #( i_value
                       WHEN zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int1 THEN
                         'Externe=0, Interne=1'
                       WHEN zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int2plus THEN
                         'Externe=0, Interne>=2'
                       WHEN zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-ext1plus THEN
                         'Externe>=1'
                       ELSE
                         'ERROR' ).
  ENDMETHOD.
ENDCLASS.
