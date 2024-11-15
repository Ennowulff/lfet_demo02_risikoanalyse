INTERFACE zif_lfet02_enum_risikoanalyse
  PUBLIC.

 TYPES: BEGIN OF _values,
           rechtl_rahmenbedingung   TYPE znm_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen,
           ressourcen_abhaengigkeit TYPE znm_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit,
           projektumfang            TYPE znm_lfet02_enum_risikoanalyse=>enum_projektumfang,
         END OF _values.

  TYPES: BEGIN OF _state,
           risikoanalyse TYPE znm_lfet02_enum_risikoanalyse=>enum_risikoanalyse,
         END OF _state.

  METHODS do_risikoanalyse
    IMPORTING
      i_value TYPE znm_lfet02_enum_risikoanalyse=>enum_risikoanalyse.

  METHODS get_risikoanalyse
    RETURNING
      VALUE(result) TYPE znm_lfet02_enum_risikoanalyse=>enum_risikoanalyse.

  METHODS set_rechtl_rahmenbedingungen
    IMPORTING
      i_value TYPE znm_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen.

  METHODS set_ressourcen_abhaengigkeit
    IMPORTING
      i_value TYPE znm_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit.

  METHODS set_projektumfang
    IMPORTING
      i_value TYPE znm_lfet02_enum_risikoanalyse=>enum_projektumfang.

  METHODS is_rechtl_rahmenbedingungen
    RETURNING
      VALUE(result) TYPE znm_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen.

  METHODS is_ressourcen_abhaengigkeit
    RETURNING
      VALUE(result) TYPE znm_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit.

  METHODS is_projektumfang
    RETURNING
      VALUE(result) TYPE znm_lfet02_enum_risikoanalyse=>enum_projektumfang.

  CLASS-METHODS txt_rechtl_rahmenbedingungen
    IMPORTING
      i_value       TYPE znm_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen
    RETURNING
      VALUE(result) TYPE string.

  CLASS-METHODS txt_ressourcen_abhaengigkeit
    IMPORTING
      i_value       TYPE znm_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit
    RETURNING
      VALUE(result) TYPE string.

  CLASS-METHODS txt_projektumfang
    IMPORTING
      i_value       TYPE znm_lfet02_enum_risikoanalyse=>enum_projektumfang
    RETURNING
      VALUE(result) TYPE string.

  DATA trace TYPE REF TO /rbgrp/if_trace.

ENDINTERFACE.
