class ZCL_EREC_HELPER definition
  public
  create public .

public section.

  types:
    range_objid TYPE RANGE OF hrobjid .
  types:
    BEGIN OF line_recruitment_team.
            INCLUDE TYPE hrikey.
    TYPES: role     TYPE rcf_role,
           role_txt TYPE rcf_role_txt,
           sclas    TYPE sclas,
           sobid    TYPE sobid,
           pernr    TYPE pernr_d,
           fullname TYPE bu_name1tx,
           lead     TYPE rcf_lead,
           id       TYPE int4,
           email    TYPE comm_id_long,
           END OF line_recruitment_team .
  types:
    tt_recruitment_team TYPE STANDARD TABLE OF line_recruitment_team WITH EMPTY KEY .
  types:
    range_dates TYPE RANGE OF dats .

  constants GC_OTYPE_APLN type OTYPE value 'ND' ##NO_TEXT.
  constants GC_OTYPE_BP type OTYPE value 'BP' ##NO_TEXT.
  constants GC_OTYPE_CDCY type OTYPE value 'NE' ##NO_TEXT.
  constants GC_OTYPE_CNDT type OTYPE value 'NA' ##NO_TEXT.
  constants GC_OTYPE_CP type OTYPE value 'CP' ##NO_TEXT.
  constants GC_OTYPE_P type OTYPE value 'P' ##NO_TEXT.
  constants GC_OTYPE_QUAL type OTYPE value 'Q' ##NO_TEXT.
  constants GC_OTYPE_QUALGRP type OTYPE value 'QK' ##NO_TEXT.
  constants GC_OTYPE_USER type OTYPE value 'US' ##NO_TEXT.
  constants GC_PLSTAT_ACTV type ISTAT_D value '1' ##NO_TEXT.
  constants GC_PLVAR_CURR type PLVAR value '01' ##NO_TEXT.
  constants GC_RELATION_CNDT_APLN type RELAT value '651' ##NO_TEXT.
  constants GC_RELATION_CNDT_CDCY type RELAT value '656' ##NO_TEXT.
  constants GC_RELATION_CP_BP type RELAT value '207' ##NO_TEXT.
  constants GC_RELATION_CP_CNDT type RELAT value '650' ##NO_TEXT.
  constants GC_RELATION_CP_P type RELAT value '209' ##NO_TEXT.
  constants GC_RELATION_CP_US type RELAT value '208' ##NO_TEXT.
  constants GC_RELSIGN_BOTUP type RSIGN value 'A' ##NO_TEXT.
  constants GC_RELSIGN_TOPDOWN type RSIGN value 'B' ##NO_TEXT.
  constants GC_SUBTY_EMAIL type SUBTY value '0010' ##NO_TEXT.
  constants GC_SUBTY_SYUNAME type SUBTY value '0001' ##NO_TEXT.
  class-data GV_C_EVPATH_ORG_STR type WEGID value 'ORGA-UP' ##NO_TEXT.
  class-data GV_C_OTY_ORGN type OTYPE value 'O' ##NO_TEXT.
  class-data GV_C_OTY_POSN type OTYPE value 'S' ##NO_TEXT.
  class-data GV_C_OTY_POST type OTYPE value 'NC' ##NO_TEXT.
  class-data GV_C_OTY_REQN type OTYPE value 'NB' ##NO_TEXT.
  class-data GV_C_PLVR_ACTIVE type PLVAR value '01' ##NO_TEXT.
  class-data GV_C_REL_BELONGS_TO type RELAT value '003' ##NO_TEXT.
  class-data GV_C_REL_OCCUP_BY type RELAT value '657' ##NO_TEXT.
  class-data GV_C_REL_POSTS type RELAT value '652' ##NO_TEXT.
  class-data GV_C_RSIGN_BOT_UP type RSIGN value 'A' ##NO_TEXT.
  class-data GV_C_RSIGN_TOP_DWN type RSIGN value 'B' ##NO_TEXT.
  class-data GV_C_VARNAME_COM2_ABBR type RVARI_VNAM value 'Z_ABBR_COM2' ##NO_TEXT.
  constants REQN_STATUS_DRAFT type RCF_REQUISITION_STATUS value '0' ##NO_TEXT.
  constants REQN_STATUS_RELEASED type RCF_REQUISITION_STATUS value '1' ##NO_TEXT.
  constants REQN_STATUS_CLOSED type RCF_REQUISITION_STATUS value '2' ##NO_TEXT.
  constants REQN_STATUS_TO_BE_DELETED type RCF_REQUISITION_STATUS value '3' ##NO_TEXT.
  constants REQN_STATUS_ON_HOLD type RCF_REQUISITION_STATUS value '4' ##NO_TEXT.
  constants POST_STATUS_DRAFT type RCF_POST_DOC_STAT value '0' ##NO_TEXT.
  constants POST_STATUS_RELEASED type RCF_POST_DOC_STAT value '1' ##NO_TEXT.
  constants POST_STATUS_WITHDRAWN type RCF_POST_DOC_STAT value '2' ##NO_TEXT.
  constants POST_STATUS_EXPIRED type RCF_POST_DOC_STAT value '3' ##NO_TEXT.

  class-methods GET_POST_REQN_COMP_FROM_POSN
    importing
      !IV_REQN type HROBJID optional
      !IV_POST type HROBJID optional
    exporting
      !EV_POSN_COMPANY type SHORT_D .
  class-methods GET_COM2_ORG_ABBR
    exporting
      !EV_ABBR_COM2 type SHORT_D .
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
      !ES_QUA_DESC type ZST_EREC_QUA_DETAILS .
  class-methods GET_QUA_DETAILS_HR
    importing
      !IV_PERNR type PERNR optional
      !IT_PERNR type HRSPP_CDOC_PERNO optional
      !BEGDA type HRP1000-BEGDA default SY-DATUM
      !ENDDA type HRP1000-ENDDA default SY-DATUM
      !IR_AEDTM type FIP_T_AEDAT_RANGE optional
      !WITH_STEXT type CHAR1 default 'X'
      !WITH_QK_INFO type CHAR1 default 'X'
      !CHECK_NOTE type CHAR1 default ' '
      !OBJECTS type HRTB_SOBID optional
      !ERR_OBJECTS type HRTB_SOBID optional
    exporting
      !PROFILE type ZEREC_TT_HRPE_PROFQ
      !ET_HRP5105 type ZTT_HRP5105
    raising
      ZCX_GEN_EXCEPTION .
  class-methods GET_REQUISITIONS
    importing
      !CLOSE_DATES type RANGE_DATES optional
      !REQUISITION_IDS type ECM_T_OBJID optional
      !GET_JOB_DESCRIPTION type BOOLE_D default ABAP_FALSE
      !GET_SUPPORT_TEAM type BOOLE_D default ABAP_FALSE
    exporting
      !REQUISITION_LIST type ZTT_HRP5125
      !JOB_DESCRIPTIONS type ZTT_HRP5126
      !RECRUITMENT_TEAM type TT_RECRUITMENT_TEAM .
  class-methods GET_JOB_DESCRIPTIONS
    importing
      !REQUISITION_LIST type ZTT_HRP5125
    returning
      value(JOB_DESCRIPTIONS) type ZTT_HRP5126 .
  class-methods GET_RECRUITMENT_TEAM
    importing
      !REQUISITION_LIST type ZTT_HRP5125
    returning
      value(RECRUITMENT_TEAM) type TT_RECRUITMENT_TEAM .
  class-methods GET_POSTINGS
    importing
      !END_DATES type RANGE_DATES optional
      !POSTING_IDS type ECM_T_OBJID optional
    exporting
      !POSTINGS type ZTT_HRP5122 .
  class-methods GET_HR_RFC_DESTINATION
    returning
      value(DESTINATION) type GSVAL .
