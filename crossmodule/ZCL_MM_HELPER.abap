class ZCL_MM_HELPER definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF gty_msg_tracker,
        context       TYPE int4,
        busobj        TYPE int4,
        message_exist TYPE boole_d,
      END OF gty_msg_tracker .
  types:
    gty_t_msg_tracker TYPE STANDARD TABLE OF gty_msg_tracker .
  types:
    BEGIN OF zmm_st_po_item_x_packno,
        ebelp  TYPE ebelp,
        packno TYPE packno,
      END OF zmm_st_po_item_x_packno .
  types:
    BEGIN OF zmm_st_rel_strat_f4_help,
        frgsx TYPE frgsx,
        frggr TYPE frggr,
        frgxt TYPE frgxt,
      END OF zmm_st_rel_strat_f4_help .
  types:
    BEGIN OF zmm_st_rel_group_f4_help,
        frggr TYPE frggr,
        frggt TYPE frggt,
      END OF zmm_st_rel_group_f4_help .
  types:
    zmm_tt_rel_group_f4_help TYPE STANDARD TABLE OF zmm_st_rel_group_f4_help WITH EMPTY KEY .
  types:
    zmm_tt_rel_strat_f4_help TYPE STANDARD TABLE OF zmm_st_rel_strat_f4_help WITH EMPTY KEY .

  constants GC_CHG_OBJ_PR type CDOBJECTCL value 'BANF' ##NO_TEXT.
  constants GC_CHG_OBJ_PO type CDOBJECTCL value 'EINKBELEG' ##NO_TEXT.
  constants GC_CHG_TAB_PR type CDOBJECTCL value 'EBAN' ##NO_TEXT.
  constants GC_CHG_TAB_PO type CDOBJECTCL value 'EKKO' ##NO_TEXT.
  constants GC_CHG_FLD_REL type CDOBJECTCL value 'FRGZU' ##NO_TEXT.
  constants GC_OTYP_USR type OTYPE value 'US' ##NO_TEXT.
  constants GC_PR_DOC_TYP_RFQ type EBSTYP value 'A' ##NO_TEXT.
  constants GC_MSGID_MM type SYMSGID value 'ZMM' ##NO_TEXT.
  constants GC_DOC_TYP_PO type BSART value 'F' ##NO_TEXT.
  constants GC_AAC_ASSET_AA type KNTTP value 'A' ##NO_TEXT.
  constants GC_AAC_PM_W_ORD type KNTTP value 'F' ##NO_TEXT.
  constants GC_AAC_COST_CTR type KNTTP value 'K' ##NO_TEXT.
  constants GC_AAC_NW_ASSGN type KNTTP value 'N' ##NO_TEXT.
  constants GC_AAC_WBS_ELMT type KNTTP value 'P' ##NO_TEXT.
  constants GC_PRE_WBS_OBJNR type CHAR02 value 'PR' ##NO_TEXT.
  constants GC_CTRL_KEY_OPERATIONS type STEUS value 'PM03' ##NO_TEXT.
  constants GC_CTRL_KEY_COMPONENTS type STEUS value 'PM02' ##NO_TEXT.
  constants GC_CSCR_NAM_POI_TO_PMO type MEPO_NAME value 'POI_TO_PMO' ##NO_TEXT.
  constants GC_CFLD_POI_WRK_CTR type MMPUR_METAFIELD value 90000010 ##NO_TEXT.
  constants GC_CFLD_POI_ACT_TYP type MMPUR_METAFIELD value 90000011 ##NO_TEXT.
  constants GC_CFLD_POI_PMO_NUM type MMPUR_METAFIELD value 90000012 ##NO_TEXT.
  constants GC_CFLD_POI_PMO_ITM type MMPUR_METAFIELD value 90000013 ##NO_TEXT.
  class-data GV_C_ITYP_SERV type PSTYP value '9' ##NO_TEXT.
  class-data GV_C_ITYP_COMP type PSTYP value '0' ##NO_TEXT.
  class-data GS_NEKKO type EKKO .
  class-data GT_XEKPO type MEOUT_T_UEKPO .
  class-data GT_YEKPO type MEOUT_T_UEKPO .
  class-data GT_XEKKN type MEOUT_T_UEKKN .
  class-data GT_YEKKN type MEOUT_T_UEKKN .
  class-data GT_XESLL type ZTT_MM_PO_ITEM_ESLL .
  class-data GT_YESLL type ZTT_MM_PO_ITEM_ESLL .
  class-data GT_MESSAGE_TRACKER type GTY_T_MSG_TRACKER .
  class-data GT_PO_ITEM_REF type /BEV1/NEXMEPOITEM_T .

  class-methods RETRIEVE_ME2L_DATA
    importing
      !IV_NO_OUTPUT type BOOLE_D
      !IV_LISTU type LISTU default 'ALV'
      !IV_GULDT type P_GULDT
      !IV_RWEIT type P_RWEIT
      !IV_TXZ01 type TXZ01
      !IV_NAME1 type AD_NAME1
      !IR_LIFNR type MD_RANGE_T_LIFNR
      !IR_EKORG type CMM_T_IDX_EKORG_RNG
      !IR_SELPA type ZMM_TT_SELPA_RNG
      !IR_BSART type BLGL_BSART_RANGE_TT
      !IR_EKGRP type MMPURUI_EKGRP_RANGE_TTY
      !IR_WERKS type MMPUR_T_WERKS
      !IR_PSTYP type ZMM_TT_EPSTP_RNG
      !IR_KNTTP type FIP_T_KNTTP_RANGE
      !IR_EINDT type BLGL_EINDT_RANGE_TT
      !IR_EBELN type MMPUR_T_EBELN
      !IR_MATNR type FRE_MATNR_RANG_TTY
      !IR_MATKL type MMPUR_T_MATKL
      !IR_BEDAT type WRF_PBAS_BEDAT_RTTY
      !IR_EAN11 type MMPUR_T_EAN11
      !IR_IDNLF type MMPUR_T_IDNLF
      !IR_LTSNR type MMPUR_T_LTSNR
      !IR_AKTNR type FIP_T_AKTRN_RANGE
      !IR_SAISO type WPOCS_SAISO_RANGE_TAB
      !IR_SAISJ type WPOCS_SAISJ_RANGE_TAB
    returning
      value(RT_ME2L_OUT) type ZMM_TT_ME2L_OUT .
  class-methods RETRIEVE_PDOC_APPROVERS
    importing
      !IT_EBAN type MEREQ_T_EBAN optional
      !IT_EKKO type ME_EKKO optional
      !IV_GET_POTENTIAL_APPROVERS type BOOLE_D default ''
    exporting
      !ET_APP_PO_POTN type ZTT_PD_APPR_LIST
      !ET_APP_PO_ACTL type ZTT_PD_APPR_LIST
      !ET_APP_PR_POTN type ZTT_PD_APPR_LIST
      !ET_APP_PR_ACTL type ZTT_PD_APPR_LIST
      !ET_USR_NAMES type FDM_T_USER_NAME .
  class-methods GET_PD_APPROVER_DETAILS
    importing
      !IV_PUR_DOC type EBELN
      !IV_PUR_ITM type EBELP default 00000
      !IT_APP_POTN type ZTT_PD_APPR_LIST optional
      !IT_APP_ACTL type ZTT_PD_APPR_LIST optional
      !IT_APP_NAMES type FDM_T_USER_NAME
    returning
      value(RT_APPR_LIST) type ZTT_PD_APPR_LIST .
  class-methods RETRIEVE_ME2M_DATA
    importing
      !IR_MATNR type MMPUR_T_MATNR
      !IR_WERKS type MMPUR_T_WERKS
    returning
      value(RT_ME2M_OUT) type ZMM_TT_ME2M_OUT .
  class-methods PO_FIND_COST_CENTER
    importing
      !IV_EBELN type EBELN optional
      !IV_EBELP type EBELP optional
      !IS_PO_LINE_ACC_DET type EKKNU optional
      !IS_PO_LINE_AAC type BEKPO optional
    exporting
      !EV_COST_CENTER type KOSTL
      !EV_CO_AREA type KOKRS .
  class-methods GET_VENDOR_DETAILS
    exporting
      !IT_LIFNR type FAGL_T_LIFNR
      !ET_LFBK type LFBK_T
      !ET_BNKA type RE_T_BNKA
      !ET_LFM1 type LFM1_TTY
      !ET_LFB1 type MASSLFB1_T .
  class-methods MM_TO_PM_ITEM_TRANSFER_001
    importing
      !IS_NEKKO type EKKO
      !IT_XEKPO type MEOUT_T_UEKPO
      !IT_YEKPO type MEOUT_T_UEKPO optional
      !IT_XEKKN type MEOUT_T_UEKKN
      !IT_YEKKN type MEOUT_T_UEKKN optional
      !IT_XESLL type ZTT_MM_PO_ITEM_ESLL
      !IT_YESLL type ZTT_MM_PO_ITEM_ESLL optional .
  class-methods MM_TO_PM_ITEM_TRANS_DONE_001
    importing
      !P_TASK type CHAR32 .
  class-methods MM_TO_PM_ITEM_PREPARATION_001
    importing
      !IV_ONLY_CURRENT type BOOLE_D default ABAP_TRUE
      !IR_HEADER type ref to IF_PURCHASE_ORDER_MM optional
      !IS_EKKO type EKKO optional
    exporting
      !ES_NEKKO type EKKO
      !ET_XEKPO type MEOUT_T_UEKPO
      !ET_YEKPO type MEOUT_T_UEKPO
      !ET_XEKKN type MEOUT_T_UEKKN
      !ET_YEKKN type MEOUT_T_UEKKN
      !ET_XESLL type ZTT_MM_PO_ITEM_ESLL
      !ET_YESLL type ZTT_MM_PO_ITEM_ESLL .
  class-methods RETRIEVE_SERVICE_DETAILS
    importing
      !IV_EBELN type EBELN
      !IT_EKPO type MMPR_UEKPO
    exporting
      !ET_XESLL type ZTT_MM_PO_ITEM_ESLL .
  class-methods AWAIT_PO_UNLOCK
    importing
      !IV_EBELN type EBELN
      !IV_CHECK_INTERVAL type INT4
      !IV_CHECK_ITERATION type INT4
    exporting
      !EV_SUCCESS type BOOLE_D .
  class-methods ADD_PO_MM_MESSAGE
    importing
      !IV_CONTEXT type INT4
      !IV_OBJID type INT4
      !IV_MSGID type SYMSGID
      !IV_MSGTY type SYMSGTY
      !IV_MSGNO type SYMSGNO
      !IV_MSGV1 type SYMSGV default SPACE
      !IV_MSGV2 type SYMSGV default SPACE
      !IV_MSGV3 type SYMSGV default SPACE
      !IV_MSGV4 type SYMSGV default SPACE .
  class-methods REMOVE_PO_MM_MESSAGE
    importing
      !IV_CONTEXT type INT4
      !IV_OBJID type INT4 .
  class-methods ADD_PO_ITEM_REF
    importing
      !IR_HEADER type ref to IF_PURCHASE_ORDER_MM optional
      !IR_ITEM type ref to IF_PURCHASE_ORDER_ITEM_MM optional .
  class-methods CLEAR_PO_ITEM_REF .
  class-methods GET_PO_ITEM_REF
    importing
      !IV_EBELN type EBELN
      !IV_EBELP type EBELP
    returning
      value(RR_ITEM) type ref to IF_PURCHASE_ORDER_ITEM_MM .
