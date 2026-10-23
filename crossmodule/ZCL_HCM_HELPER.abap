class ZCL_HCM_HELPER definition
  public
  create public .

public section.

  types:
    BEGIN OF personnel_name,
             pernr TYPE co_pernr,
             name  TYPE stext,
           END OF personnel_name .
  types:
    personnel_names TYPE STANDARD TABLE OF personnel_name WITH EMPTY KEY .

  constants GC_MSGID_HCM type SYMSGID value 'ZHCM' ##NO_TEXT.
  constants GC_OTYPE_CNDT type OTYPE value 'NA' ##NO_TEXT.
  constants GC_OTYPE_APLN type OTYPE value 'ND' ##NO_TEXT.
  constants GC_OTYPE_CP type OTYPE value 'CP' ##NO_TEXT.
  constants GC_OTYPE_USER type OTYPE value 'US' ##NO_TEXT.
  constants GC_OTYPE_BP type OTYPE value 'BP' ##NO_TEXT.
  constants GC_OTYPE_P type OTYPE value 'P' ##NO_TEXT.
  constants GC_OTYPE_QUAL type OTYPE value 'Q' ##NO_TEXT.
  constants GC_OTYPE_QUALGRP type OTYPE value 'QK' ##NO_TEXT.
  constants GC_OTYPE_CDCY type OTYPE value 'NE' ##NO_TEXT.
  constants GC_SUBTY_SYUNAME type SUBTY value '0001' ##NO_TEXT.
  constants GC_SUBTY_EMAIL type SUBTY value '0010' ##NO_TEXT.
  constants GC_PLVAR_CURR type PLVAR value '01' ##NO_TEXT.
  constants GC_RELSIGN_TOPDOWN type RSIGN value 'B' ##NO_TEXT.
  constants GC_RELSIGN_BOTUP type RSIGN value 'A' ##NO_TEXT.
  constants GC_RELATION_CP_BP type RELAT value '207' ##NO_TEXT.
  constants GC_RELATION_CP_US type RELAT value '208' ##NO_TEXT.
  constants GC_RELATION_CP_P type RELAT value '209' ##NO_TEXT.
  constants GC_RELATION_CP_CNDT type RELAT value '650' ##NO_TEXT.
  constants GC_RELATION_CNDT_APLN type RELAT value '651' ##NO_TEXT.
  constants GC_RELATION_CNDT_CDCY type RELAT value '656' ##NO_TEXT.
  constants GC_PLSTAT_ACTV type ISTAT_D value '1' ##NO_TEXT.
  constants GC_PAYR_STATUS_CURR type SRTZA value 'A' ##NO_TEXT.
  constants GC_PAYR_STATUS_PREV type SRTZA value 'P' ##NO_TEXT.
  constants GC_PAYR_STATUS_OLD type SRTZA value 'O' ##NO_TEXT.
  class-data GC_CLUSTER_ID_PAYROLL type RELID_PCL2 value 'RW' ##NO_TEXT.
  class-data GT_SALUTATION_TITLES type HRPAYXX_T_T522T .

  class-methods GET_X_Y_REL
    importing
      !IT_OBJID type ECM_T_OBJID optional
      !IT_SOBID type RCF_T_SOBID optional
      !IV_OTYPE type OTYPE
      !IV_SCLAS type SCLAS
    returning
      value(RT_X_TO_Y) type HRP1001_T .
  class-methods GET_PA0105
    importing
      !IV_PERNR type PERNR optional
      !IV_SUBTYPE type SUBTYP optional
      !IV_SAPUSRID type SYSID optional
      !IV_USREMAIL type COMM_ID_LONG optional
      !IR_PERNR type PERSNO_RANGE_TAB optional
      !IR_SAPUSRID type ZRNG_T_SYSID optional
      !IR_USREMAIL type ZRNG_T_USRID_LONG optional
      !IT_PERNR type HRSPP_CDOC_PERNO optional
      !IR_SUBTYPE type ZRNG_T_INFO_SUBTYPE optional
      !IT_SAPUSRID type ZTT_SYSID optional
      !IT_USREMAIL type ZTT_USREMAIL optional
    returning
      value(RT_PA0105) type ZTT_PA0105 .
  class-methods GET_QUA_DESCRIPTIONS
    importing
      !IV_QUA_OTYPE type OTYPE
      !IV_QUA_OBJID type HROBJID
    exporting
      !ES_QUA_DESC type ZST_HCM_QUA_DETAILS .
  class-methods GET_PA0001
    importing
      !IR_PERNR type PERSNO_RANGE_TAB optional
      !IT_PERNR type HRSPP_CDOC_PERNO optional
      !IR_BUKRS type BUKRS_RAN_ITAB optional
      !IR_ABKRS type HRPY_TT_ABKRS optional
    returning
      value(RT_PA0001) type PA0001_ITAB .
  class-methods GET_QUA_CUSTOM_DATA
    changing
      !CT_QUA_PROF type HRPD_PROFQ_TAB .
  class-methods GET_PAYROLL_PERIOD_DATES
    importing
      !IV_ABKRS type T569V-ABKRS
    exporting
      !EV_PERMO type T549A-PERMO
      !EV_BEGDA type T549Q-BEGDA
      !EV_ENDDA type T549Q-ENDDA
      !EV_ABKRS_TEXT type T549T-ATEXT
    changing
      !CV_PERIOD type T569V-PABRP
      !CV_YEAR type T569V-PABRJ .
  class-methods GET_PAYROLL_RGDIR
    importing
      !IT_PERNR type PERNR_TAB optional
      !IV_PERNR type PERNR_D optional
      !IV_NO_AUTHORITY_CHECK type BOOLE_D default SPACE
    exporting
      !EV_MOLGA type T500L-MOLGA
      !ET_PERNR_X_RGDIR type ZHCM_TT_PERNR_RGDIR .
  class-methods GET_PAYROLL_RESULT
    importing
      !IV_CLUSTERID type PCL2-RELID
      !IV_READ_ONLY_BUFFER type BOOLE_D default ABAP_FALSE
      !IV_READ_ONLY_INTERNATIONAL type BOOLE_D default ABAP_FALSE
      !IV_ARC_GROUP type ARC_GROUP optional
      !IV_CHECK_READ_AUTHORITY type BOOLE_D default ABAP_TRUE
      !IV_FILTER_CUMULATIONS type BOOLE_D default ABAP_TRUE
      !IV_CLIENT type PCL2-CLIENT optional
      !IV_PERNR type PERNR_D optional
      !IT_INPUTS type ZHCM_TT_PERNR_PAYR_INPUTS optional
      !IT_SEQNR type ZHCM_TT_CDSEQ optional
    exporting
      !ET_PAYROLL_RESULT type ZHCM_TT_PERNR_PAYR_RESULTS .
  class-methods GET_PA0002
    importing
      !IT_PERNR type PERNR_TAB
    exporting
      !ET_PA0002 type ZHCM_TT_PA0002 .
  class-methods CLASS_CONSTRUCTOR .
  class-methods GET_EMPLOYEE_NAMES
    importing
      !PERSONNEL_NUMBERS type IST_NLM_EMPLOY_T optional
      !PERSONNEL_NUMBER type CO_PERNR optional
    returning
      value(PERSONNEL_NAMES) type PERSONNEL_NAMES .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HCM_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>CLASS_CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD class_constructor.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Fill in globally used data                              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-20 Apr 2026
    SELECT * FROM t522t
             INTO TABLE gt_salutation_titles
             WHERE
              sprsl = sy-langu.
