CLASS zcl_lfet02_rule_risikoanalyse DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS execute
      IMPORTING
        i_model TYPE REF TO zif_lfet02_model_risikoanalyse.
ENDCLASS.


CLASS zcl_lfet02_rule_risikoanalyse IMPLEMENTATION.
  METHOD execute.
    " Prolog Standard <----

    i_model->trace->inittrace(
        name            = 'Risikoanalyse'
        number_of_rules = '25'
        version         = '20220613.181835' ).

    IF i_model->is_rechtl_rahmenbedingungen( ) = i_model->c_rechtl_rahmenbedingungen-keine.
      IF i_model->is_ressourcen_abhaengigkeit( ) = i_model->c_ressourcen_abhaengigkeit-int1.
        " Rule R01 ---->
        i_model->trace->dotrace( '1' ).
        i_model->do_risikoanalyse( i_model->c_risikoanalyse-nicht_notwendig ).
        " Rule R01 <----
      ELSEIF i_model->is_ressourcen_abhaengigkeit( ) = i_model->c_ressourcen_abhaengigkeit-int2plus.
        IF i_model->is_projektumfang( ) = i_model->c_projektumfang-klein.
          " Rule R02 ---->
          i_model->trace->dotrace( '2' ).
          i_model->do_risikoanalyse( i_model->c_risikoanalyse-nicht_notwendig ).
        ELSEIF i_model->is_projektumfang( ) = i_model->c_projektumfang-mittel.
          " Rule R03 ---->
          i_model->trace->dotrace( '3' ).
          i_model->do_risikoanalyse( i_model->c_risikoanalyse-empfohlen ).
        ELSE.
          " Rule R04 ---->
          i_model->Trace->dotrace( '4' ).
          i_model->do_risikoanalyse( i_model->c_risikoanalyse-empfohlen ).
        ENDIF.
      ELSE.
        " Rule R05 ---->
        i_model->trace->dotrace( '5' ).
        i_model->do_risikoanalyse( i_model->c_risikoanalyse-empfohlen ).

      ENDIF.
    ELSEIF i_model->is_rechtl_rahmenbedingungen( ) = i_model->c_rechtl_rahmenbedingungen-unklar.
      " Rule R06 ---->
      i_model->trace->dotrace( '6' ).
      i_model->do_risikoanalyse( i_model->c_risikoanalyse-empfohlen ).
    ELSE.
      " Rule R07 ---->
      i_model->trace->dotrace( '7' ).
      i_model->do_risikoanalyse( i_model->c_risikoanalyse-notwendig ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
