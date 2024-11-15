REPORT zzlfet02_demo01_enum.

DATA default_rechtl_rahmenbed TYPE znm_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen VALUE znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-vorhanden.
DATA default_ressourcen_abh   TYPE znm_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit VALUE znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1.
DATA default_projektumfang    TYPE znm_lfet02_enum_risikoanalyse=>enum_projektumfang            VALUE znm_lfet02_enum_risikoanalyse=>projektumfang-klein.

" GUI zur Eingabe der Bedingungswerte
PARAMETERS p_legal TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_rechtl_rahmenbed.
PARAMETERS p_rssrc TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_ressourcen_abh.
PARAMETERS p_psize TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_projektumfang.

" GUI zur Anzeige des ermittelten Aktionsergebnisses und der verwendeten Regel
PARAMETERS p_result TYPE char20 LOWER CASE MODIF ID dsp.
PARAMETERS p_rule   TYPE char20 LOWER CASE MODIF ID dsp.

" Das Model zur Entscheidungstabelle
DATA model TYPE REF TO zif_lfet02_enum_risikoanalyse.

INITIALIZATION.
  " Model-Objekt  erzeugen
  model = NEW zcl_lfet02_enum_risikoanalyse( ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_LEGAL'
      values = VALUE vrm_values(
          ( key  = znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-vorhanden
            text = zcl_lfet02_enum_risikoanalyse=>txt_rechtl_rahmenbedingung(
                       znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-vorhanden ) )
          ( key  = znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-unklar
            text = zcl_lfet02_enum_risikoanalyse=>txt_rechtl_rahmenbedingung(
                       znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-unklar ) )
          ( key  = znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine
            text = zcl_lfet02_enum_risikoanalyse=>txt_rechtl_rahmenbedingung(
                       znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine ) )  ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_RSSRC'
      values = VALUE vrm_values(
          ( key  = znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1
            text = zcl_lfet02_enum_risikoanalyse=>txt_ressourcen_abhaengigkeit(
                       znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1 ) )
          ( key  = znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus
            text = zcl_lfet02_enum_risikoanalyse=>txt_ressourcen_abhaengigkeit(
                       znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus ) )
          ( key  = znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-ext1plus
            text = zcl_lfet02_enum_risikoanalyse=>txt_ressourcen_abhaengigkeit(
                       znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-ext1plus ) ) ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_PSIZE'
      values = VALUE vrm_values(
          ( key  = znm_lfet02_enum_risikoanalyse=>projektumfang-klein
            text = zcl_lfet02_enum_risikoanalyse=>txt_projektumfang(
                       znm_lfet02_enum_risikoanalyse=>projektumfang-klein ) )
          ( key  = znm_lfet02_enum_risikoanalyse=>projektumfang-mittel
            text = zcl_lfet02_enum_risikoanalyse=>txt_projektumfang(
                       znm_lfet02_enum_risikoanalyse=>projektumfang-mittel ) )
          ( key  = znm_lfet02_enum_risikoanalyse=>projektumfang-gross
            text = zcl_lfet02_enum_risikoanalyse=>txt_projektumfang(
                       znm_lfet02_enum_risikoanalyse=>projektumfang-gross ) ) ).



AT SELECTION-SCREEN OUTPUT.
  " GUI: Ergebnisfelder auf "nicht eingabebereit" setzen
  LOOP AT SCREEN.
    IF screen-group1 = 'DSP'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  " Aktion bei "ENTER"

AT SELECTION-SCREEN.
  TRY.
      " Setzen der Bedingungswerte
      ASSIGN COMPONENT p_legal OF STRUCTURE znm_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen TO FIELD-SYMBOL(<legal>).
      model->set_rechtl_rahmenbedingungen( <legal> ).
      ASSIGN COMPONENT p_rssrc OF STRUCTURE znm_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit TO FIELD-SYMBOL(<rssrc>).
      model->set_ressourcen_abhaengigkeit( <rssrc> ).
      ASSIGN COMPONENT p_psize OF STRUCTURE znm_lfet02_enum_risikoanalyse=>projektumfang TO FIELD-SYMBOL(<psize>).
      model->set_projektumfang( <psize> ).

      " Risikoermittlung durchführen
      zcl_lfet02_rule_risikoan_enum=>execute( model ).

      " Ernmittlung des Ergebnisses
      p_result = model->get_risikoanalyse( ).
      p_rule   = model->trace->get_trace( )-used_rule.
    CATCH zcx_lfet02_enum_wrong_value.
  ENDTRY.
