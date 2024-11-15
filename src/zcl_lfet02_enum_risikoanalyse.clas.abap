CLASS zcl_lfet02_enum_risikoanalyse DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_lfet02_enum_risikoanalyse.

    ALIASES txt_rechtl_rahmenbedingung   FOR zif_lfet02_enum_risikoanalyse~txt_rechtl_rahmenbedingungen.
    ALIASES txt_ressourcen_abhaengigkeit FOR zif_lfet02_enum_risikoanalyse~txt_ressourcen_abhaengigkeit.
    ALIASES txt_projektumfang            FOR zif_lfet02_enum_risikoanalyse~txt_projektumfang.
    ALIASES trace                        FOR zif_lfet02_enum_risikoanalyse~trace.

    METHODS constructor.

  PRIVATE SECTION.
    DATA values TYPE zif_lfet02_enum_risikoanalyse=>_values.
    DATA state  TYPE zif_lfet02_enum_risikoanalyse=>_state.

ENDCLASS.


CLASS zcl_lfet02_enum_risikoanalyse IMPLEMENTATION.
  METHOD constructor.
    trace = NEW /rbgrp/cl_trace( ).
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_projektumfang.
    IF values-projektumfang IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-projektumfang.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_rechtl_rahmenbedingungen.
    IF values-rechtl_rahmenbedingung IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-rechtl_rahmenbedingung.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_ressourcen_abhaengigkeit.
    IF values-ressourcen_abhaengigkeit IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-ressourcen_abhaengigkeit.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~set_projektumfang.
    values-projektumfang = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~set_rechtl_rahmenbedingungen.
    values-rechtl_rahmenbedingung = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~set_ressourcen_abhaengigkeit.
    values-ressourcen_abhaengigkeit = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~do_risikoanalyse.
    state-risikoanalyse = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~get_risikoanalyse.
    result = state-risikoanalyse.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~txt_projektumfang.
    result = SWITCH #( i_value
                       WHEN znm_lfet02_enum_risikoanalyse=>projektumfang-klein  THEN |<=15 PT|
                       WHEN znm_lfet02_enum_risikoanalyse=>projektumfang-mittel THEN |>15:<60 PT|
                       WHEN znm_lfet02_enum_risikoanalyse=>projektumfang-gross  THEN |>60 PT|
                       ELSE                                                          |ERROR| ).
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~txt_rechtl_rahmenbedingungen.
    result = SWITCH #( i_value
                       WHEN znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine     THEN |Keine|
                       WHEN znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-unklar    THEN |Unklar|
                       WHEN znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-vorhanden THEN |Vorhanden|
                       ELSE                                                                        |ERROR| ).
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~txt_ressourcen_abhaengigkeit.
    result = SWITCH #( i_value
                       WHEN znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1 THEN
                         |Externe=0, Interne=1|
                       WHEN znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus THEN
                         |Externe=0, Interne>=2|
                       WHEN znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-ext1plus THEN
                         |Externe>=1|
                       ELSE
                         |ERROR| ).
  ENDMETHOD.
ENDCLASS.