protected section.
private section.

  class-data GC_GRPID_RFC_HR type GRPID value 'RECFA' ##NO_TEXT.
  class-data GC_SEMID_RFC_HR type SEMID value 'HRRFC' ##NO_TEXT.
ENDCLASS.



CLASS ZCL_EREC_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_HR_RFC_DESTINATION
* +-------------------------------------------------------------------------------------------------+
* | [<-()] DESTINATION                    TYPE        GSVAL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_hr_rfc_destination.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Get the RFC Destination to HR system                    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-15 Oct 2026
    SELECT SINGLE gsval FROM t77s0
                 INTO @destination
                 WHERE
                  grpid = @gc_grpid_rfc_hr  AND
                  semid = @gc_semid_rfc_hr.
*<<<End of Changes-BASDO-NASDO-BNASDO-15 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_JOB_DESCRIPTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUISITION_LIST               TYPE        ZTT_HRP5125
* | [<-()] JOB_DESCRIPTIONS               TYPE        ZTT_HRP5126
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_job_descriptions.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Get the job descriptions                                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-07 Sep 2026
    IF requisition_list IS NOT INITIAL.
      SELECT * FROM hrp5126
               INTO TABLE @job_descriptions
               FOR ALL ENTRIES IN @requisition_list
               WHERE
                objid = @requisition_list-objid.
    ENDIF.