*<<<End of Changes-ASDTGG-PASDI-JASDO-20 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_EMPLOYEE_NAMES
* +-------------------------------------------------------------------------------------------------+
* | [--->] PERSONNEL_NUMBERS              TYPE        IST_NLM_EMPLOY_T(optional)
* | [--->] PERSONNEL_NUMBER               TYPE        CO_PERNR(optional)
* | [<-()] PERSONNEL_NAMES                TYPE        PERSONNEL_NAMES
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_employee_names.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date: 20 May 2026                                                    *
* Reference Change/Incident: ASDTGG                                *
* Change Indicator: ASDTGG-JASDO-PASDI                         *
* Description: Get names of employees                                  *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-JASDO-PASDI-29 May 2026
    DATA: personnel_name TYPE stext.
    DATA(personnel_numbers_lcl_001) = personnel_numbers.

    IF personnel_number IS NOT INITIAL.
      APPEND personnel_number TO personnel_numbers_lcl_001.
    ENDIF.

    SORT personnel_numbers_lcl_001 BY table_line ASCENDING.
    DELETE ADJACENT DUPLICATES FROM personnel_numbers_lcl_001 COMPARING table_line.

    LOOP AT personnel_numbers_lcl_001 INTO DATA(personnel_number_lcl).

      DATA(objid) = CONV hrobjid( personnel_number_lcl ).

      CLEAR: personnel_name.
      CALL FUNCTION 'RH_READ_OBJECT'
        EXPORTING
          plvar     = '01'
          otype     = 'P'
          objid     = objid
          istat     = '1'
          begda     = sy-datum
          endda     = sy-datum
          langu     = sy-langu
        IMPORTING