protected section.
private section.

  class-data GV_PO_TO_PMO_COMPLETE type BOOLE_D .
  class-data GV_PO_TO_PMO_SUCCESS type BOOLE_D .

  class-methods TRANSLATE_CDOC_TO_PDOC_APPR
    importing
      !IT_CDHDR type CDHDR_TAB
      !IT_CDPOS type CDPOS_TAB
    returning
      value(RT_APPR) type ZTT_PD_APPR_LIST .
  class-methods ADD_PO_ITEM_REF_TO_TAB
    importing
      !IV_EBELN type EBELN
      !IV_EBELP type EBELP
      !IR_ITEM type ref to IF_PURCHASE_ORDER_ITEM_MM .
ENDCLASS.



CLASS ZCL_MM_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>ADD_PO_ITEM_REF
* +-------------------------------------------------------------------------------------------------+
* | [--->] IR_HEADER                      TYPE REF TO IF_PURCHASE_ORDER_MM(optional)
* | [--->] IR_ITEM                        TYPE REF TO IF_PURCHASE_ORDER_ITEM_MM(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_po_item_ref.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Maintain list of PO Items references                    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-06 May 2026

    IF ir_item IS NOT INITIAL.
      DATA(ls_item) = ir_item->get_data( ).
      add_po_item_ref_to_tab(
      EXPORTING
        iv_ebeln = ls_item-ebeln
        iv_ebelp = ls_item-ebelp
        ir_item = ir_item
      ).
    ELSEIF ir_header IS NOT INITIAL.
      DATA(lt_items) = ir_header->get_items( ).
      LOOP AT lt_items INTO DATA(ls_r_item).
        ls_item = ls_r_item-item->get_data( ).
        add_po_item_ref_to_tab(
        EXPORTING
          iv_ebeln = ls_item-ebeln
          iv_ebelp = ls_item-ebelp
          ir_item = ls_r_item-item
        ).
      ENDLOOP.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-06 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Private Method ZCL_MM_HELPER=>ADD_PO_ITEM_REF_TO_TAB
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_EBELN                       TYPE        EBELN
* | [--->] IV_EBELP                       TYPE        EBELP
* | [--->] IR_ITEM                        TYPE REF TO IF_PURCHASE_ORDER_ITEM_MM
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_po_item_ref_to_tab.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Add reference to the correct position                   *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-06 May 2026
    ASSIGN gt_po_item_ref[ data-ebeln = iv_ebeln data-ebelp = iv_ebelp ] TO FIELD-SYMBOL(<lfs_item_ref>).
    IF sy-subrc = 0."If an entry exists, UPDATE
      <lfs_item_ref>-item = ir_item.
    ELSE."If entry does not exist, APPEND
      gt_po_item_ref = VALUE #( BASE gt_po_item_ref
        (
          data-ebeln = iv_ebeln
          data-ebelp = iv_ebelp
          item  = ir_item
        )
      ).
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-06 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>ADD_PO_MM_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_CONTEXT                     TYPE        INT4
* | [--->] IV_OBJID                       TYPE        INT4
* | [--->] IV_MSGID                       TYPE        SYMSGID
* | [--->] IV_MSGTY                       TYPE        SYMSGTY
* | [--->] IV_MSGNO                       TYPE        SYMSGNO
* | [--->] IV_MSGV1                       TYPE        SYMSGV (default =SPACE)
* | [--->] IV_MSGV2                       TYPE        SYMSGV (default =SPACE)
* | [--->] IV_MSGV3                       TYPE        SYMSGV (default =SPACE)
* | [--->] IV_MSGV4                       TYPE        SYMSGV (default =SPACE)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_po_mm_message.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Add a PO item processing message                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-29 Apr 2026
    INCLUDE mm_messages_mac.


    "Pre-emptively check if the object ID exists in DB
    "The process is as follows
    "When PO is first opened, an object id is allcoated for header, item, schedule etc., and added to handlers
    "But this id is not updated to PO Item-ID until much later
    "If the ID is not available in the handler table, we do not have to add the message
    CALL METHOD cl_handle_manager_mm=>get
      EXPORTING
        im_id   = iv_objid
      EXCEPTIONS
        failure = 1
        OTHERS  = 2.
    IF sy-subrc <> 0.
*     Implement suitable error handling here
      RETURN.
    ENDIF.


    mmpur_business_obj_id iv_objid.

    mmpur_context iv_context.
    mmpur_message_forced iv_msgty iv_msgid iv_msgno iv_msgv1 iv_msgv2 iv_msgv3 iv_msgv4.


    ASSIGN gt_message_tracker[ context = iv_context busobj = iv_objid ] TO FIELD-SYMBOL(<lfs_msg_tracker>).
    IF sy-subrc = 0.
      <lfs_msg_tracker>-message_exist = abap_true.
    ELSE.
      APPEND INITIAL LINE TO gt_message_tracker ASSIGNING <lfs_msg_tracker>.
      <lfs_msg_tracker>-context = iv_context.
      <lfs_msg_tracker>-busobj = iv_objid.
      <lfs_msg_tracker>-message_exist = abap_true.
    ENDIF.

*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-29 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>AWAIT_PO_UNLOCK
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_EBELN                       TYPE        EBELN
* | [--->] IV_CHECK_INTERVAL              TYPE        INT4
* | [--->] IV_CHECK_ITERATION             TYPE        INT4
* | [<---] EV_SUCCESS                     TYPE        BOOLE_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD await_po_unlock.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Poll and wait for PO to be unlocked                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-28 Apr 2026

    DATA: lt_enq  TYPE TABLE OF seqg3,
          lv_garg TYPE seqg3-garg.

    lv_garg = |{ sy-mandt }{ iv_ebeln ALPHA = IN }|.

    DO iv_check_iteration TIMES.
      CALL FUNCTION 'ENQUEUE_READ'
        EXPORTING
          gclient               = sy-mandt
          gname                 = 'EKKO'    " The table being locked
          garg                  = lv_garg  " The specific lock argument
        TABLES
          enq                   = lt_enq
        EXCEPTIONS
          communication_failure = 1
          system_failure        = 2
          OTHERS                = 3.

      IF sy-subrc = 0 AND lt_enq IS INITIAL.
        " SUCCESS: No lock found. The PO save is complete.
        ev_success = abap_true.
        RETURN.
      ELSE.
        " The PO is still locked; the database commit is still in progress.
      ENDIF.
      WAIT UP TO iv_check_interval SECONDS.
    ENDDO.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-28 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>CLEAR_PO_ITEM_REF
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD clear_po_item_ref.
    REFRESH: gt_po_item_ref.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>GET_PD_APPROVER_DETAILS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_PUR_DOC                     TYPE        EBELN