*<<<End of Changes-BASDO-NASDO-BNASDO-07 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_PA0105
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
  METHOD get_pa0105.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      18th Sep 2025                                             *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Get 0105 Comms records based on Personnel/SAP ID/Email  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-13th Oct 2025

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
*<<<End of Changes-BASDO-NASDO-BNASDO-13th Oct 2025
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_POSTINGS
* +-------------------------------------------------------------------------------------------------+
* | [--->] END_DATES                      TYPE        RANGE_DATES(optional)
* | [--->] POSTING_IDS                    TYPE        ECM_T_OBJID(optional)
* | [<---] POSTINGS                       TYPE        ZTT_HRP5122
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_postings.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Return a list of postings meeting criteria              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-11 Sep 2026
    IF posting_ids IS NOT  INITIAL.
      DATA(posting_ids_lcl) = posting_ids.
    ENDIF.

    SORT posting_ids_lcl BY table_line.
    DELETE posting_ids_lcl WHERE table_line IS INITIAL.
    DELETE ADJACENT DUPLICATES FROM posting_ids_lcl COMPARING table_line.

    IF posting_ids_lcl IS NOT INITIAL.
      SELECT * FROM hrp5122
               INTO TABLE @postings
               FOR ALL ENTRIES IN @posting_ids_lcl
               WHERE
                objid    EQ @posting_ids_lcl-table_line AND
                end_date IN @end_dates.
    ELSE.
      SELECT * FROM hrp5122
               INTO TABLE @postings
               WHERE
                end_date IN @end_dates.
    ENDIF.