*         SHORT     = ls_short
          stext     = personnel_name
        EXCEPTIONS
          not_found = 1
          OTHERS    = 2.
      IF personnel_name IS NOT INITIAL.
        personnel_names = VALUE #( BASE personnel_names
          (
            pernr = personnel_number_lcl
            name  = personnel_name
          )
        ).
      ENDIF.

    ENDLOOP.

*<<<End of Changes-ASDTGG-JASDO-PASDI-29 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_PA0001
* +-------------------------------------------------------------------------------------------------+
* | [--->] IR_PERNR                       TYPE        PERSNO_RANGE_TAB(optional)
* | [--->] IT_PERNR                       TYPE        HRSPP_CDOC_PERNO(optional)
* | [--->] IR_BUKRS                       TYPE        BUKRS_RAN_ITAB(optional)
* | [--->] IR_ABKRS                       TYPE        HRPY_TT_ABKRS(optional)
* | [<-()] RT_PA0001                      TYPE        PA0001_ITAB
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_pa0001.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Retrieve PA0001 records for given personnel             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
    DATA: lt_pernr TYPE hrspp_cdoc_perno,
          lt_bukrs TYPE t_bukrs.
    IF ir_pernr[] IS NOT INITIAL.
      "Check if any complext items are present in the range
      "We can transfer the entries to an internal table so SAP does
      "not impose the 10K entry limit
      LOOP AT ir_pernr TRANSPORTING NO FIELDS
              WHERE
                sign NE 'I' OR
                option NE 'EQ'.
        EXIT.
      ENDLOOP.
      IF sy-subrc <> 0.
        lt_pernr = VALUE #(
        FOR lr_pernr IN ir_pernr
        (
          lr_pernr-low
        )
        ).
      ELSE.


      ENDIF.
    ELSE.
      lt_pernr[] = it_pernr[].
    ENDIF.

    IF lt_pernr[] IS NOT INITIAL.
      SORT lt_pernr.
      DELETE lt_pernr WHERE table_line IS INITIAL.
      DELETE ADJACENT DUPLICATES FROM lt_pernr COMPARING ALL FIELDS.
      IF lt_pernr[] IS NOT INITIAL.
        SELECT * FROM pa0001
                 INTO TABLE @rt_pa0001
                 FOR ALL ENTRIES IN @lt_pernr
                 WHERE
                  pernr = @lt_pernr-table_line AND
                  bukrs IN @ir_bukrs AND
                  abkrs IN @ir_abkrs.
      ENDIF.
    ELSEIF ir_pernr[] IS NOT INITIAL.
      SELECT * FROM pa0001
               INTO TABLE @rt_pa0001
               WHERE
                pernr IN @ir_pernr AND
                bukrs IN @ir_bukrs AND
                abkrs IN @ir_abkrs.
    ELSEIF ir_bukrs[] IS NOT INITIAL OR "Company code and/or Payroll Area provided as input
           ir_abkrs[] IS NOT INITIAL.
      SELECT * FROM pa0001
               INTO TABLE @rt_pa0001
               WHERE
                bukrs IN @ir_bukrs AND
                abkrs IN @ir_abkrs.
    ENDIF.