* | [--->] IV_PUR_ITM                     TYPE        EBELP (default =00000)
* | [--->] IT_APP_POTN                    TYPE        ZTT_PD_APPR_LIST(optional)
* | [--->] IT_APP_ACTL                    TYPE        ZTT_PD_APPR_LIST(optional)
* | [--->] IT_APP_NAMES                   TYPE        FDM_T_USER_NAME
* | [<-()] RT_APPR_LIST                   TYPE        ZTT_PD_APPR_LIST
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_PD_APPROVER_DETAILS.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      13th Jan 2026                                             *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Retrieve approvers for given Purchasing document        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-19th Jan 2026
    DATA: lv_max_apvd TYPE i,
          lv_max_reqd TYPE i.

    IF it_app_potn[] IS INITIAL.
      "If for any reason the potential approver list is empty
      "May be release strategy has changed - Assumption: NEVER
      "Or we were provided just the actual approver list
      IF it_app_actl[] IS NOT INITIAL.
        LOOP AT it_app_actl INTO DATA(ls_app_actl)
                            WHERE
                              pur_doc = iv_pur_doc AND
                              pur_doc_item = iv_pur_itm.
          ls_app_actl-approver_id = ls_app_actl-objid.
          IF line_exists( it_app_names[ username = ls_app_actl-approver_id ] ).
            ls_app_actl-approver_name = it_app_names[ username = ls_app_actl-approver_id ]-fullname.
          ENDIF.
          APPEND ls_app_actl TO rt_appr_list.
        ENDLOOP.
      ENDIF.
    ELSE.
      "The potential approver table has all possible/required levels of approval
      LOOP AT it_app_potn INTO DATA(ls_app_potn)
                          WHERE
                            pur_doc = iv_pur_doc AND
                            pur_doc_item = iv_pur_itm.
        "Check if actual approval has happened at the given level
        IF line_exists( it_app_actl[ pur_doc = iv_pur_doc
                                     pur_doc_item = iv_pur_itm
                                     approver_level = ls_app_potn-approver_level ] ).
          ls_app_actl = it_app_actl[ pur_doc = iv_pur_doc
                                     pur_doc_item = iv_pur_itm
                                     approver_level = ls_app_potn-approver_level ].
          ls_app_actl-approver_id = ls_app_actl-objid.
          IF line_exists( it_app_names[ username = ls_app_actl-approver_id ] ).
            ls_app_actl-approver_name = it_app_names[ username = ls_app_actl-approver_id ]-fullname.
          ENDIF.
          APPEND ls_app_actl TO rt_appr_list.
        ELSE.
          "If actual approval has not happened
          "We will add an entry with potential approver
          ls_app_potn-approver_id = ls_app_potn-objid.
          IF line_exists( it_app_names[ username = ls_app_potn-approver_id ] ).
            ls_app_potn-approver_name = it_app_names[ username = ls_app_potn-approver_id ]-fullname.
          ENDIF.
          APPEND ls_app_potn TO rt_appr_list.
        ENDIF.
      ENDLOOP.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-19th Jan 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>GET_PO_ITEM_REF
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_EBELN                       TYPE        EBELN
* | [--->] IV_EBELP                       TYPE        EBELP
* | [<-()] RR_ITEM                        TYPE REF TO IF_PURCHASE_ORDER_ITEM_MM
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_po_item_ref.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Get reference to a PO Item                              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-06 May 2026
    ASSIGN gt_po_item_ref[ data-ebeln = iv_ebeln data-ebelp = iv_ebelp ] TO FIELD-SYMBOL(<lfs_s_item_ref>).
    IF sy-subrc = 0.
      rr_item = <lfs_s_item_ref>-item.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-06 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>GET_VENDOR_DETAILS
* +-------------------------------------------------------------------------------------------------+
* | [<---] IT_LIFNR                       TYPE        FAGL_T_LIFNR
* | [<---] ET_LFBK                        TYPE        LFBK_T
* | [<---] ET_BNKA                        TYPE        RE_T_BNKA
* | [<---] ET_LFM1                        TYPE        LFM1_TTY
* | [<---] ET_LFB1                        TYPE        MASSLFB1_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_vendor_details.
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      20th Mar 2026                                             *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Get Bank account details of given Vendors               *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-23rd Mar 2026

    DATA: lt_lifnr TYPE fagl_t_lifnr.

    "Extract the unique Vendor numbers
    lt_lifnr = it_lifnr.

    SORT lt_lifnr BY table_line.
    DELETE ADJACENT DUPLICATES FROM lt_lifnr COMPARING ALL FIELDS.
    DELETE lt_lifnr WHERE table_line IS INITIAL.


    IF lt_lifnr[] IS NOT INITIAL.
      "~~~Get the Vendor Bank Details~~~
      IF et_lfbk[] IS REQUESTED OR
         et_bnka[] IS REQUESTED.
        SELECT lifnr, banks, bankl, bankn
               FROM lfbk
               INTO CORRESPONDING FIELDS OF TABLE @et_lfbk
               FOR ALL ENTRIES IN @lt_lifnr
               WHERE
                lifnr EQ @lt_lifnr-table_line.

        DATA(lt_lfbk) = et_lfbk.
        SORT lt_lfbk BY banks bankl.
        DELETE ADJACENT DUPLICATES FROM lt_lfbk COMPARING banks bankl.
        DELETE lt_lfbk WHERE
                        banks IS INITIAL AND
                        bankl IS INITIAL.

        IF lt_lfbk[] IS NOT INITIAL..
          SELECT banks, bankl, banka
                 FROM bnka
                 INTO CORRESPONDING FIELDS OF TABLE @et_bnka
                 FOR ALL ENTRIES IN @lt_lfbk
                 WHERE
                  banks = @lt_lfbk-banks AND
                  bankl = @lt_lfbk-bankl.
        ENDIF.
      ENDIF.

      "~~~Get the Vendor POrgs~~~
      IF et_lfm1[] IS REQUESTED.
        SELECT lifnr, ekorg
          INTO CORRESPONDING FIELDS OF TABLE @et_lfm1
          FROM lfm1
          FOR ALL ENTRIES IN @lt_lifnr
          WHERE
            lifnr = @lt_lifnr-table_line.
      ENDIF.

      "~~~Get Vendor Correspondence details~~~
      IF et_lfb1[] IS REQUESTED.
        SELECT lifnr, zsabe, intad
              FROM lfb1
              INTO CORRESPONDING FIELDS OF TABLE @et_lfb1
              FOR ALL ENTRIES IN @lt_lifnr
              WHERE
                lifnr EQ @lt_lifnr-table_line.
      ENDIF.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-23rd Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>MM_TO_PM_ITEM_PREPARATION_001
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_ONLY_CURRENT                TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] IR_HEADER                      TYPE REF TO IF_PURCHASE_ORDER_MM(optional)
* | [--->] IS_EKKO                        TYPE        EKKO(optional)
* | [<---] ES_NEKKO                       TYPE        EKKO
* | [<---] ET_XEKPO                       TYPE        MEOUT_T_UEKPO
* | [<---] ET_YEKPO                       TYPE        MEOUT_T_UEKPO
* | [<---] ET_XEKKN                       TYPE        MEOUT_T_UEKKN
* | [<---] ET_YEKKN                       TYPE        MEOUT_T_UEKKN
* | [<---] ET_XESLL                       TYPE        ZTT_MM_PO_ITEM_ESLL
* | [<---] ET_YESLL                       TYPE        ZTT_MM_PO_ITEM_ESLL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD MM_TO_PM_ITEM_PREPARATION_001.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Prepare inputs for PO to PMO Conversion                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-21 Apr 2026