*<<<End of Changes-BASDO-NASDO-BNASDO-11 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_POST_REQN_COMP_FROM_POSN
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_REQN                        TYPE        HROBJID(optional)
* | [--->] IV_POST                        TYPE        HROBJID(optional)
* | [<---] EV_POSN_COMPANY                TYPE        SHORT_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_post_reqn_comp_from_posn.
*&---------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      14th Apr 2025                                             *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-14th Apr 2025-NASDO                    *
* Description: Update EREC forms for COM2                               *
*              Get the company to which the Posting/Requisition belongs*
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

    DATA: lv_reqn          TYPE hrobjid,

          lt_posn_key_cast TYPE STANDARD TABLE OF hrobjid,
          lt_org_structure TYPE objec_t.


    IF iv_reqn IS NOT INITIAL.
      "Use the reqn. number passed in
      lv_reqn = iv_reqn.
    ELSE.
      "Find the requisition related to the posting
      SELECT SINGLE sobid
             FROM hrp1001
             INTO @DATA(lv_reqn_sobid)
             WHERE
              otype = @gv_c_oty_post AND
              objid = @iv_post AND
              plvar = @gv_c_plvr_active AND
              rsign = @gv_c_rsign_bot_up AND
              relat = @gv_c_rel_posts AND
              begda <= @sy-datum AND
              endda >= @sy-datum AND
              sclas = @gv_c_oty_reqn.
      IF sy-subrc = 0.
        lv_reqn = lv_reqn_sobid.
      ENDIF.
    ENDIF.
    IF lv_reqn IS NOT INITIAL.
      "Find the positions linked to the requisitions
      SELECT sobid
             FROM hrp1001
             INTO TABLE @DATA(lt_posn)
             WHERE
              otype = @gv_c_oty_reqn AND
              objid = @lv_reqn AND
              plvar = @gv_c_plvr_active AND
              rsign = @gv_c_rsign_top_dwn AND
              relat = @gv_c_rel_occup_by AND
              begda <= @sy-datum AND
              endda >= @sy-datum AND
              sclas = @gv_c_oty_posn.

      SORT lt_posn BY sobid.
      DELETE lt_posn WHERE sobid IS INITIAL.
      DELETE ADJACENT DUPLICATES FROM lt_posn COMPARING sobid.

      IF lt_posn[] IS NOT INITIAL.

        "Cast the position numbers in SOBID to OBJID
        LOOP AT lt_posn INTO DATA(ls_posn).
          APPEND ls_posn-sobid TO lt_posn_key_cast.
        ENDLOOP.

        "Find the Org ID linked to the positions
        SELECT sobid
               FROM hrp1001
               INTO TABLE @DATA(lt_org)
               FOR ALL ENTRIES IN @lt_posn_key_cast
               WHERE
                otype = @gv_c_oty_posn AND
                objid = @lt_posn_key_cast-table_line AND
                plvar = @gv_c_plvr_active AND
                rsign = @gv_c_rsign_bot_up AND
                relat = @gv_c_rel_belongs_to AND
                begda <= @sy-datum AND
                endda >= @sy-datum AND
                sclas = @gv_c_oty_orgn.
        "Find the higher most org name for one of the positions
        LOOP AT lt_org INTO DATA(ls_org).
          "Retrive the org structure of the Org ID linked to the position
          CALL FUNCTION 'RH_STRUC_GET'
            EXPORTING
              act_otype      = gv_c_oty_orgn
              act_objid      = ls_org-sobid
              act_wegid      = gv_c_evpath_org_str
              act_plvar      = gv_c_plvr_active
            TABLES
              result_objec   = lt_org_structure
            EXCEPTIONS
              no_plvar_found = 1
              no_entry_found = 2
              OTHERS         = 3.
          IF sy-subrc = 0 AND lt_org_structure[] IS NOT INITIAL.
            "The highest org ID on hierarchy is the last entry
            ev_posn_company = lt_org_structure[ lines( lt_org_structure ) ]-short.
            IF ev_posn_company IS NOT INITIAL.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.


  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_QUA_DESCRIPTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_QUA_OTYPE                   TYPE        OTYPE