*<<<End of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_PA0002
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_PERNR                       TYPE        PERNR_TAB
* | [<---] ET_PA0002                      TYPE        ZHCM_TT_PA0002
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_pa0002.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Retrieve and return Personal Details                    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-31st Mar 2026
    IF it_pernr[] IS NOT INITIAL.
      SELECT * FROM pa0002
               INTO TABLE et_pa0002
               FOR ALL ENTRIES IN it_pernr
               WHERE
                pernr = it_pernr-table_line.
    ENDIF.
*<<<End of Changes-ASDTGG-PASDI-JASDO-31st Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_PA0105
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_PERNR                       TYPE        PERNR(optional)
* | [--->] IV_SUBTYPE                     TYPE        SUBTYP(optional)
* | [--->] IV_SAPUSRID                    TYPE        SYSID(optional)
* | [--->] IV_USREMAIL                    TYPE        COMM_ID_LONG(optional)
* | [--->] IR_PERNR                       TYPE        PERSNO_RANGE_TAB(optional)
* | [--->] IR_SAPUSRID                    TYPE        ZRNG_T_SYSID(optional)
* | [--->] IR_USREMAIL                    TYPE        ZRNG_T_USRID_LONG(optional)
* | [--->] IT_PERNR                       TYPE        HRSPP_CDOC_PERNO(optional)
* | [--->] IR_SUBTYPE                     TYPE        ZRNG_T_INFO_SUBTYPE(optional)
* | [--->] IT_SAPUSRID                    TYPE        ZTT_SYSID(optional)
* | [--->] IT_USREMAIL                    TYPE        ZTT_USREMAIL(optional)
* | [<-()] RT_PA0105                      TYPE        ZTT_PA0105
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_PA0105.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: HUB Method: Usage Statistics Report                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026

    DATA: lr_pernr    TYPE persno_range_tab,
          lr_subtype  TYPE zrng_t_info_subtype,
          lr_sapusrid	TYPE zrng_t_sysid,
          lr_usremail	TYPE zrng_t_usrid_long.

    "Fill in ranges based on inputs
    IF ir_subtype[] IS INITIAL.
      IF iv_subtype IS NOT INITIAL.
        lr_subtype = VALUE zrng_t_info_subtype(
        ( sign = 'I' option = 'EQ' low = iv_subtype )
        ).
      ENDIF.
    ELSE.
      lr_subtype[] = ir_subtype[].
    ENDIF.

    IF ir_pernr[] IS INITIAL.
      IF iv_pernr IS NOT INITIAL.
        lr_pernr = VALUE persno_range_tab(
        ( sign = 'I' option = 'EQ' low = iv_pernr )
        ).
      ENDIF.
    ELSE.
      lr_pernr[] = ir_pernr[].
    ENDIF.

    IF ir_sapusrid[] IS INITIAL.
      IF iv_sapusrid IS NOT INITIAL.
        lr_sapusrid = VALUE zrng_t_sysid(
        ( sign = 'I' option = 'EQ' low = iv_sapusrid )
        ).
      ENDIF.
    ELSE.
      lr_sapusrid[] = ir_sapusrid[].
    ENDIF.

    IF ir_usremail[] IS INITIAL.
      IF iv_usremail IS NOT INITIAL.
        lr_usremail = VALUE zrng_t_usrid_long(
        ( sign = 'I' option = 'EQ' low = iv_usremail )
        ).
      ENDIF.
    ELSE.
      lr_usremail[] = ir_usremail[].
    ENDIF.



    IF it_pernr[] IS NOT INITIAL. "A list of Personnel numbers are provided
      "Retrieve requested details linked to the Personnel
      SELECT * FROM pa0105
               INTO TABLE rt_pa0105
               FOR ALL ENTRIES IN it_pernr
               WHERE
                pernr EQ it_pernr-table_line AND
                subty IN lr_subtype AND
                usrid IN lr_sapusrid AND
                usrid_long IN lr_usremail.
    ELSEIF it_sapusrid[] IS NOT INITIAL. "A list of SAP User IDs are provided
      "Retrieve requested Personnel records linked to the SAP User IDs
      SELECT * FROM pa0105
               INTO TABLE rt_pa0105
               FOR ALL ENTRIES IN it_sapusrid
               WHERE
                pernr IN lr_pernr AND
                subty IN lr_subtype AND
                usrid EQ it_sapusrid-table_line AND
                usrid_long IN lr_usremail.
    ELSEIF it_usremail[] IS NOT INITIAL. "A list of EMAIL IDs are provided
      "Retrieve requested Personnel records linked to the EMAIL IDs
      SELECT * FROM pa0105
               INTO TABLE rt_pa0105
               FOR ALL ENTRIES IN it_usremail
               WHERE
                pernr IN lr_pernr AND
                subty IN lr_subtype AND
                usrid IN lr_sapusrid AND
                usrid_long EQ it_usremail-table_line.
    ELSE."If no tables were provided, but ranges might have been provided
      SELECT * FROM pa0105
               INTO TABLE rt_pa0105
               WHERE
                pernr IN lr_pernr AND
                subty IN lr_subtype AND
                usrid IN lr_sapusrid AND
                usrid_long IN lr_usremail.
    ENDIF.
