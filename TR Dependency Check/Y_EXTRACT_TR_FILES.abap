*&---------------------------------------------------------------------*
*& Report  Y_EXTRACT_TR_FILES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT y_extract_tr_files.

TABLES: t071.

DATA: lv_tr TYPE trkorr.

SELECT-OPTIONS: s_trs FOR lv_tr.

PARAMETERS: p_src TYPE sapb-sappfad DEFAULT '\\UWPMBS3009\sapmnt\trans',
            p_trg TYPE sapb-sappfad.

DATA: lv_src TYPE sapb-sappfad,
      lv_trg TYPE sapb-sappfad.

START-OF-SELECTION.

  LOOP AT s_trs INTO DATA(ls_trs).
    lv_src = |{ p_src }\\cofiles\\K{ ls_trs-low+4 }.{ sy-sysid }|.
    lv_trg = |{ p_trg }\\K{ ls_trs-low+4 }.{ sy-sysid }|.
    CALL FUNCTION 'ARCHIVFILE_SERVER_TO_CLIENT'
      EXPORTING
        path             = lv_src
        targetpath       = lv_trg
      EXCEPTIONS
        error_file       = 1
        no_authorization = 2
        OTHERS           = 3.
    IF sy-subrc <> 0.

      WRITE: / |Download Error during { lv_src } to { lv_trg } |.
    ELSE.
      WRITE: / |Downloaded from { lv_src } to { lv_trg } |.
    ENDIF.

    lv_src = |{ p_src }\\data\\R{ ls_trs-low+4 }.{ sy-sysid }|.
    lv_trg = |{ p_trg }\\R{ ls_trs-low+4 }.{ sy-sysid }|.
    CALL FUNCTION 'ARCHIVFILE_SERVER_TO_CLIENT'
      EXPORTING
        path             = lv_src
        targetpath       = lv_trg
      EXCEPTIONS
        error_file       = 1
        no_authorization = 2
        OTHERS           = 3.
    IF sy-subrc <> 0.

      WRITE: / |Download Error during { lv_src } to { lv_trg } |.
    ELSE.
      WRITE: / |Downloaded from { lv_src } to { lv_trg } |.
    ENDIF.

  ENDLOOP.