* | [--->] IV_QUA_OBJID                   TYPE        HROBJID
* | [<---] ES_QUA_DESC                    TYPE        ZST_EREC_QUA_DETAILS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_qua_descriptions.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      18th Sep 2025                                             *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Conversion exit to PRESENT qualification details        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-4th Nov 2025
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
*<<<End of Changes-BASDO-NASDO-BNASDO-4th Nov 2025
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_QUA_DETAILS_HR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_PERNR                       TYPE        PERNR(optional)
* | [--->] IT_PERNR                       TYPE        HRSPP_CDOC_PERNO(optional)
* | [--->] BEGDA                          TYPE        HRP1000-BEGDA (default =SY-DATUM)
* | [--->] ENDDA                          TYPE        HRP1000-ENDDA (default =SY-DATUM)
* | [--->] IR_AEDTM                       TYPE        FIP_T_AEDAT_RANGE(optional)
* | [--->] WITH_STEXT                     TYPE        CHAR1 (default ='X')
* | [--->] WITH_QK_INFO                   TYPE        CHAR1 (default ='X')
* | [--->] CHECK_NOTE                     TYPE        CHAR1 (default =' ')
* | [--->] OBJECTS                        TYPE        HRTB_SOBID(optional)
* | [--->] ERR_OBJECTS                    TYPE        HRTB_SOBID(optional)
* | [<---] PROFILE                        TYPE        ZEREC_TT_HRPE_PROFQ
* | [<---] ET_HRP5105                     TYPE        ZTT_HRP5105
* | [!CX!] ZCX_GEN_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_qua_details_hr.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      18th Sep 2025                                             *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Get employee qualifications from HR System              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-17th Feb 2026
    DATA: lt_pernr_sobid TYPE hrtb_sobid.

    "Get the name of RFC Connection to the HR System
    SELECT SINGLE gsval FROM t77s0
                 INTO @DATA(lv_gsval)
                 WHERE
                  grpid = @gc_grpid_rfc_hr  AND
                  semid = @gc_semid_rfc_hr.


    IF lv_gsval IS NOT INITIAL.

      "Construct a list of SOBID
      IF iv_pernr IS NOT INITIAL.
        lt_pernr_sobid = VALUE #(
        (
          plvar = gc_plvar_curr
          otype = gc_otype_p
          sobid = iv_pernr
        )
        ).
      ENDIF.

      lt_pernr_sobid = VALUE #( BASE lt_pernr_sobid
      FOR ls_pernr IN it_pernr
      (
          plvar = gc_plvar_curr
          otype = gc_otype_p
          sobid = ls_pernr
      )
      ).

      lt_pernr_sobid = VALUE #( BASE lt_pernr_sobid
      FOR ls_object IN objects
      (
          ls_object
      )
      ).

      "Call RFC FM to retrieve the data
      CALL FUNCTION 'ZHR_RHPP_Q_PROFILE_READ'
        DESTINATION lv_gsval
        EXPORTING
          begda            = begda
          endda            = endda
          with_stext       = with_stext
          with_qk_info     = with_qk_info
          check_note       = check_note
          objects          = lt_pernr_sobid
          err_objects      = err_objects
        IMPORTING
          profile          = profile
        EXCEPTIONS
          no_authority     = 1
          wrong_otype      = 2
          object_not_found = 3
          undefined        = 4
          OTHERS           = 5.

      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_gen_exception
          EXPORTING
            textid = VALUE #(
                        msgid = sy-msgid
                        msgno = sy-msgno
                        attr1 = zcx_gen_exception=>gc_attr_msgv1
                        attr2 = zcx_gen_exception=>gc_attr_msgv2
                        attr3 = zcx_gen_exception=>gc_attr_msgv3
                        attr4 = zcx_gen_exception=>gc_attr_msgv4
            )
            msgv1  = sy-msgv1
            msgv2  = sy-msgv2
            msgv3  = sy-msgv3
            msgv4  = sy-msgv4.
      ELSE.

        "Exclude entries which were not changed in the given date range
        IF ir_aedtm[] IS NOT INITIAL.
          DELETE profile WHERE aedtm NOT IN ir_aedtm.
        ENDIF.

        "Fill the qualification in hRP5105 format, for subsequent steps
        IF et_hrp5105 IS REQUESTED.
          et_hrp5105 = VALUE #(
          FOR ls_profile IN profile
          (
            plvar = ls_profile-plvar
            otype  = ls_profile-otype
            objid  = ls_profile-sobid
            begda  = ls_profile-vbegd
            endda  = ls_profile-vendd
            istat  = ls_profile-istat
            aedtm  = ls_profile-aedtm
            uname  = ls_profile-uname
            q_object_type  = ls_profile-ttype
            q_object_id  = ls_profile-tbjid
            proficiency    = ls_profile-profcy
            inst    = ls_profile-inst
            high    = ls_profile-high
          )
          ).
        ENDIF.
      ENDIF.
    ELSE.
    ENDIF.