*****    DATA: lv_sub_packno      TYPE packno,
*****
*****          ls_item_data       TYPE mepoitem,
*****          ls_ekpo            TYPE uekpo,
*****
*****
*****          lt_accounting_data TYPE purchase_order_accountings,
*****          lr_accounting      TYPE REF TO if_purchase_order_account_mm,
*****          ls_accounting_data TYPE mepoaccounting,
*****
*****          ls_ekkn            TYPE uekkn,
*****
*****
*****          lr_item_handle     TYPE REF TO cl_po_item_handle_mm,
*****          lr_service         TYPE REF TO if_services_mm,
*****          lt_packno          TYPE STANDARD TABLE OF zmm_st_po_item_x_packno,
*****          lt_packno_001      TYPE STANDARD TABLE OF pack_tab,
*****          lt_esll             TYPE mmsrv_esll,
*****          lt_esll_001         TYPE mmsrv_esll,
*****
*****          lr_po_obj          TYPE cl_po_header_handle_mm,
*****          lr_header           TYPE REF TO if_purchase_order_mm.
*****
*****
*****    IF ir_header IS NOT INITIAL.
*****      lr_header = ir_header.
*****    ELSEIF is_ekko IS NOT INITIAL.
***************      CREATE OBJECT lr_po_obj.
***************      lr_header->po_read( is_ekko-ebeln ).
*****    ENDIF.
*****
*****
*****    DATA(ls_po_header) = lr_header->get_data( ).
*****
*****    IF ls_po_header-bsart = 'ZR'.
*****
*****      MOVE-CORRESPONDING ls_po_header TO es_nekko.
*****      "ls_nekko-ebeln = im_ebeln. "Failsafe
*****
*****      DATA(lt_po_items) = lr_header->get_items( ).
*****
*****      "Item data, before and after change
*****      LOOP AT lt_po_items INTO DATA(ls_po_item_ref).
*****        CLEAR: ls_ekpo,
*****               ls_item_data,
*****               ls_accounting_data,
*****               ls_ekkn,
*****
*****               lr_accounting.
*****
*****        REFRESH: lt_accounting_data.
*****
*****        "~~~NEW DATA~~~
*****        "EKPO/Items
*****        ls_item_data = ls_po_item_ref-item->get_data( ).
*****
*****        MOVE-CORRESPONDING ls_item_data TO ls_ekpo.
*****        ls_ekpo-ebeln = ls_po_header-ebeln. "Failsafe
*****        APPEND ls_ekpo TO et_xekpo.
*****
*****        "Accounting Data
*****        lt_accounting_data = ls_po_item_ref-item->get_accountings( ).
*****        IF line_exists( lt_accounting_data[ 1 ] ).
*****          "New Accounting Data
*****          lr_accounting = lt_accounting_data[ 1 ]-accounting.
*****          ls_accounting_data = lr_accounting->get_data( ).
*****          MOVE-CORRESPONDING ls_accounting_data TO ls_ekkn.
*****          ls_ekkn-ebeln = ls_po_header-ebeln. "Failsafe
*****          APPEND ls_ekkn TO et_xekkn.
*****        ENDIF.
*****
*****        "Service Data
*****        CLEAR: lr_item_handle.
*****
*****        REFRESH: lt_esll.
*****
*****        lr_item_handle ?= ls_po_item_ref-item.
*****
*****        lr_item_handle->if_services_mm~get_srv_data(
*****        EXPORTING
*****          im_packno = ls_item_data-packno
*****        IMPORTING
*****          ex_esll = lt_esll
*****        EXCEPTIONS
*****          failure = 1
*****          OTHERS = 2
*****        ).
*****        IF sy-subrc = 0.
*****          et_xesll = VALUE #( BASE et_xesll
*****            (
*****              ebeln = ls_po_header-ebeln
*****              ebelp = ls_ekpo-ebelp
*****              esll = VALUE #( FOR ls_esll_001 IN lt_esll WHERE ( srvpos IS NOT INITIAL )
*****              (
*****                ls_esll_001
*****                )
*****              )
*****            )
*****          ).
*****        ENDIF.
*****
*****        CLEAR: ls_item_data,
*****               ls_ekpo.
*****
*****        "~~~OLD DATA~~~
*****        IF iv_only_current = abap_false.
*****          "EKPO/Item
*****          ls_po_item_ref-item->get_persistent_data(
*****          IMPORTING
*****            ex_data = ls_item_data
*****            EXCEPTIONS
*****              no_data = 1
*****              OTHERS = 2
*****          ).
*****
**********
**********          ls_po_item_ref-item->get_previous_data(
**********          IMPORTING
**********            ex_data = ls_item_data
**********            EXCEPTIONS
**********              no_data = 1
**********              OTHERS = 2
**********          ).
*****          IF sy-subrc = 0.
*****            IF ls_item_data IS NOT INITIAL.
*****              MOVE-CORRESPONDING ls_item_data TO ls_ekpo.
*****              ls_ekpo-ebeln = ls_po_header-ebeln. "Failsafe
*****              APPEND ls_ekpo TO et_yekpo.
*****            ENDIF.
*****          ENDIF.
*****
*****          CLEAR: ls_accounting_data,
*****                 ls_ekkn.
*****
*****          "Accounting Data
*****          IF lr_accounting IS NOT INITIAL.
*****            lr_accounting->get_persistent_data(
*****            IMPORTING
*****              ex_data = ls_accounting_data
*****            EXCEPTIONS
*****              no_data = 1
*****              OTHERS = 2
*****            ).
*****            IF sy-subrc = 0.
*****              IF ls_accounting_data IS NOT INITIAL.
*****                MOVE-CORRESPONDING ls_accounting_data TO ls_ekkn.
*****                ls_ekkn-ebeln = ls_po_header-ebeln. "Failsafe
*****                APPEND ls_ekkn TO et_yekkn.
*****              ENDIF.
*****            ENDIF.
*****          ENDIF.
*****
*****          "Service Data
*****          "Collect pack numbers so we can lookup later
*****          lt_packno = VALUE #( BASE lt_packno
*****            (
*****              ebelp = ls_item_data-ebelp
*****              packno = ls_item_data-packno
*****            )
*****          ).
*****        ENDIF.
*****      ENDLOOP.
*****    ENDIF.
*****
*****    "Get existing ESLL/Service lines from DB
*****    IF lt_packno[] IS NOT INITIAL.
*****
*****      lt_packno_001 = VALUE #(
*****       FOR ls_packno_001 IN lt_packno
*****       (
*****         packno = ls_packno_001-packno
*****       )
*****      ).
*****      SORT lt_packno_001 BY packno.
*****      DELETE ADJACENT DUPLICATES FROM lt_packno_001 COMPARING packno.
*****      DELETE lt_packno_001 WHERE packno IS INITIAL.
*****
*****      REFRESH: lt_esll,
*****               lt_esll_001.
*****
*****      IF lt_packno_001[] IS NOT INITIAL.
*****
*****        "Get Services in main package
*****        SELECT * FROM esll
*****                 INTO TABLE lt_esll_001
*****                 FOR ALL ENTRIES IN lt_packno_001
*****                 WHERE
*****                  packno = lt_packno_001-packno.
*****        APPEND LINES OF lt_esll_001 TO lt_esll.
*****
*****        SORT lt_esll_001 BY sub_packno.
*****        DELETE lt_esll_001 WHERE sub_packno IS INITIAL.
*****        DELETE ADJACENT DUPLICATES FROM lt_esll_001 COMPARING sub_packno.
*****
*****        "Get services in sub-package
*****        IF lt_esll_001[] IS NOT INITIAL.
*****          SELECT * FROM esll
*****                   APPENDING TABLE lt_esll
*****                   FOR ALL ENTRIES IN lt_esll_001
*****                   WHERE
*****                    packno = lt_esll_001-sub_packno.
*****        ENDIF.
*****
*****
*****      ENDIF.
*****
*****      IF lt_esll[] IS NOT INITIAL.
*****        LOOP AT lt_packno INTO DATA(ls_packno).
*****          "Get the sub package number
*****          CLEAR: lv_sub_packno.
*****          IF line_exists( lt_esll[ packno = ls_packno-packno package = abap_true ] ).
*****            lv_sub_packno = lt_esll[ packno = ls_packno-packno package = abap_true ]-sub_packno.
*****          ENDIF.
*****          et_yesll = VALUE #( BASE et_yesll
*****            (
*****              ebeln = ls_po_header-ebeln
*****              ebelp = ls_packno-ebelp
*****              esll = VALUE #( FOR ls_esll_002 IN lt_esll WHERE
*****                                                        (
*****                                                          ( packno = ls_packno-packno AND srvpos IS NOT INITIAL ) OR  "Services directly at package level
*****                                                          ( packno = lv_sub_packno    AND srvpos IS NOT INITIAL  )    "Services in sub package
*****                                                        )
*****              (
*****                ls_esll_002
*****                )
*****              )
*****            )
*****          ).
*****        ENDLOOP.
*****      ENDIF.
*****
*****    ENDIF.

