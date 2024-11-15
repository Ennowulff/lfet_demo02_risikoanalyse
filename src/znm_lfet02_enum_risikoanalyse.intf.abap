INTERFACE znm_lfet02_enum_risikoanalyse
  PUBLIC.
  TYPES:
    BEGIN OF ENUM enum_risikoanalyse STRUCTURE risikoanalyse,
      "! undefined/ initial value
      undefined,
      "! Eine Risikoanalyse wird empfohlen, ist jedoch nicht zwingend notwendig
      empfohlen,
      "! Eine Risikoanalyse ist nicht notwendig
      nicht_notwendig,
      "! Eine Risikoanalyse ist notwendig
      notwendig,
    END OF ENUM enum_risikoanalyse STRUCTURE risikoanalyse.

  TYPES:
    BEGIN OF ENUM enum_rechtl_rahmenbedingungen STRUCTURE rechtl_rahmenbedingungen,
      undefined,
      "! Es sind keine rechtlichen Rahmenbedingungen zu berücksichtigen
      keine,
      "! Es ist unklar/ nicht geklärt, ob rechtliche Rahmenbedingungen vorhanden sind
      unklar,
      "! Es existieren rechtliche Rahmenbedinungen, die zu berücksichtigen sind
      vorhanden,
    END OF ENUM enum_rechtl_rahmenbedingungen STRUCTURE rechtl_rahmenbedingungen.

  TYPES:
    BEGIN OF ENUM enum_projektumfang STRUCTURE projektumfang,
      klein,
      mittel,
      gross,
    END OF ENUM enum_projektumfang STRUCTURE projektumfang.

  TYPES:
    BEGIN OF ENUM enum_ressourcen_abhaengigkeit STRUCTURE ressourcen_abhaengigkeit,
      "!kein Externer, genau 1 Interner
      int1,
      "!kein Externer, mehr als 1 Interner
      int2plus,
      "!mindestens 1 Extener (Anzahl Interne irrelevant)
      ext1plus,
    END OF ENUM enum_ressourcen_abhaengigkeit STRUCTURE ressourcen_abhaengigkeit.
ENDINTERFACE.
