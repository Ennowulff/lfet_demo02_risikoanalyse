INTERFACE zif_lfet02_model_risikoanalyse
  PUBLIC.
  TYPES _rechtl_rahmenbedingung   TYPE string.
  TYPES _ressourcen_abhaengigkeit TYPE string.
  TYPES _projektumfang            TYPE string.
  TYPES _risikoanalyse            TYPE string.

  CONSTANTS:
    BEGIN OF c_risikoanalyse,
      "! Eine Risikoanalyse wird empfohlen, ist jedoch nicht zwingend notwendig
      empfohlen       TYPE _risikoanalyse VALUE 'empf',
      "! Eine Risikoanalyse ist nicht notwendig
      nicht_notwendig TYPE _risikoanalyse VALUE 'keine',
      "! Eine Risikoanalyse ist notwendig
      notwendig       TYPE _risikoanalyse VALUE 'notw',
    END OF c_risikoanalyse.
  CONSTANTS:
    BEGIN OF c_rechtl_rahmenbedingungen,
      "! Es sind keine rechtlichen Rahmenbedingungen zu berücksichtigen
      keine     TYPE _rechtl_rahmenbedingung VALUE 'nv' ##NO_TEXT,
      "! Es ist unklar/ nicht geklärt, ob rechtliche Rahmenbedingungen vorhanden sind
      unklar    TYPE _rechtl_rahmenbedingung VALUE 'unkl' ##NO_TEXT,
      "! Es existieren rechtliche Rahmenbedinungen, die zu berücksichtigen sind
      vorhanden TYPE _rechtl_rahmenbedingung VALUE 'vorh' ##NO_TEXT,
    END OF c_rechtl_rahmenbedingungen.
  CONSTANTS:
    BEGIN OF c_projektumfang,
      klein  TYPE _projektumfang VALUE '<=15',
      mittel TYPE _projektumfang VALUE ']15 : 60]',
      gross  TYPE _projektumfang VALUE '>60',
    END OF c_projektumfang.
  CONSTANTS:
    BEGIN OF c_ressourcen_abhaengigkeit,
      int1     TYPE _ressourcen_abhaengigkeit VALUE `Ext=0;Int=1`,
      int2plus TYPE _ressourcen_abhaengigkeit VALUE `Ext=0;Int>=2`,
      ext1plus TYPE _ressourcen_abhaengigkeit VALUE `Ext>=1`,
    END OF c_ressourcen_abhaengigkeit.

  TYPES: BEGIN OF _values,
           rechtl_rahmenbedingung   TYPE _rechtl_rahmenbedingung,
           ressourcen_abhaengigkeit TYPE _ressourcen_abhaengigkeit,
           projektumfang            TYPE _projektumfang,
         END OF _values.

  TYPES: BEGIN OF _state,
           risikoanalyse TYPE _risikoanalyse,
         END OF _state.

  METHODS do_risikoanalyse
    IMPORTING
      i_value TYPE _risikoanalyse.

  METHODS get_risikoanalyse
    RETURNING
      VALUE(result) TYPE _risikoanalyse.

  METHODS set_rechtl_rahmenbedingungen
    IMPORTING
      i_value TYPE _rechtl_rahmenbedingung.

  METHODS set_ressourcen_abhaengigkeit
    IMPORTING
      i_value TYPE _ressourcen_abhaengigkeit.

  METHODS set_projektumfang
    IMPORTING
      i_value TYPE _projektumfang.

  METHODS is_rechtl_rahmenbedingungen
    RETURNING
      VALUE(result) TYPE _rechtl_rahmenbedingung.

  METHODS is_ressourcen_abhaengigkeit
    RETURNING
      VALUE(result) TYPE _ressourcen_abhaengigkeit.

  METHODS is_projektumfang
    RETURNING
      VALUE(result) TYPE _projektumfang.

  CLASS-METHODS txt_rechtl_rahmenbedingungen
    IMPORTING
      i_value       TYPE zif_lfet02_model_risikoanalyse=>_rechtl_rahmenbedingung
    RETURNING
      VALUE(result) TYPE _rechtl_rahmenbedingung.

  CLASS-METHODS txt_ressourcen_abhaengigkeit
    IMPORTING
      i_value       TYPE zif_lfet02_model_risikoanalyse=>_rechtl_rahmenbedingung
    RETURNING
      VALUE(result) TYPE _ressourcen_abhaengigkeit.

  CLASS-METHODS txt_projektumfang
    IMPORTING
      i_value       TYPE zif_lfet02_model_risikoanalyse=>_projektumfang
    RETURNING
      VALUE(result) TYPE _projektumfang.

  DATA trace TYPE REF TO /rbgrp/if_trace.


ENDINTERFACE.