*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-21 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>MM_TO_PM_ITEM_TRANSFER_001
* +-------------------------------------------------------------------------------------------------+
* | [--->] IS_NEKKO                       TYPE        EKKO
* | [--->] IT_XEKPO                       TYPE        MEOUT_T_UEKPO
* | [--->] IT_YEKPO                       TYPE        MEOUT_T_UEKPO(optional)
* | [--->] IT_XEKKN                       TYPE        MEOUT_T_UEKKN
* | [--->] IT_YEKKN                       TYPE        MEOUT_T_UEKKN(optional)
* | [--->] IT_XESLL                       TYPE        ZTT_MM_PO_ITEM_ESLL
* | [--->] IT_YESLL                       TYPE        ZTT_MM_PO_ITEM_ESLL(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD MM_TO_PM_ITEM_TRANSFER_001.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Add PO items to PM Order, conditionally                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-30th Mar 2026
*****    "FM to perform checks and add PO item to PM Order
*****    DATA: lv_task_name(32),
*****          lv_log_hdl         TYPE balloghndl.
*****
*****    CHECK is_nekko-bsart = 'ZR'. "PO to PMO transfer is applicable only for CRO Orders
*****
*****    IF line_exists( it_xekpo[ dummy_upd = abap_true ] ).
*****      "This is a recursive call
*****      "Called when attempting to update PM Order details to PO lines
*****      RETURN.
*****    ENDIF.
*****
*****    CLEAR: gv_po_to_pmo_complete, "Reset the flag that indicates ZMM_PO_TO_PMO_ITEM has completed
*****           gv_po_to_pmo_success.
*****
*****    lv_task_name = |POPMO_{ is_nekko-ebeln }_{ sy-datum }_{ sy-timlo }|.
*****
*****    "Lock all PM Orders specified in this PO
*****    "To  ensure user does not change them in any way, before asynchronous update is completed
*****    DATA(lt_ekkn) = it_xekkn[].
*****    APPEND LINES OF it_yekkn TO lt_ekkn.
*****
*****    SORT lt_ekkn BY aufnr.
*****    DELETE lt_ekkn WHERE aufnr IS INITIAL.
*****    DELETE ADJACENT DUPLICATES FROM lt_ekkn COMPARING aufnr.
*****
*****    LOOP AT lt_ekkn INTO DATA(ls_ekkn).
*****      zcl_pm_helper=>lock_pm_order(
*****      EXPORTING
*****        iv_aufnr = ls_ekkn-aufnr
*****      ).
*****    ENDLOOP.
*****
*****    CALL FUNCTION 'ZMM_PO_TO_PMO_ITEM'
*****      STARTING NEW TASK lv_task_name
*****      CALLING mm_to_pm_item_transfer_done ON END OF TASK
**********      IN BACKGROUND TASK
**********      DESTINATION 'NONE'
*****      EXPORTING
*****        is_ekko     = is_nekko
*****        it_ekpo     = it_xekpo[]
*****        it_ekpo_old = it_yekpo[]
*****        it_ekkn     = it_xekkn[]
*****        it_ekkn_old = it_yekkn[]
*****        it_esll     = it_xesll[]
*****        it_esll_old = it_yesll[].
*****
*****
*****
*****    WAIT FOR ASYNCHRONOUS TASKS UNTIL gv_po_to_pmo_complete = abap_true.
*****
*****    IF gv_po_to_pmo_success = abap_false.
*****      zcl_xx_msg_logger=>initialize_log(
*****      EXPORTING
*****        iv_object = 'ZMM'
*****        iv_subobj = 'ZMM_PO_PMO'
*****      IMPORTING
*****        ev_log_hdl = lv_log_hdl ).
*****
*****      zcl_xx_msg_logger=>add_msg_to_log(
*****      EXPORTING
*****        iv_log_hdl = lv_log_hdl
*****        iv_msgty = 'E'
*****        iv_msgid = 'ZMM'
*****        iv_msgno = '030'
*****        iv_msgv1 = is_nekko-ebeln
*****        iv_msgv2 = space
*****        iv_msgv3 = space
*****        iv_msgv4 = space
*****        iv_disp_msg  = abap_false
*****        ).
*****      IF 1 = 2.
*****        MESSAGE ID 'ZMM' TYPE 'E' NUMBER '030' WITH is_nekko-ebeln.
*****      ENDIF.
*****      zcl_xx_msg_logger=>close_log(
*****      EXPORTING
*****        iv_log_hdl = lv_log_hdl ).
*****
*****      MESSAGE ID 'ZMM' TYPE 'E' NUMBER '030' WITH is_nekko-ebeln.
*****
*****    ENDIF.
*****
*****    CLEAR:  gv_po_to_pmo_complete,
*****    gv_po_to_pmo_success,
*****    lv_task_name.

*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-30th Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>MM_TO_PM_ITEM_TRANS_DONE_001
* +-------------------------------------------------------------------------------------------------+
* | [--->] P_TASK                         TYPE        CHAR32
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD MM_TO_PM_ITEM_TRANS_DONE_001.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Monitor asynchronous call to ZMM_PO_TO_PMO_ITEM         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-23rd Jul 2025
    gv_po_to_pmo_complete = abap_true.

    RECEIVE RESULTS FROM FUNCTION 'ZMM_PO_TO_PMO_ITEM'
    IMPORTING
      ev_success = gv_po_to_pmo_success
    EXCEPTIONS
      OTHERS = 1.
    IF sy-subrc <> 0.
      gv_po_to_pmo_success = abap_false.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-23rd Jul 2025
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>PO_FIND_COST_CENTER
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_EBELN                       TYPE        EBELN(optional)
* | [--->] IV_EBELP                       TYPE        EBELP(optional)
* | [--->] IS_PO_LINE_ACC_DET             TYPE        EKKNU(optional)
* | [--->] IS_PO_LINE_AAC                 TYPE        BEKPO(optional)
* | [<---] EV_COST_CENTER                 TYPE        KOSTL
* | [<---] EV_CO_AREA                     TYPE        KOKRS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD po_find_cost_center.
*----------------------------OBJECT SUMMARY---------------------------------*
* Developer: NASDM Gnanaraj (KOPLASDJ)                                     *
* Date: 2nd Mar 2026                                                        *
* Reference: PM-MM CRO PO Integration                                       *
* Description: Re-make of FM 'ZMM_PO_FIND_COST_CENTER'                      *
*              Determine cost center, based on Account Assignment Category  *
*              (AAC) using details available on the PO Line item            *
*              AAC = 'A' (Asset Account Assignment) - To be decided         *
*              AAC = 'F' (PM Work Order) - To be decided                    *
*              AAC = 'K' (Cost Center) - This FM is not needed. Cost center *
*              is directly mentioned on line item                           *
*              AAC = 'N' (Network) - To be decided                          *
*              AAC = 'P' (Project) - Get cost center linked to WBS Element  *
*---------------------------------------------------------------------------*
*----------------------------CHANGE HISTORY---------------------------------*
*---------------------------------------------------------------------------*
* Developer:                                                                *
* Date:                                                                     *
* Reference Change/Incident:                                                *
* Change Indicator:                                                         *
* Description:                                                              *
*---------------------------------------------------------------------------*

    DATA: ls_po_line_acc_det TYPE ekknu,
          ls_po_line_aac     TYPE bekpo.


    CLEAR: ev_cost_center,
           ev_co_area.

    IF iv_ebeln IS SUPPLIED AND
       iv_ebelp IS SUPPLIED AND
       iv_ebeln IS NOT INITIAL AND
       iv_ebelp IS NOT INITIAL."If PO and line number is provided
      SELECT SINGLE ebeln, ebelp, zekkn, kostl, anln1, aufnr, ps_psp_pnr, nplnr
             FROM ekkn INTO CORRESPONDING FIELDS OF @ls_po_line_acc_det
             WHERE
              ebeln = @iv_ebeln AND
              ebelp = @iv_ebelp."Get the account details specific to the PO Line
      SELECT SINGLE ebeln, ebelp, bukrs, knttp
        FROM ekpo
        INTO CORRESPONDING FIELDS OF @ls_po_line_aac
        WHERE
          ebeln = @iv_ebeln AND
          ebelp = @iv_ebelp."Get AAC maintained in the PO line
    ELSE."If the line level details are provided
      ls_po_line_acc_det = is_po_line_acc_det.
      ls_po_line_aac = is_po_line_aac.
    ENDIF.


    CASE ls_po_line_aac-knttp.
      WHEN gc_aac_asset_aa.  "Asset
        "Retrieve the valid cost center based on the company code, asset
        SELECT SINGLE kostl
               FROM   anlz
               INTO   ev_cost_center
               WHERE
                bukrs = ls_po_line_aac-bukrs AND
                anln1 = ls_po_line_acc_det-anln1 AND
                bdatu GE sy-datum AND
                adatu LE sy-datum.
      WHEN gc_aac_pm_w_ord. "PM Work Order
        "Retrieve the valid cost center based on the Work Order number
        SELECT SINGLE kokrs
                      kostv
               FROM   aufk
               INTO   ( ev_co_area, ev_cost_center )
               WHERE
                aufnr = ls_po_line_acc_det-aufnr.
      WHEN gc_aac_cost_ctr. "Cost Center
        "Cost center is directly available in PO Line item
        ev_cost_center = ls_po_line_acc_det-kostl.
        ev_co_area = ls_po_line_acc_det-kokrs.
      WHEN gc_aac_nw_assgn. "Network
        "Network number is on PO Line item
        "WBS Element is linked to the network number
        "Cost center is linked to the  WBS Element
        SELECT SINGLE a~pspel,
                      p~pkokr,
                      p~akstl,
                      p~fkstl
               FROM aufk AS a INNER JOIN prps AS p
               ON p~pspnr = a~pspel
               INTO @DATA(ls_nw_cost_center)
               WHERE
                a~aufnr = @ls_po_line_acc_det-nplnr.
        IF ls_nw_cost_center-fkstl IS NOT INITIAL. "Responsible cost center
          ev_cost_center = ls_nw_cost_center-fkstl.
          ev_co_area = ls_nw_cost_center-pkokr.

          "Below is commented. In case it is specifically requested, we will uncomment it
*****      ELSEIF ls_nw_cost_center-akstl IS NOT INITIAL.  "Requesting cost center
*****        EV_COST_CENTER = ls_nw_cost_center-akstl.
        ENDIF.
      WHEN gc_aac_wbs_elmt.  "Account Assignment Category
        "Construct the WBS Element Object number PR<WBS Object number>
        DATA(lv_wbs_objnr) = |{ gc_pre_wbs_objnr }| & |{ ls_po_line_acc_det-ps_psp_pnr }|.
        "Get the cost center mapped to the WBS Element from DB table PRPS
        SELECT  SINGLE  pkokr,
                        fkstl,
                        akstl
                FROM prps
                INTO @DATA(ls_prps)
                WHERE
                  objnr = @lv_wbs_objnr.
        IF ls_prps-fkstl IS NOT INITIAL. "Responsible cost center
          ev_cost_center = ls_prps-fkstl.
          ev_co_area = ls_prps-pkokr.
          "Below is commented. In case it is specifically requested, we will uncomment it
*****      ELSEIF ls_prps-akstl IS NOT INITIAL.  "Requesting cost center
*****        EV_COST_CENTER = ls_prps-akstl.
        ENDIF.
      WHEN OTHERS.
        RETURN.
    ENDCASE.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>REMOVE_PO_MM_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_CONTEXT                     TYPE        INT4
* | [--->] IV_OBJID                       TYPE        INT4
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD remove_po_mm_message.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Add a PO item processing message                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-29 Apr 2026
    INCLUDE mm_messages_mac.

    "The below check happens inside the macro but we are unable to handle the exception
    "So, we check in advance, pre-emptively
    cl_handle_manager_mm=>get(
    EXPORTING
      im_id = iv_objid
    EXCEPTIONS
      failure = 1
      OTHERS  = 2
      ).

    IF sy-subrc NE 0.
      RETURN.
    ENDIF.

    ASSIGN gt_message_tracker[ context = iv_context busobj = iv_objid message_exist = abap_true ] TO FIELD-SYMBOL(<lfs_msg_tracker>).
    IF sy-subrc = 0.
      mmpur_remove_msg_by_context iv_objid iv_context.
      <lfs_msg_tracker>-message_exist = abap_false.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-29 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>RETRIEVE_ME2L_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NO_OUTPUT                   TYPE        BOOLE_D
* | [--->] IV_LISTU                       TYPE        LISTU (default ='ALV')
* | [--->] IV_GULDT                       TYPE        P_GULDT
* | [--->] IV_RWEIT                       TYPE        P_RWEIT
* | [--->] IV_TXZ01                       TYPE        TXZ01
* | [--->] IV_NAME1                       TYPE        AD_NAME1
* | [--->] IR_LIFNR                       TYPE        MD_RANGE_T_LIFNR
* | [--->] IR_EKORG                       TYPE        CMM_T_IDX_EKORG_RNG
* | [--->] IR_SELPA                       TYPE        ZMM_TT_SELPA_RNG
* | [--->] IR_BSART                       TYPE        BLGL_BSART_RANGE_TT
* | [--->] IR_EKGRP                       TYPE        MMPURUI_EKGRP_RANGE_TTY
* | [--->] IR_WERKS                       TYPE        MMPUR_T_WERKS
* | [--->] IR_PSTYP                       TYPE        ZMM_TT_EPSTP_RNG
* | [--->] IR_KNTTP                       TYPE        FIP_T_KNTTP_RANGE
* | [--->] IR_EINDT                       TYPE        BLGL_EINDT_RANGE_TT
* | [--->] IR_EBELN                       TYPE        MMPUR_T_EBELN
* | [--->] IR_MATNR                       TYPE        FRE_MATNR_RANG_TTY
* | [--->] IR_MATKL                       TYPE        MMPUR_T_MATKL
* | [--->] IR_BEDAT                       TYPE        WRF_PBAS_BEDAT_RTTY
* | [--->] IR_EAN11                       TYPE        MMPUR_T_EAN11
* | [--->] IR_IDNLF                       TYPE        MMPUR_T_IDNLF
* | [--->] IR_LTSNR                       TYPE        MMPUR_T_LTSNR
* | [--->] IR_AKTNR                       TYPE        FIP_T_AKTRN_RANGE
* | [--->] IR_SAISO                       TYPE        WPOCS_SAISO_RANGE_TAB
* | [--->] IR_SAISJ                       TYPE        WPOCS_SAISJ_RANGE_TAB
* | [<-()] RT_ME2L_OUT                    TYPE        ZMM_TT_ME2L_OUT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD RETRIEVE_ME2L_DATA.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      13th Jan 2026                                             *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Execute ME2L and retrieve the output                    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-13th Jan 2026
    DATA: lv_pri_params_valid,
          lv_jobname          TYPE tbtco-jobname,
          lv_job_count        TYPE tbtcjob-jobcount,

          ls_output           TYPE merep_outtab_purchdoc,
          ls_pri_params       TYPE pri_params,

          lr_me2l_out         TYPE REF TO data.

    FIELD-SYMBOLS: <lfs_me2l_out> TYPE any,
                   <lft_me2l_out> TYPE ANY TABLE.

    IF iv_no_output = abap_true.
      "Set parameters to suppress display of ALV but return the data
      cl_salv_bs_runtime_info=>set(
        display = abap_false
        metadata = abap_false
        data = abap_true
      ).
    ELSE.
      cl_salv_bs_runtime_info=>clear_all( ).
    ENDIF.

    IF sy-batch = abap_true.
      "Get the t-code assigned for ME2L extension report
      SELECT SINGLE low
             FROM   tvarvc
             INTO   @DATA(lv_tcode)
             WHERE
              name = 'ZME2L_TCODE'.
      IF sy-subrc = 0.
      ELSE.
        lv_tcode = 'ZMM_PO_APPROVERS'.
      ENDIF.


      lv_jobname = |{ lv_tcode }_{ sy-datum }_{ sy-timlo }|.
      CALL FUNCTION 'JOB_OPEN'
        EXPORTING
          jobname          = lv_jobname
        IMPORTING
          jobcount         = lv_job_count
        EXCEPTIONS
          cant_create_job  = 1
          invalid_job_data = 2
          jobname_missing  = 3
          OTHERS           = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
        MESSAGE ID 'ZMM' TYPE 'E' NUMBER '186'.
      ENDIF.


      CALL FUNCTION 'GET_PRINT_PARAMETERS'
        EXPORTING
          immediately            = abap_false
          mode                   = 'BATCH'
          no_dialog              = abap_true
        IMPORTING
          out_parameters         = ls_pri_params
          valid                  = lv_pri_params_valid
        EXCEPTIONS
          archive_info_not_found = 1
          invalid_print_params   = 2
          invalid_archive_params = 3
          OTHERS                 = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      "Call ME2L in BG
      SUBMIT rm06el00
        VIA JOB lv_jobname NUMBER lv_job_count
        TO SAP-SPOOL
        SPOOL PARAMETERS ls_pri_params
        WITHOUT SPOOL DYNPRO
        WITH  el_lifnr IN  ir_lifnr "Verified
        WITH  el_ekorg IN ir_ekorg "Verified
******>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-4th Feb 2026
*****        WITH  el_selkb =  abap_true
*****        WITH  el_selkk =  abap_false
*****        WITH  el_selkl =  abap_false
*****        WITH  el_selka =  abap_false
******<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-4th Feb 2026
        WITH  selpa IN  ir_selpa
        WITH  s_bsart IN  ir_bsart "Verified
        WITH  s_ekgrp IN  ir_ekgrp "Verified
        WITH  s_werks IN  ir_werks "Verified
        WITH  s_pstyp IN  ir_pstyp "Verified
        WITH  s_knttp IN  ir_knttp "Verified
        WITH  s_eindt IN  ir_eindt "Verified
        WITH  s_ebeln IN  ir_ebeln "Verified
        WITH  s_matnr IN  ir_matnr "Verified
        WITH  s_matkl IN  ir_matkl "Verified
        WITH  s_bedat IN  ir_bedat  "Verified
        WITH  s_ean11 IN  ir_ean11  "Partially Verified
        WITH  s_idnlf IN  ir_idnlf  "Partially Verified
        WITH  s_ltsnr IN  ir_ltsnr  "Partially Verified
        WITH  s_aktnr IN  ir_aktnr  "Partially Verified
        WITH  s_saiso IN  ir_saiso  "Partially Verified
        WITH  s_saisj IN  ir_saisj  "Partially Verified

        WITH  listu = iv_listu  "Verified
        WITH  p_guldt = iv_guldt "Partially Verified
        WITH  p_rweit = iv_rweit "Partially Verified
        WITH  p_txz01 = iv_txz01 "Verified
        WITH  p_name1 = iv_name1 "Verified

      AND RETURN.

      CALL FUNCTION 'JOB_CLOSE'
        EXPORTING
          jobcount             = lv_job_count
          jobname              = lv_jobname
          strtimmed            = abap_true
        EXCEPTIONS
          cant_start_immediate = 1
          invalid_startdate    = 2
          jobname_missing      = 3
          job_close_failed     = 4
          job_nosteps          = 5
          job_notex            = 6
          lock_failed          = 7
          invalid_target       = 8
          OTHERS               = 9.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    ELSE.
      "Call ME2L in FG
      SUBMIT rm06el00
        WITH  el_lifnr IN  ir_lifnr "Verified
        WITH  el_ekorg IN ir_ekorg "Verified
        WITH  selpa IN  ir_selpa
        WITH  s_bsart IN  ir_bsart "Verified
        WITH  s_ekgrp IN  ir_ekgrp "Verified
        WITH  s_werks IN  ir_werks "Verified
        WITH  s_pstyp IN  ir_pstyp "Verified
        WITH  s_knttp IN  ir_knttp "Verified
        WITH  s_eindt IN  ir_eindt "Verified
        WITH  s_ebeln IN  ir_ebeln "Verified
        WITH  s_matnr IN  ir_matnr "Verified
        WITH  s_matkl IN  ir_matkl "Verified
        WITH  s_bedat IN  ir_bedat  "Verified
        WITH  s_ean11 IN  ir_ean11  "Partially Verified
        WITH  s_idnlf IN  ir_idnlf  "Partially Verified
        WITH  s_ltsnr IN  ir_ltsnr  "Partially Verified
        WITH  s_aktnr IN  ir_aktnr  "Partially Verified
        WITH  s_saiso IN  ir_saiso  "Partially Verified
        WITH  s_saisj IN  ir_saisj  "Partially Verified

        WITH  listu = iv_listu  "Verified
        WITH  p_guldt = iv_guldt "Partially Verified
        WITH  p_rweit = iv_rweit "Partially Verified
        WITH  p_txz01 = iv_txz01 "Verified
        WITH  p_name1 = iv_name1 "Verified

      AND RETURN.                                        "#EC CI_SUBMIT
    ENDIF.
    IF iv_no_output = abap_true.
      TRY.
          cl_salv_bs_runtime_info=>get_data_ref(
          IMPORTING
            r_data = lr_me2l_out
          ).
        CATCH cx_salv_bs_sc_runtime_info.
          MESSAGE text-001 TYPE 'S'.
      ENDTRY.

      cl_salv_bs_runtime_info=>clear_all( ).


      ASSIGN lr_me2l_out->* TO <lft_me2l_out>.

      IF <lft_me2l_out> IS ASSIGNED.
        LOOP AT <lft_me2l_out> ASSIGNING <lfs_me2l_out>.
          MOVE-CORRESPONDING <lfs_me2l_out> TO ls_output.
          APPEND ls_output TO rt_me2l_out.
        ENDLOOP.
      ENDIF.
    ENDIF.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-13th Jan 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>RETRIEVE_ME2M_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] IR_MATNR                       TYPE        MMPUR_T_MATNR