*<<<End of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_PAYROLL_PERIOD_DATES
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_ABKRS                       TYPE        T569V-ABKRS
* | [<---] EV_PERMO                       TYPE        T549A-PERMO
* | [<---] EV_BEGDA                       TYPE        T549Q-BEGDA
* | [<---] EV_ENDDA                       TYPE        T549Q-ENDDA
* | [<---] EV_ABKRS_TEXT                  TYPE        T549T-ATEXT
* | [<-->] CV_PERIOD                      TYPE        T569V-PABRP
* | [<-->] CV_YEAR                        TYPE        T569V-PABRJ
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_payroll_period_dates.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Compare employee payroll based on given inputs          *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-18th Mar 2026
    CALL FUNCTION 'PA03_PERIODDATES_GET'
      EXPORTING
        f_abkrs               = iv_abkrs
      IMPORTING
        f_permo               = ev_permo
        f_current_begda       = ev_begda
        f_current_endda       = ev_endda
        f_abkrs_text          = ev_abkrs_text
      CHANGING
        f_current_period      = cv_period
        f_current_year        = cv_year
      EXCEPTIONS
        pcr_does_not_exist    = 1
        abkrs_does_not_exist  = 2
        period_does_not_exist = 3
        OTHERS                = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

*<<<End of Changes-ASDTGG-PASDI-JASDO-18th Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_PAYROLL_RESULT
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_CLUSTERID                   TYPE        PCL2-RELID
* | [--->] IV_READ_ONLY_BUFFER            TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] IV_READ_ONLY_INTERNATIONAL     TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] IV_ARC_GROUP                   TYPE        ARC_GROUP(optional)
* | [--->] IV_CHECK_READ_AUTHORITY        TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] IV_FILTER_CUMULATIONS          TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] IV_CLIENT                      TYPE        PCL2-CLIENT(optional)
* | [--->] IV_PERNR                       TYPE        PERNR_D(optional)
* | [--->] IT_INPUTS                      TYPE        ZHCM_TT_PERNR_PAYR_INPUTS(optional)
* | [--->] IT_SEQNR                       TYPE        ZHCM_TT_CDSEQ(optional)
* | [<---] ET_PAYROLL_RESULT              TYPE        ZHCM_TT_PERNR_PAYR_RESULTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_payroll_result.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Retrieve and return payroll results for the given pernr *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-27th Mar 2026
    DATA: ls_result_za TYPE payza_result,

          lt_result_za TYPE zhcm_tt_payza_result,
          lt_inputs    TYPE zhcm_tt_pernr_payr_inputs.

    lt_inputs = it_inputs.

    IF iv_pernr IS NOT INITIAL.
      lt_inputs = VALUE #( BASE lt_inputs
      (
        pernr = iv_pernr
        t_seq = it_seqnr
      )
      ).
    ENDIF.

    LOOP AT lt_inputs INTO DATA(ls_input)."For every person
      REFRESH: lt_result_za.
      LOOP AT ls_input-t_seq INTO DATA(ls_seq)."For every sequence requested
        CLEAR: ls_result_za.
        CALL FUNCTION 'PYXX_READ_PAYROLL_RESULT' "Retrieve the payroll results
          EXPORTING
            clusterid                    = iv_clusterid
            employeenumber               = ls_input-pernr
            sequencenumber               = ls_seq
            read_only_buffer             = iv_read_only_buffer
            read_only_international      = iv_read_only_international
            arc_group                    = iv_arc_group
            check_read_authority         = iv_check_read_authority
            filter_cumulations           = iv_filter_cumulations
            client                       = iv_client