*<<<End of Changes-BASDO-NASDO-BNASDO-17th Feb 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_RECRUITMENT_TEAM
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUISITION_LIST               TYPE        ZTT_HRP5125
* | [<-()] RECRUITMENT_TEAM               TYPE        TT_RECRUITMENT_TEAM
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_recruitment_team.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Get the information about recruitment team              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-07 Sep 2026
    IF requisition_list IS NOT INITIAL.
      "Get the recruitment team members
      SELECT plvar, otype, objid, istat, begda, endda, role, sclas, sobid, lead
               FROM hrp5131
               INTO TABLE @DATA(recruitment_team_lcl)
               FOR ALL ENTRIES IN @requisition_list
               WHERE
                objid = @requisition_list-objid.

      "Get the information about the recruitment team members
      DATA(recruitment_team_unique_users) = VALUE usmd_t_user(
        FOR team_member IN recruitment_team_lcl WHERE ( sclas EQ 'US'  AND
                                                        sobid IS NOT INITIAL )
        (
          CONV xubname( team_member-sobid )
        )
      ).

      "Get the unique user IDs
      SORT recruitment_team_unique_users BY table_line.
      DELETE ADJACENT DUPLICATES FROM recruitment_team_unique_users COMPARING table_line.


      IF recruitment_team_unique_users IS NOT INITIAL.
        "Get the user names
        DATA(user_names) = zcl_abap_helper=>get_sap_user_names( user_ids = recruitment_team_unique_users ).

        "Get the personnel numbers, mapped against the user IDs
        DATA(emp_ids) = get_pa0105(
          it_sapusrid = CONV ztt_sysid( recruitment_team_unique_users )
          iv_subtype = gc_subty_syuname ).

        "Get the email IDs mapped against the personnel numbers
        DATA(unique_emp_ids) = VALUE hrspp_cdoc_perno(
          FOR emp_id IN emp_ids WHERE ( pernr IS NOT INITIAL )
          (
            emp_id-pernr
          )
        ).

        SORT unique_emp_ids BY table_line.

        IF unique_emp_ids IS NOT INITIAL.
          DELETE ADJACENT DUPLICATES FROM unique_emp_ids COMPARING table_line.
          DATA(emp_mails) = get_pa0105(
            it_pernr = unique_emp_ids
            iv_subtype = gc_subty_email ).
        ENDIF.
      ENDIF.

      "Parse through the information and fill in the output info table
      LOOP AT recruitment_team_lcl INTO DATA(team_member_001).
        DATA(output_line) = VALUE line_recruitment_team( ).

        "Basic information from HRP5131
        output_line = CORRESPONDING #( team_member_001 ).

        "Get the Employee Number
        LOOP AT emp_ids INTO DATA(emp_x_sapid)
                        WHERE
                          begda LE sy-datum AND
                          endda GE sy-datum AND
                          usrid = team_member_001-sobid."Check Empid mapping VALID TODAY
          output_line-pernr = emp_x_sapid-pernr.
        ENDLOOP.
        IF sy-subrc NE 0.
          IF line_exists( emp_ids[ usrid = team_member_001-sobid ] ). "Find any Empid mapping
            emp_x_sapid = emp_ids[ usrid = team_member_001-sobid ].
            output_line-pernr = emp_x_sapid-pernr.
          ENDIF.
        ENDIF.

        "Get the e-mail ID
        LOOP AT emp_mails INTO DATA(emp_x_email)
                        WHERE
                          pernr EQ output_line-pernr AND
                          begda LE sy-datum AND
                          endda GE sy-datum."Check Email mapping VALID TODAY
          output_line-email = emp_x_email-usrid_long.
        ENDLOOP.
        IF sy-subrc NE 0.
          IF line_exists( emp_mails[ pernr = output_line-pernr ] ).
            emp_x_email = emp_mails[ pernr = output_line-pernr ]. "Find any Email mapped to employee
            output_line-email =  emp_x_email-usrid_long.
          ENDIF.
        ENDIF.

        "Get the Employee Name
        IF line_exists( user_names[ username = team_member_001-sobid ] ).
          DATA(sapid_x_name) = user_names[ username = team_member_001-sobid ].
          output_line-fullname =  sapid_x_name-fullname.
        ENDIF.

        APPEND output_line TO recruitment_team.

        CLEAR: output_line.
      ENDLOOP.

    ENDIF.
*<<<End of Changes-BASDO-NASDO-BNASDO-07 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_REQUISITIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLOSE_DATES                    TYPE        RANGE_DATES(optional)
* | [--->] REQUISITION_IDS                TYPE        ECM_T_OBJID(optional)
* | [--->] GET_JOB_DESCRIPTION            TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] GET_SUPPORT_TEAM               TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<---] REQUISITION_LIST               TYPE        ZTT_HRP5125
* | [<---] JOB_DESCRIPTIONS               TYPE        ZTT_HRP5126
* | [<---] RECRUITMENT_TEAM               TYPE        TT_RECRUITMENT_TEAM
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_requisitions.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Get Requisitions based on given selection criteria      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BASDO-NASDO-BNASDO-07 Sep 2026
    IF requisition_ids IS NOT INITIAL.
      DATA(requisition_lcl) = requisition_ids.

      SORT requisition_lcl BY table_line.
      DELETE requisition_lcl WHERE table_line IS INITIAL.
      DELETE ADJACENT DUPLICATES FROM requisition_lcl COMPARING table_line.
    ENDIF.

    IF requisition_lcl IS INITIAL.
      SELECT * FROM hrp5125
               INTO TABLE @requisition_list
               WHERE
                application_end IN @close_dates.
    ELSE.
      SELECT * FROM hrp5125
               INTO TABLE @requisition_list
               FOR ALL ENTRIES IN @requisition_lcl
               WHERE
                objid           EQ @requisition_lcl-table_line AND
                application_end IN @close_dates.
    ENDIF.

    IF requisition_list IS NOT INITIAL.
      IF get_job_description = abap_true. "If any additional information is requested, prepare data for that
        DATA(unique_requisitions) = requisition_list.

        SORT unique_requisitions BY objid.
        DELETE ADJACENT DUPLICATES FROM unique_requisitions COMPARING objid.
        DELETE unique_requisitions WHERE objid IS INITIAL.

      ENDIF.
    ENDIF.

    IF unique_requisitions IS NOT INITIAL.
      IF get_job_description IS NOT INITIAL.
        job_descriptions = get_job_descriptions( unique_requisitions )."Get the job descriptions
      ENDIF.

      IF get_support_team EQ abap_true.
        recruitment_team = get_recruitment_team( unique_requisitions )."Get the support team
      ENDIF.
    ENDIF.