* | [--->] IR_WERKS                       TYPE        MMPUR_T_WERKS
* | [<-()] RT_ME2M_OUT                    TYPE        ZMM_TT_ME2M_OUT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD retrieve_me2m_data.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Dec 2025                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Return output of ME2M Execution                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-2nd Dec 2025

    DATA: ls_output   TYPE zmm_st_me2m_out,

          lr_me2m_out TYPE REF TO data.

    FIELD-SYMBOLS: <lfs_me2m_out> TYPE any,
                   <lft_me2m_out> TYPE ANY TABLE.

    "Set parameters to suppress display of ALV but return the data
    cl_salv_bs_runtime_info=>set(
      display = abap_false
      metadata = abap_false
      data = abap_true
    ).

    "Call ME2M
    SUBMIT rm06em00
    WITH em_matnr IN ir_matnr[]
    with em_werks in ir_werks[] "INSERTED -QAOPSD-NASDM-KOPLASDJ-28th Jan 2026
    WITH listu = 'ALV'
    AND RETURN. "#EC CI_SUBMIT

    TRY.
        cl_salv_bs_runtime_info=>get_data_ref(
        IMPORTING
          r_data = lr_me2m_out
        ).
      CATCH cx_salv_bs_sc_runtime_info.
        MESSAGE text-001 TYPE 'S'.
    ENDTRY.

    cl_salv_bs_runtime_info=>clear_all( ).

    ASSIGN lr_me2m_out->* TO <lft_me2m_out>.

    LOOP AT <lft_me2m_out> ASSIGNING <lfs_me2m_out>.
      MOVE-CORRESPONDING <lfs_me2m_out> TO ls_output.
      APPEND ls_output TO rt_me2m_out.
    ENDLOOP.

