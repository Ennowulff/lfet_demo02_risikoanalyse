REPORT zzlfet02_demo01.

DATA default_rechtl_rahmenbed TYPE c LENGTH 20 VALUE zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-vorhanden.
DATA default_ressourcen_abh   TYPE c LENGTH 20 VALUE zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int1.
DATA default_projektumfang    TYPE c LENGTH 20 VALUE zif_lfet02_model_risikoanalyse=>c_projektumfang-klein.

" GUI zur Eingabe der Bedingungswerte
PARAMETERS p_legal TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_rechtl_rahmenbed.
PARAMETERS p_rssrc TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_ressourcen_abh.
PARAMETERS p_psize TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_projektumfang.

" GUI zur Anzeige des ermittelten Aktionsergebnisses und der verwendeten Regel
PARAMETERS p_result TYPE char20 LOWER CASE MODIF ID dsp.
PARAMETERS p_rule   TYPE char20 LOWER CASE MODIF ID dsp.

" Das Model zur Entscheidungstabelle
DATA model TYPE REF TO zif_lfet02_model_risikoanalyse.

INITIALIZATION.
  " Model-Objekt  erzeugen
  model = NEW zcl_lfet02_model_risikoanalyse( ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_LEGAL'
      values = VALUE vrm_values(
          ( key  = zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-vorhanden
            text = zcl_lfet02_model_risikoanalyse=>txt_rechtl_rahmenbedingung(
                       zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-vorhanden ) )
          ( key  = zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-unklar
            text = zcl_lfet02_model_risikoanalyse=>txt_rechtl_rahmenbedingung(
                       zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-unklar ) )
          ( key  = zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-keine
            text = zcl_lfet02_model_risikoanalyse=>txt_rechtl_rahmenbedingung(
                       zif_lfet02_model_risikoanalyse=>c_rechtl_rahmenbedingungen-keine ) )  ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_RSSRC'
      values = VALUE vrm_values(
          ( key  = zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int1
            text = zcl_lfet02_model_risikoanalyse=>txt_ressourcen_abhaengigkeit(
                       zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int1 ) )
          ( key  = zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int2plus
            text = zcl_lfet02_model_risikoanalyse=>txt_ressourcen_abhaengigkeit(
                       zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-int2plus ) )
          ( key  = zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-ext1plus
            text = zcl_lfet02_model_risikoanalyse=>txt_ressourcen_abhaengigkeit(
                       zif_lfet02_model_risikoanalyse=>c_ressourcen_abhaengigkeit-ext1plus ) ) ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_PSIZE'
      values = VALUE vrm_values(
          ( key  = zif_lfet02_model_risikoanalyse=>c_projektumfang-klein
            text = zcl_lfet02_model_risikoanalyse=>txt_projektumfang(
                       zif_lfet02_model_risikoanalyse=>c_projektumfang-klein ) )
          ( key  = zif_lfet02_model_risikoanalyse=>c_projektumfang-mittel
            text = zcl_lfet02_model_risikoanalyse=>txt_projektumfang(
                       zif_lfet02_model_risikoanalyse=>c_projektumfang-mittel ) )
          ( key  = zif_lfet02_model_risikoanalyse=>c_projektumfang-gross
            text = zcl_lfet02_model_risikoanalyse=>txt_projektumfang(
                       zif_lfet02_model_risikoanalyse=>c_projektumfang-gross ) ) ).



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
      model->set_rechtl_rahmenbedingungen( CONV #( p_legal ) ).
      model->set_ressourcen_abhaengigkeit( CONV #( p_rssrc ) ).
      model->set_projektumfang( CONV #( p_psize ) ).

      " Risikoermittlung durchführen
      zcl_lfet02_rule_risikoanalyse=>execute( model ).

      " Ernmittlung des Ergebnisses
      p_result = model->get_risikoanalyse( ).
      p_rule   = model->trace->get_trace( )-used_rule.
    CATCH zcx_lfet02_enum_wrong_value.
  ENDTRY.