* IMPORTING
*           VERSION_NUMBER_PAYVN         =
*           VERSION_NUMBER_PCL2          =
          CHANGING
            payroll_result               = ls_result_za
          EXCEPTIONS
            illegal_isocode_or_clusterid = 1
            error_generating_import      = 2
            import_mismatch_error        = 3
            subpool_dir_full             = 4
            no_read_authority            = 5
            no_record_found              = 6
            versions_do_not_match        = 7
            error_reading_archive        = 8
            error_reading_relid          = 9
            OTHERS                       = 10.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        "Sequence number seems empty in the returned output
        "So force update it
        ls_result_za-evp-seqnr = ls_seq.
        APPEND ls_result_za TO lt_result_za.
      ENDLOOP.
      et_payroll_result = VALUE #( BASE et_payroll_result
      (
        pernr = ls_input-pernr
        t_payr_results_hrpayza = lt_result_za
      )
      ).

      REFRESH: lt_result_za.
    ENDLOOP.

*<<<End of Changes-ASDTGG-PASDI-JASDO-27th Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_PAYROLL_RGDIR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_PERNR                       TYPE        PERNR_TAB(optional)
* | [--->] IV_PERNR                       TYPE        PERNR_D(optional)
* | [--->] IV_NO_AUTHORITY_CHECK          TYPE        BOOLE_D (default =SPACE)
* | [<---] EV_MOLGA                       TYPE        T500L-MOLGA
* | [<---] ET_PERNR_X_RGDIR               TYPE        ZHCM_TT_PERNR_RGDIR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_payroll_rgdir.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Retrieve RGDIR Cluster Information                      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-27th Mar 2026
    DATA: lv_molga TYPE molga,
          lt_pernr TYPE pernr_tab,
          lt_rgdir TYPE hrpy_tt_rgdir.

    lt_pernr = it_pernr.

    IF iv_pernr IS NOT INITIAL.
      APPEND iv_pernr TO lt_pernr.
    ENDIF.


    "<TBD> Future performance improvement using parallel processing

    LOOP AT lt_pernr INTO DATA(ls_pernr)."For every personnel
      CLEAR: lv_molga.
      REFRESH: lt_rgdir.
      CALL FUNCTION 'CU_READ_RGDIR' "Read the RGDIR cluster
        EXPORTING
          persnr             = ls_pernr
*         BUFFER             =
          no_authority_check = iv_no_authority_check
        IMPORTING
          molga              = lv_molga
        TABLES
          in_rgdir           = lt_rgdir