*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-2nd Dec 2025
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>RETRIEVE_PDOC_APPROVERS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_EBAN                        TYPE        MEREQ_T_EBAN(optional)
* | [--->] IT_EKKO                        TYPE        ME_EKKO(optional)
* | [--->] IV_GET_POTENTIAL_APPROVERS     TYPE        BOOLE_D (default ='')
* | [<---] ET_APP_PO_POTN                 TYPE        ZTT_PD_APPR_LIST
* | [<---] ET_APP_PO_ACTL                 TYPE        ZTT_PD_APPR_LIST
* | [<---] ET_APP_PR_POTN                 TYPE        ZTT_PD_APPR_LIST
* | [<---] ET_APP_PR_ACTL                 TYPE        ZTT_PD_APPR_LIST
* | [<---] ET_USR_NAMES                   TYPE        FDM_T_USER_NAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD retrieve_pdoc_approvers.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      13th Jan 2026                                             *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Retrieve details of approvers of PO/PR                  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-19th Jan 2026
    DATA:

      ls_actors    TYPE zst_pd_appr_list,

      lt_actors    TYPE ztt_pd_appr_list,
      lt_container TYPE STANDARD TABLE OF  swcont,

      lt_cdhdr     TYPE cdhdr_tab,
      lt_cdpos     TYPE cdpos_tab,

      lt_eban      TYPE mereq_t_eban,
      lt_ekko      TYPE me_ekko,
      lt_chg_obj   TYPE STANDARD TABLE OF cdobjectv,

      lt_uids      TYPE usmd_t_user.

    REFRESH: et_app_po_potn,
             et_app_pr_potn,

             et_app_po_actl,
             et_app_pr_actl.

    IF iv_get_potential_approvers = abap_true.
      IF it_eban[] IS NOT INITIAL.
        "Retrieve the release codes for each PR
        "Based on Release Group & Release Strategy
        SELECT  * FROM t16fs
                        INTO TABLE @DATA(lt_t16fs_pr)
                        FOR ALL ENTRIES IN @it_eban
                        WHERE
                          frggr = @it_eban-frggr AND
                          frgsx = @it_eban-frgst.
        LOOP AT it_eban INTO DATA(ls_eban).
          " --- Get Container Values ---
          IF line_exists( lt_t16fs_pr[ frggr = ls_eban-frggr frgsx = ls_eban-frgst ] ).
            REFRESH: lt_actors.
            DATA(ls_t16fs) = lt_t16fs_pr[ frggr = ls_eban-frggr frgsx = ls_eban-frgst ].
            "Retrieve the Potential approvers for the PO
            CALL FUNCTION 'ZMM_PD_REL_STR_APPROVERS'
              EXPORTING
                iv_pr_num    = ls_eban-banfn
                iv_pr_itm    = ls_eban-bnfpo
                iv_rel_grp   = ls_eban-frggr
                iv_rel_str   = ls_eban-frgst
                is_t16fs     = ls_t16fs
              IMPORTING
                et_approvers = lt_actors.
            IF lt_actors[] IS NOT INITIAL.
              "Update PR item number
              ls_actors-pur_doc_item = ls_eban-bnfpo.
              MODIFY lt_actors FROM ls_actors TRANSPORTING pur_doc_item WHERE pur_doc = ls_eban-banfn.

              APPEND LINES OF lt_actors TO et_app_pr_potn.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF it_ekko[] IS NOT INITIAL.
        "Retrieve the release codes for each PO
        "Based on Release Group & Release Strategy
        SELECT  * FROM t16fs
                        INTO TABLE @DATA(lt_t16fs_po)
                        FOR ALL ENTRIES IN @it_ekko
                        WHERE
                          frggr = @it_ekko-frggr AND
                          frgsx = @it_ekko-frgsx.
        LOOP AT it_ekko INTO DATA(ls_ekko).
          " --- Get Container Values ---
          IF line_exists( lt_t16fs_po[ frggr = ls_ekko-frggr frgsx = ls_ekko-frgsx ] ).
            REFRESH: lt_actors.
            ls_t16fs = lt_t16fs_po[ frggr = ls_ekko-frggr frgsx = ls_ekko-frgsx ].
            "Retrieve the Potential approvers for the PO
            CALL FUNCTION 'ZMM_PD_REL_STR_APPROVERS'
              EXPORTING
                iv_po_num    = ls_ekko-ebeln
                iv_rel_grp   = ls_ekko-frggr
                iv_rel_str   = ls_ekko-frgsx
                is_t16fs     = ls_t16fs
              IMPORTING
                et_approvers = lt_actors.
            IF lt_actors[] IS NOT INITIAL.
              "PO Approvals are at header level, no need of item number

              APPEND LINES OF lt_actors TO et_app_po_potn.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
    "Retrieve the change documents showing approver details
    "For PR
    "Note: We do not use standard FM ME_CHANGEDOC_READ2,
    "As we need to repeat call it for every PO & PR
    REFRESH: lt_chg_obj,
             lt_cdhdr,
             lt_cdpos.

    lt_eban[] = it_eban[].
    SORT lt_eban BY banfn ASCENDING.
    DELETE lt_eban WHERE banfn IS INITIAL.
    DELETE ADJACENT DUPLICATES FROM lt_eban COMPARING banfn.

    IF lt_eban[] IS NOT INITIAL.
      "Convert all PR numbers to same format as Change document object ID
      LOOP AT lt_eban INTO ls_eban.
        APPEND ls_eban-banfn TO lt_chg_obj.
      ENDLOOP.

      "Get the change headers, for changes done to the PR
      SELECT * FROM cdhdr
               INTO TABLE @lt_cdhdr
               FOR ALL ENTRIES IN @lt_chg_obj
               WHERE
                objectclas = @gc_chg_obj_pr AND
                objectid   = @lt_chg_obj-table_line.
      IF sy-subrc = 0.
        SORT lt_cdhdr BY changenr ASCENDING.

        DELETE lt_cdhdr WHERE changenr IS INITIAL.
        DELETE ADJACENT DUPLICATES FROM lt_cdhdr COMPARING changenr.

        IF lt_cdhdr[] IS NOT INITIAL.
          "Get the specific changes done to release status of PRs
          SELECT * FROM cdpos
                   INTO TABLE @lt_cdpos
                   FOR ALL ENTRIES IN @lt_cdhdr
                   WHERE
                    objectclas = @gc_chg_obj_pr AND
                    objectid   = @lt_cdhdr-objectid AND
                    changenr   = @lt_cdhdr-changenr AND
                    tabname    = @gc_chg_tab_pr AND
                    fname      = @gc_chg_fld_rel.

          IF lt_cdpos[] IS NOT INITIAL.
            et_app_pr_actl = translate_cdoc_to_pdoc_appr(
            it_cdhdr = lt_cdhdr[]
            it_cdpos = lt_cdpos[]
            ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    "Retrieve the change documents showing approver details
    "For PO

    REFRESH: lt_chg_obj,
             lt_cdhdr,
             lt_cdpos.

    lt_ekko[] = it_ekko[].
    SORT lt_ekko BY ebeln ASCENDING.
    DELETE lt_ekko WHERE ebeln IS INITIAL.
    DELETE ADJACENT DUPLICATES FROM lt_ekko COMPARING ebeln.

    IF lt_ekko[] IS NOT INITIAL.
      "Convert all PR numbers to same format as Change document object ID
      LOOP AT lt_ekko INTO ls_ekko.
        APPEND ls_ekko-ebeln TO lt_chg_obj.
      ENDLOOP.

      "Get the change headers, for changes done to the PO
      SELECT * FROM cdhdr
               INTO TABLE @lt_cdhdr
               FOR ALL ENTRIES IN @lt_chg_obj
               WHERE
                objectclas = @gc_chg_obj_po AND
                objectid   = @lt_chg_obj-table_line.
      IF sy-subrc = 0.
        SORT lt_cdhdr BY changenr ASCENDING.

        DELETE lt_cdhdr WHERE changenr IS INITIAL.
        DELETE ADJACENT DUPLICATES FROM lt_cdhdr COMPARING changenr.

        IF lt_cdhdr[] IS NOT INITIAL.
          "Get the specific changes done to release status of POs
          SELECT * FROM cdpos
                   INTO TABLE @lt_cdpos
                   FOR ALL ENTRIES IN @lt_cdhdr
                   WHERE
                    objectclas = @gc_chg_obj_po AND
                    objectid   = @lt_cdhdr-objectid AND
                    changenr   = @lt_cdhdr-changenr AND
                    tabname    = @gc_chg_tab_po AND
                    fname      = @gc_chg_fld_rel.

          IF lt_cdpos[] IS NOT INITIAL.

            et_app_po_actl = translate_cdoc_to_pdoc_appr(
            it_cdhdr = lt_cdhdr[]
            it_cdpos = lt_cdpos[]
            ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    "Retrieve names of all approvers
    "User IDs of PO Potential Approvers
    lt_uids = VALUE #(
      FOR ls_po_potn IN et_app_po_potn
      (
        ls_po_potn-objid
      )
    ).

    "User IDs of PO Actual Approvers
    lt_uids = VALUE #( BASE lt_uids
      FOR ls_po_actl IN et_app_po_actl
      (
        ls_po_actl-objid
      )
    ).

    "User IDs of PR Potential Approvers
    lt_uids = VALUE #( BASE lt_uids
      FOR ls_pr_potn IN et_app_pr_potn
      (
        ls_pr_potn-objid
      )
    ).

    "User IDs of PR Actual Approvers
    lt_uids = VALUE #( BASE lt_uids
      FOR ls_pr_actl IN et_app_pr_actl
      (
        ls_pr_actl-objid
      )
    ).

    et_usr_names = zcl_abap_helper=>get_sap_user_names(
    EXPORTING
    it_user_ids = lt_uids
    ).