*<<<End of Changes-BASDO-NASDO-BNASDO-07 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_COM2_ORG_ABBR
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_ABBR_COM2                    TYPE        SHORT_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_COM2_org_abbr.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      14th Apr 2025                                             *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-14th Apr 2025-NASDO                    *
* Description: Retrieve the abbreviated COM2 org name stored in TVARVC  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*
    SELECT SINGLE low
           FROM   tvarvc
           INTO ev_abbr_COM2
           WHERE
            name = gv_c_varname_COM2_abbr.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_EREC_HELPER=>GET_X_Y_REL
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_OBJID                       TYPE        ECM_T_OBJID(optional)
* | [--->] IT_SOBID                       TYPE        RCF_T_SOBID(optional)
* | [--->] IV_OTYPE                       TYPE        OTYPE
* | [--->] IV_SCLAS                       TYPE        SCLAS
* | [<-()] RT_X_TO_Y                      TYPE        HRP1001_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_x_y_rel.
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      18th Sep 2025                                             *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Given a list of Objects get the related Objects         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAA (BNASDO)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BASDO                               *
* Change Indicator: BASDO-NASDO-BNASDO                         *
* Description: Cleanup input data here, not expecting caller to do it  *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*


*>>>Start of Changes-BASDO-NASDO-BNASDO-11 Sep 2026
    IF it_objid IS NOT INITIAL.
      DATA(objid_lcl) = it_objid.
      SORT objid_lcl BY table_line.
      DELETE objid_lcl WHERE table_line IS INITIAL.
      DELETE ADJACENT DUPLICATES FROM objid_lcl COMPARING table_line.
    ENDIF.
*<<<End of Changes-BASDO-NASDO-BNASDO-11 Sep 2026

*>>>Start of Changes-BASDO-NASDO-BNASDO-13th Oct 2025
    "Retrieve the Requested relations from HRP1001
*>>>Start of Changes-BASDO-NASDO-BNASDO-22nd Oct 2025
*****    IF it_objid[] IS NOT INITIAL."If object IDs are provided "COMMENT-BASDO-NASDO-BNASDO-11 Sep 2026
    IF objid_lcl[] IS NOT INITIAL."If object IDs are provided "INSERT-BASDO-NASDO-BNASDO-11 Sep 2026
      "Get related sub-object IDs
      SELECT * FROM hrp1001
               INTO TABLE @rt_x_to_y
*****               FOR ALL ENTRIES IN @it_objid "COMMENT-BASDO-NASDO-BNASDO-11 Sep 2026
               FOR ALL ENTRIES IN @objid_lcl "INSERT-BASDO-NASDO-BNASDO-11 Sep 2026
               WHERE
                otype = @iv_otype AND
*****                objid = @it_objid-table_line AND "COMMENT-BASDO-NASDO-BNASDO-11 Sep 2026
                objid = @objid_lcl-table_line AND "INSERT-BASDO-NASDO-BNASDO-11 Sep 2026
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
*<<<End of Changes-BASDO-NASDO-BNASDO-22nd Oct 2025
*<<<End of Changes-BASDO-NASDO-BNASDO-13th Oct 2025
  ENDMETHOD.
ENDCLASS.