*       EXCEPTIONS
*         NO_RECORD_FOUND    = 1
*         OTHERS             = 2
        .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      et_pernr_x_rgdir = VALUE #( BASE et_pernr_x_rgdir
        (
          pernr = ls_pernr
          molga = lv_molga
          t_rgdir = lt_rgdir
        )
      )."Accumulate the cluster information into a single itab, identifiable using the corresponding pernr

    ENDLOOP.

*<<<End of Changes-ASDTGG-PASDI-JASDO-27th Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_QUA_CUSTOM_DATA
* +-------------------------------------------------------------------------------------------------+
* | [<-->] CT_QUA_PROF                    TYPE        HRPD_PROFQ_TAB
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_qua_custom_data.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      18th Sep 2025                                             *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: Get custom data related to the given employee qual.     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-13th Feb 2026

    DATA: lt_zhr_quali_crit TYPE STANDARD TABLE OF zhr_quali.

    DATA(lt_qua_prof) = ct_qua_prof.

    SORT lt_qua_prof BY sobid
                        ttype
                        tbjid
                        vbegd
                        vendd.

    DELETE lt_qua_prof WHERE sobid IS INITIAL AND
                             ttype IS INITIAL AND
                             tbjid IS INITIAL AND
                             vbegd IS INITIAL AND
                             vendd IS INITIAL.


    DELETE ADJACENT DUPLICATES FROM lt_qua_prof COMPARING sobid
                                                          ttype
                                                          tbjid
                                                          vbegd
                                                          vendd.

    IF lt_qua_prof[] IS NOT INITIAL.
      "Convert the inputs to the correct format
      lt_zhr_quali_crit = VALUE #(
        FOR ls_qua_prof IN lt_qua_prof
        (
        pernr = ls_qua_prof-sobid
        ttype = ls_qua_prof-ttype
        tbjid = ls_qua_prof-tbjid
        vbegd = ls_qua_prof-vbegd
        vendd = ls_qua_prof-vendd
        )
      ).

      "Get all corresponding details from the custom table
      SELECT * FROM zhr_quali
               INTO TABLE @DATA(lt_zhr_quali)
               FOR ALL ENTRIES IN @lt_zhr_quali_crit
                      WHERE pernr = @lt_zhr_quali_crit-pernr
                        AND ttype = @lt_zhr_quali_crit-ttype
                        AND tbjid = @lt_zhr_quali_crit-tbjid
                        AND vbegd = @lt_zhr_quali_crit-vbegd
                        AND vendd = @lt_zhr_quali_crit-vendd.

      LOOP AT ct_qua_prof ASSIGNING FIELD-SYMBOL(<lfs_qua_prof>)."For every qualification profile passed in
        IF line_exists( lt_zhr_quali[
            pernr = <lfs_qua_prof>-sobid
            ttype = <lfs_qua_prof>-ttype
            tbjid = <lfs_qua_prof>-tbjid
            vbegd = <lfs_qua_prof>-vbegd
            vendd = <lfs_qua_prof>-vendd
          ] )."If an entry is present in custom table
          "Retrieve the Institute and Highest qualification flag
          DATA(ls_zhr_quali) = lt_zhr_quali[
            pernr = <lfs_qua_prof>-sobid
            ttype = <lfs_qua_prof>-ttype
            tbjid = <lfs_qua_prof>-tbjid
            vbegd = <lfs_qua_prof>-vbegd
            vendd = <lfs_qua_prof>-vendd
          ].
          <lfs_qua_prof>-inst = ls_zhr_quali-inst.
          <lfs_qua_prof>-high = ls_zhr_quali-high.

        ENDIF.
      ENDLOOP.


    ENDIF.