*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-19th Jan 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER=>RETRIEVE_SERVICE_DETAILS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_EBELN                       TYPE        EBELN
* | [--->] IT_EKPO                        TYPE        MMPR_UEKPO
* | [<---] ET_XESLL                       TYPE        ZTT_MM_PO_ITEM_ESLL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD retrieve_service_details.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Prepare inputs for PO to PMO Conversion                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-21 Apr 2026

    DATA: lv_sub_packno TYPE packno,

          lt_packno     TYPE STANDARD TABLE OF zmm_st_po_item_x_packno,
          lt_packno_001 TYPE STANDARD TABLE OF pack_tab,
          lt_esll	      TYPE mmsrv_esll,
          lt_esll_001	  TYPE mmsrv_esll.


    lt_packno = VALUE #(
    FOR ls_ekpo_001 IN it_ekpo
    (
      ebelp = ls_ekpo_001-ebelp
      packno = ls_ekpo_001-packno
    )
    ).
    "Get existing ESLL/Service lines from DB
    IF lt_packno[] IS NOT INITIAL.

      lt_packno_001 = VALUE #(
       FOR ls_packno_001 IN lt_packno
       (
         packno = ls_packno_001-packno
       )
      ).
      SORT lt_packno_001 BY packno.
      DELETE ADJACENT DUPLICATES FROM lt_packno_001 COMPARING packno.
      DELETE lt_packno_001 WHERE packno IS INITIAL.

      REFRESH: lt_esll,
               lt_esll_001.

      IF lt_packno_001[] IS NOT INITIAL.

        "Get Services in main package
        SELECT * FROM esll
                 INTO TABLE lt_esll_001
                 FOR ALL ENTRIES IN lt_packno_001
                 WHERE
                  packno = lt_packno_001-packno.
        APPEND LINES OF lt_esll_001 TO lt_esll.

        SORT lt_esll_001 BY sub_packno.
        DELETE lt_esll_001 WHERE sub_packno IS INITIAL.
        DELETE ADJACENT DUPLICATES FROM lt_esll_001 COMPARING sub_packno.

        "Get services in sub-package
        IF lt_esll_001[] IS NOT INITIAL.
          SELECT * FROM esll
                   APPENDING TABLE lt_esll
                   FOR ALL ENTRIES IN lt_esll_001
                   WHERE
                    packno = lt_esll_001-sub_packno.
        ENDIF.


      ENDIF.

      IF lt_esll[] IS NOT INITIAL.
        LOOP AT lt_packno INTO DATA(ls_packno).
          "Get the sub package number
          CLEAR: lv_sub_packno.
          IF line_exists( lt_esll[ packno = ls_packno-packno package = abap_true ] ).
            lv_sub_packno = lt_esll[ packno = ls_packno-packno package = abap_true ]-sub_packno.
          ENDIF.
          et_xesll = VALUE #( BASE et_xesll
            (
              ebeln = iv_ebeln
              ebelp = ls_packno-ebelp
              esll = VALUE #( FOR ls_esll_002 IN lt_esll WHERE
                                                        (
                                                          ( packno = ls_packno-packno AND srvpos IS NOT INITIAL ) OR  "Services directly at package level
                                                          ( packno = lv_sub_packno    AND srvpos IS NOT INITIAL  )    "Services in sub package
                                                        )
              (
                ls_esll_002
                )
              )
            )
          ).
        ENDLOOP.
      ENDIF.

    ENDIF.

*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-21 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Private Method ZCL_MM_HELPER=>TRANSLATE_CDOC_TO_PDOC_APPR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_CDHDR                       TYPE        CDHDR_TAB
* | [--->] IT_CDPOS                       TYPE        CDPOS_TAB
* | [<-()] RT_APPR                        TYPE        ZTT_PD_APPR_LIST
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD TRANSLATE_CDOC_TO_PDOC_APPR.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAA (KOPLASDJ)                       *
* Date:      13th Jan 2026                                             *
* Reference Change/Incident:  QAOPSD                               *
* Change Indicator: QAOPSD-NASDM-KOPLASDJ                         *
* Description: Conver CDHDR/CDPOS entries to a formatted list          *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-QAOPSD-NASDM-KOPLASDJ-19th Jan 2026
    DATA: lv_appr_level    TYPE i,
          lv_prev_appr_lvl TYPE i,
          lv_tot_lvl_appr  TYPE i,
          lv_tot_lvl_dppr  TYPE i,

          lv_pdoc_fmt      TYPE ebeln,
          lv_pitm_fmt      TYPE bnfpo,

          ls_ekko          TYPE ekko,
          ls_eban          TYPE eban,

          lt_cdhdr         TYPE cdhdr_tab,
          lt_cdpos         TYPE cdpos_tab.

    lt_cdhdr = it_cdhdr.
    lt_cdpos = it_cdpos.

    SORT lt_cdhdr BY objectid ASCENDING udate ASCENDING utime ASCENDING.
    SORT lt_cdpos BY objectid ASCENDING
                     changenr ASCENDING.
    "Change document to internal format
    LOOP AT lt_cdhdr INTO DATA(ls_cdhdr).
      lv_pdoc_fmt = ls_cdhdr-objectid.
      LOOP AT lt_cdpos INTO DATA(ls_cdpos)
                       WHERE
                        objectid = ls_cdhdr-objectid AND
                        changenr = ls_cdhdr-changenr.
        "We loop through every change document
        "Releated to the PR being released

        "Extract the KEY
        CLEAR: lv_pitm_fmt.
        IF ls_cdpos-tabname = gc_chg_tab_po.
          ls_ekko = ls_cdpos-tabkey.
        ELSEIF ls_cdpos-tabname = gc_chg_tab_pr.
          ls_eban = ls_cdpos-tabkey.
          lv_pitm_fmt = ls_eban-bnfpo.
        ENDIF.

        lv_prev_appr_lvl = strlen( ls_cdpos-value_old ).

        "The field VALUE_NEW will contain N number of X
        "Showing the number of levels approved during the transaction
        lv_appr_level = strlen( ls_cdpos-value_new ).

        lv_tot_lvl_appr = lv_appr_level - lv_prev_appr_lvl.

        "If the change document is referring to a UNRELEASE
        "Where an approval was reversed
        IF lv_appr_level < lv_prev_appr_lvl.
          lv_tot_lvl_dppr = lv_prev_appr_lvl - lv_appr_level.
          "Remove entries related to the cancelled approvals
          DO lv_tot_lvl_dppr TIMES.
            lv_appr_level = lv_prev_appr_lvl - ( sy-index - 1 ).
            DELETE rt_appr WHERE
                           pur_doc = lv_pdoc_fmt AND
                           approver_level = lv_appr_level.
          ENDDO.
        ELSE.

          DO lv_tot_lvl_appr TIMES.
            lv_appr_level = lv_prev_appr_lvl + sy-index.
            IF line_exists( rt_appr[  pur_doc = lv_pdoc_fmt
                                      pur_doc_item = lv_pitm_fmt
                                      approver_level = lv_appr_level
                                      otype = gc_otyp_usr
                                      objid = ls_cdhdr-username
                                   ] ).
              "In cases where approval was reversed and re-done
              "There may be multiple entries
              "Ensure the latest approver Id reflects
              ASSIGN rt_appr[ pur_doc = lv_pdoc_fmt
                              pur_doc_item = lv_pitm_fmt
                              approver_level = lv_appr_level
                              otype = gc_otyp_usr
                              objid = ls_cdhdr-username
                             ] TO FIELD-SYMBOL(<lfs_appr>).
              <lfs_appr>-objid = ls_cdhdr-username.
              <lfs_appr>-approval_date = ls_cdhdr-udate.
            ELSE.
              APPEND VALUE #(
                              pur_doc = lv_pdoc_fmt
                              pur_doc_item = lv_pitm_fmt
                              approver_level = lv_appr_level
                              otype = gc_otyp_usr
                              objid = ls_cdhdr-username
                              approval_date = ls_cdhdr-udate
                            )
                     TO rt_appr.
            ENDIF.
          ENDDO.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    "Sort the output table to ensure correctness
    SORT rt_appr BY pur_doc approver_level.
*<<<End of Changes-QAOPSD-NASDM-KOPLASDJ-19th Jan 2026
  ENDMETHOD.
ENDCLASS.