*<<<End of Changes-ASDTGG-PASDI-JASDO-13th Feb 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_QUA_DESCRIPTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_QUA_OTYPE                   TYPE        OTYPE
* | [--->] IV_QUA_OBJID                   TYPE        HROBJID
* | [<---] ES_QUA_DESC                    TYPE        ZST_HCM_QUA_DETAILS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_QUA_DESCRIPTIONS.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: HUB Method: Usage Statistics Report                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
    DATA: lt_1002             TYPE pt1002_tab.


    es_qua_desc-otype = iv_qua_otype.
    es_qua_desc-objid = iv_qua_objid.

    IF iv_qua_objid IS NOT INITIAL.
      "Get the text maintained for qualification as per HRP1002/HRT1002
      CALL FUNCTION 'RH_OBJECT_DESCRIPTION_READ'
        EXPORTING
          plvar         = gc_plvar_curr
          otype         = iv_qua_otype
          objid         = iv_qua_objid
        TABLES
          ptxt1002      = lt_1002[]
        EXCEPTIONS
          nothing_found = 1
          infty_empty   = 2
          undefined     = 3
          OTHERS        = 4.

      DELETE lt_1002 WHERE tline IS INITIAL. "Delete entries with Empty description
      IF lt_1002[] IS NOT INITIAL .

        es_qua_desc-tline = lt_1002[ 1 ]-tline.
      ELSE.
        "If nothing maintained in HRP1002/HRT1002
        "Check the description from HRP1000
        SELECT endda, short, stext, seqnr
               FROM   hrp1000
               INTO  TABLE @DATA(lt_hrp1000)
               WHERE
                plvar = @gc_plvar_curr AND
                otype = @iv_qua_otype AND
                objid = @iv_qua_objid AND
                istat = @gc_plstat_actv AND
                begda <= @sy-datum AND
                endda >= @sy-datum AND
                langu = @sy-langu.
        IF lt_hrp1000[] IS NOT INITIAL."Data found in HRP1000
          SORT lt_hrp1000 BY endda DESCENDING seqnr DESCENDING."Get the latest entry
          DATA(ls_hrp1000) = lt_hrp1000[ 1 ].
          MOVE-CORRESPONDING ls_hrp1000 TO es_qua_desc.
        ELSE."Data not found in HRP1000
          es_qua_desc-short = iv_qua_objid.
          es_qua_desc-stext = iv_qua_objid.
        ENDIF.
      ENDIF.
    ELSE."Input Object ID is empty

    ENDIF.
*<<<End of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_X_Y_REL
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_OBJID                       TYPE        ECM_T_OBJID(optional)
* | [--->] IT_SOBID                       TYPE        RCF_T_SOBID(optional)
* | [--->] IV_OTYPE                       TYPE        OTYPE
* | [--->] IV_SCLAS                       TYPE        SCLAS
* | [<-()] RT_X_TO_Y                      TYPE        HRP1001_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_X_Y_REL.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (JASDO)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  ASDTGG                               *
* Change Indicator: ASDTGG-PASDI-JASDO                         *
* Description: HUB Method: Usage Statistics Report                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
    "Retrieve the Requested relations from HRP1001
    IF it_objid[] IS NOT INITIAL."If object IDs are provided
      "Get related sub-object IDs
      SELECT * FROM hrp1001
               INTO TABLE @rt_x_to_y
               FOR ALL ENTRIES IN @it_objid
               WHERE
                otype = @iv_otype AND
                objid = @it_objid-table_line AND
                plvar = @gc_plvar_curr AND
                istat = @gc_plstat_actv AND
                sclas = @iv_sclas.
    ELSEIF it_sobid[] IS NOT INITIAL."If sub object IDs are provided
      "Get the related object IDs
      SELECT * FROM hrp1001
               INTO TABLE @rt_x_to_y
               FOR ALL ENTRIES IN @it_sobid
               WHERE
                otype = @iv_otype AND
                plvar = @gc_plvar_curr AND
                istat = @gc_plstat_actv AND
                sclas = @iv_sclas AND
                sobid = @it_sobid-table_line.
    ENDIF.
*<<<End of Changes-ASDTGG-PASDI-JASDO-26th Jan 2026
  ENDMETHOD.
ENDCLASS.
