class ZCL_PM_HELPER definition
  public
  final
  create public .

public section.

  class-data GC_MSGID type SYMSGID value 'ZPM' ##NO_TEXT.
  class-data GC_MSGNO_GENERIC type SYMSGNO value '003' ##NO_TEXT.
  class-data GC_MSGNO_SERVICE_FILLED type SYMSGNO value '051' ##NO_TEXT.
  class-data GC_MSGNO_COST_SUCCESS type SYMSGNO value '052' ##NO_TEXT.
  class-data GC_MSGNO_COST_ERROR type SYMSGNO value '053' ##NO_TEXT.
  class-data GC_MSGNO_OPEN_GR_SES type SYMSGNO value '054' ##NO_TEXT.
  constants MSGNO_ORDER_LOCKED_BY_USER type SYMSGNO value '055' ##NO_TEXT.
  constants MSGNO_ORDER_NO_EDIT type SYMSGNO value '056' ##NO_TEXT.
  class-data GC_ITEM_CAT_PMO_CRO_COMPONENT type POSTP value 'E' ##NO_TEXT.
  class-data GC_PMORD_STATUS_LOCK type J_STATUS value 'I0043' ##NO_TEXT.
  class-data GC_PMORD_STATUS_TXT_CANC type CO_ASTTX value 'CANC' ##NO_TEXT.
  class-data GT_PO_PMO_COMP_FIELDLIST type TYP_T_FIELDNAME .
  class-data GT_PO_PMO_OPER_FIELDLIST type TYP_T_FIELDNAME .
  class-data GT_PO_PMO_EXT_SRV_FIELDLIST type TYP_T_FIELDNAME .

  class-methods PEEK_PM_ORDER_OP_BUFFER
    exporting
      !EV_VORNR type VORNR .
  class-methods PM_ORDER_FIND_DEFAULTS
    importing
      !IV_AUFNR type AUFNR
    exporting
      !ET_DEFAULT_OPER type BAPI_ALM_ORDER_OPERATION_ET
      !ES_HEADER type BAPI_ALM_ORDER_HEADER_E .
  class-methods FILL_EXTERNAL_SERVICE
    importing
      !IV_LOG_HDL type BALLOGHNDL
      !IV_AUFNR type AUFNR
      !IV_VORNR type VORNR
      !IT_SERVICES_PO type MMSRV_ESLL
      !IT_SERVICE_OUTLINES_OLD type BAPI_ALM_SRV_OUTLINE_T
      !IT_SERVICES_OLD type BAPI_ALM_SRV_SERVICE_LINE_T
    changing
      !CT_SERVICE_OUTLINES_UPD_FLAGS type BAPI_ALM_SRV_OUTLINE_UP_T
      !CT_SERVICE_OUTLINES type BAPI_ALM_SRV_OUTLINE_T
      !CT_SERVICES_UPD_FLAGS type BAPI_ALM_SRV_SERVICE_LINE_UP_T
      !CT_SERVICES type BAPI_ALM_SRV_SERVICE_LINE_T
      !CT_METHODS type BAPI_ALM_ORDER_METHOD_T .
  class-methods FILL_COMPONENT_001
    importing
      !IV_LOG_HDL type BALLOGHNDL
      !IV_UPD_MODE type VBKZ
      !IV_COMP_REFNUM type IFREFNUM
      !IV_COMP_NO type RSPOS
      !IV_CTRL_KEY type STEUS
      !IS_PMORD_HDR type BAPI_ALM_ORDER_HEADER_E
      !IS_EKKO type EKKO
      !IS_EKPO type UEKPO
      !IT_COMPONENT_OLD type BAPI_ALM_ORDER_COMPONENT_ET
    changing
      !CT_COMPONENT type BAPI_ALM_ORDER_COMPONENT_T
      !CT_METHOD type BAPI_ALM_ORDER_METHOD_T
      !CT_COMPONENT_UPD_FLAGS type BAPI_ALM_ORDER_COMPONENT_UT .
  class-methods DETERMINE_COMPONENT_NUMBER
    importing
      !IV_RESERV_NO type RSNUM
      !IS_EKKO type EKKO
      !IS_EKPO type UEKPO
      !IT_COMP_LIST type BAPI_ALM_ORDER_COMPONENT_ET
    changing
      !CV_COMP_NO_NEW type RSPOS
      !CV_COMP_NO_OLD type RSPOS .
  class-methods CLASS_CONSTRUCTOR .
  class-methods FILL_OPERATION_001
    importing
      !IV_LOG_HDL type BALLOGHNDL
      !IV_UPD_MODE type VBKZ
      !IV_OPER_REFNUM type IFREFNUM
      !IV_ACTVT_NO type VORNR
      !IV_CTRL_KEY type STEUS
      !IS_PMORD_HDR type BAPI_ALM_ORDER_HEADER_E
      !IS_EKKO type EKKO
      !IS_EKPO type UEKPO
      !IT_OPERATION_OLD type BAPI_ALM_ORDER_OPERATION_ET
    changing
      !CT_OPERATION type BAPI_ALM_ORDER_OPERATION_T
      !CT_METHOD type BAPI_ALM_ORDER_METHOD_T
      !CT_OPERATION_UPD_FLAGS type BAPI_ALM_ORDER_OPERATION_UT .
  class-methods HEADER_LVL_ACTIVITIES
    importing
      !IV_LOG_HDL type BALLOGHNDL
      !IV_PMORD_NO type AUFNR
    changing
      !CT_SERVICE_OUTLINES_OLD type BAPI_ALM_SRV_OUTLINE_T
      !CT_SERVICES_OLD type BAPI_ALM_SRV_SERVICE_LINE_T
      !CS_PMORD_HEADER type BAPI_ALM_ORDER_HEADER_E
      !CT_OPERATION_OLD_BAPI type BAPI_ALM_ORDER_OPERATION_ET
      !CT_OPERATION_OLD_DB type AFVC_T
      !CT_COMPONENT_OLD_BAPI type BAPI_ALM_ORDER_COMPONENT_ET
      !CT_COMPONENT_OLD_DB type RESB_T
      !CT_RETURN_BAPI_OLD type BAPIRET2_T
      !CT_HEADER type BAPI_ALM_ORDER_HEADERS_I_T
      !CT_HEADER_UP type BAPI_ALM_ORDER_HEADERS_I_UT
      !CT_METHOD type BAPI_ALM_ORDER_METHOD_T .
  class-methods LOCK_PM_ORDER
    importing
      !IV_AUFNR type AUFNR
    exporting
      !EV_SUCCESS type BOOLE_D .
  class-methods UNLOCK_PM_ORDER
    importing
      !IV_AUFNR type AUFNR
    exporting
      !EV_SUCCESS type BOOLE_D .
  class-methods FILL_OPERATION
    importing
      !IV_LOG_HDL type BALLOGHNDL
      !IV_CTRL_KEY type STEUS
      !IS_PMORD_HDR type BAPI_ALM_ORDER_HEADER_E
      !IS_EKKO type EKKO
      !IS_EKPO type UEKPO
      !IT_OPERATION_OLD_BAPI type BAPI_ALM_ORDER_OPERATION_ET
      !IT_OPERATION_OLD_DB type AFVC_T
    exporting
      !EV_ACTVT_NO type VORNR
      !EV_UPD_METHOD type SWO_METHOD
    changing
      !CT_OPERATION type BAPI_ALM_ORDER_OPERATION_T
      !CT_METHOD type BAPI_ALM_ORDER_METHOD_T
      !CT_OPERATION_UPD_FLAGS type BAPI_ALM_ORDER_OPERATION_UT
      !CT_EXTENSIONS type T_BAPIPAREX .
  class-methods FILL_COMPONENT
    importing
      !IV_LOG_HDL type BALLOGHNDL
      !IV_COMP_NO type RSPOS
      !IV_OVERRIDE_ITEM_NUM type BOOLE_D default ABAP_TRUE
      !IS_PMORD_HDR type BAPI_ALM_ORDER_HEADER_E
      !IS_EKKO type EKKO
      !IS_EKPO type UEKPO
      !IT_COMPONENT_OLD_BAPI type BAPI_ALM_ORDER_COMPONENT_ET
      !IT_COMPONENT_OLD_DB type RESB_T
    changing
      !CT_COMPONENT type BAPI_ALM_ORDER_COMPONENT_T
      !CT_METHOD type BAPI_ALM_ORDER_METHOD_T
      !CT_COMPONENT_UPD_FLAGS type BAPI_ALM_ORDER_COMPONENT_UT
      !CT_EXTENSIONS type T_BAPIPAREX .
  class-methods TRIGGER_COST_CALCULATION
    importing
      !IV_AUFNR type AUFNR
      !IV_LOG_HDL type BALLOGHNDL
    exporting
      !EV_SUCCESS type BOOLE_D .
  class-methods VALIDATE_WORK_CENTER
    importing
      !PM_ORDER type AUFNR
      !WORK_CENTER type ARBPL
      !PLANT type WERKS_D
      !DATE type DATS default SY-DATUM
    raising
      ZCX_STAT_GEN_EXCEPTION .
  class-methods GET_OPER_PM_ORDER_BUFFER
    returning
      value(OPERATIONS) type AFVGB_TAB .
  class-methods GET_COMP_PM_ORDER_BUFFER
    returning
      value(COMPONENTS) type PRJ_T_RESBB .
  class-methods CHECK_PMO_LOCK
    importing
      !AUFNR type AUFNR
    exporting
      !LOCKED type BOOLE_D
      !MESSAGE type SYMSG .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PM_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>CHECK_PMO_LOCK
* +-------------------------------------------------------------------------------------------------+
* | [--->] AUFNR                          TYPE        AUFNR
* | [<---] LOCKED                         TYPE        BOOLE_D
* | [<---] MESSAGE                        TYPE        SYMSG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CHECK_PMO_LOCK.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Check if PM Order is locked for changes                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-05 Oct 2026

    DATA: jstat TYPE tt_jstat.

    "Check if there is a DB lock
    CALL FUNCTION 'ENQUEUE_ESORDER'
      EXPORTING
        mandt          = sy-mandt
        aufnr          = aufnr
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.

    CASE sy-subrc.
      WHEN 0.
        " Order was NOT locked - we just locked it

        CALL FUNCTION 'DEQUEUE_ESORDER'
          EXPORTING
            mandt = sy-mandt
            aufnr = aufnr.
        locked = abap_false.
      WHEN 1.
        " Order is already locked by somebody else
        " e.g. open for editing in IW32
        locked = abap_true.
        message = VALUE #(
          msgty = 'E'
          msgid = 'ZPM'
          msgno = msgno_order_locked_by_user
          msgv1 = CONV symsgv( aufnr )
          msgv2 = sy-msgv1
        ).
        RETURN.
      WHEN OTHERS.
        " Enqueue system error
        locked = abap_true.
        message = VALUE #(
          msgty = 'E'
          msgid = 'ZPM'
          msgno = msgno_order_locked_by_user
          msgv1 = CONV symsgv( aufnr )
          msgv2 = sy-msgv1
        ).
        RETURN.
    ENDCASE.

    "Find the internal object number of the PM Order
    SELECT SINGLE objnr FROM aufk
                        INTO @DATA(objnr)
                        WHERE
                          aufnr = @aufnr.

    CALL FUNCTION 'STATUS_READ'
      EXPORTING
*       CLIENT      = SY-MANDT
        objnr       = objnr
        only_active = abap_true
*     IMPORTING
*       OBTYP       =
*       STSMA       =
*       STONR       =
      TABLES
        status      = jstat
*     EXCEPTIONS
*       OBJECT_NOT_FOUND       = 1
*       OTHERS      = 2
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      IF line_exists( jstat[ stat = gc_pmord_status_lock ] ).
        locked = abap_true.
        message = VALUE #(
          msgty = 'E'
          msgid = 'ZPM'
          msgno = msgno_order_no_edit
          msgv1 = CONV symsgv( aufnr )
        ).
        RETURN.
      ELSE.
        locked = abap_false.
      ENDIF.

    ENDIF.


*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-05 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>CLASS_CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD class_constructor.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Initialize required global fields                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
    "List of fields being from PO to PM Order for components
    gt_po_pmo_comp_fieldlist = VALUE #(
    ( 'ACTIVITY' )
    ( 'MATERIAL' )
    ( 'MATL_GROUP' )
    ( 'MATL_DESC' )
    ( 'ITEM_CAT' )
    ( 'PLANT' )
    ( 'STGE_LOC' )
    ( 'ORIGINAL_QUANTITY' )
    ( 'PRICE' )
    ( 'PRICE_UNIT' )
    ( 'REQUIREMENT_QUANTITY' )
    ( 'REQUIREMENT_QUANTITY_UNIT' )
    ( 'CURRENCY' )
    ( 'UNLOAD_PT' )
    ( 'AGREEMENT' )
    ( 'AGMT_ITEM' )
    ( 'PUR_GROUP' )
    ( 'PURCH_ORG' )
    ( 'VENDOR_NO' )
    ( 'MRP_RELEVANT' )
    ( 'COST_RELEVANT' )
    ).

    gt_po_pmo_oper_fieldlist = VALUE #(
      ( 'ACTIVITY' )
      ( 'WORK_CNTR ' )
      ( 'PLANT ' )
      ( 'CONTROL_KEY ' )
      ( 'DESCRIPTION ' )
      ( 'MATL_GROUP ' )
      ( 'FW_ORDER ' )
      ( 'ORDER_ITEM ' )
      ( 'QUANTITY ' )
      ( 'BASE_UOM ' )
      ( 'WORK_ACTIVITY ' )
      ( 'DURATION_NORMAL ' )
      ( 'DURATION_NORMAL_UNIT ' )
      ( 'ACTTYPE ' )
      ( 'PRICE ' )
      ( 'PRICE_UNIT ' )
      ( 'CURRENCY ' )
      ( 'PURCH_ORG ' )
      ( 'PUR_GROUP ' )
      ( 'VENDOR_NO ' )
    ).

    gt_po_pmo_ext_srv_fieldlist = VALUE #(
      ( 'ACTIVITY' )
      ( 'OUTLINE'  )
      ( 'SRV_LINE' )
      ( 'SERVICE' )
      ( 'SHORT_TEXT' )
      ( 'QUANTITY' )
      ( 'UOM' )
      ( 'GROSS_PRICE' )
      ( 'NET_PRICE' )
      ( 'USERF1_TXT' )
    ).

*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>DETERMINE_COMPONENT_NUMBER
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_RESERV_NO                   TYPE        RSNUM
* | [--->] IS_EKKO                        TYPE        EKKO
* | [--->] IS_EKPO                        TYPE        UEKPO
* | [--->] IT_COMP_LIST                   TYPE        BAPI_ALM_ORDER_COMPONENT_ET
* | [<-->] CV_COMP_NO_NEW                 TYPE        RSPOS
* | [<-->] CV_COMP_NO_OLD                 TYPE        RSPOS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD determine_component_number.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Determine the component number to be altered/added      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026

    DATA: lv_unload_pt TYPE ablad,

          lt_comp_list TYPE bapi_alm_order_component_et.

    CLEAR: cv_comp_no_old.

    lt_comp_list = it_comp_list.

    "The PO Item/Number is coded into the Unload point
    lv_unload_pt = |{ is_ekko-ebeln }_{ is_ekpo-ebelp }|.

    "If the component exists already for the same PO-Item
    "Use the same item number
    IF line_exists( it_comp_list[ unload_pt = lv_unload_pt ]
                  ).
      cv_comp_no_old = it_comp_list[ unload_pt = lv_unload_pt ]-res_item.
      EXIT.
    ENDIF.

    IF cv_comp_no_new IS INITIAL. "This is the first component we attempt to add into the PM Order in this session

      IF iv_reserv_no IS NOT INITIAL.
        "If a reservation number is present
        "Use it to find the latest item number
        SELECT SINGLE MAX( posnr )
                      FROM resb
                      INTO @DATA(lv_comp_no_new_db)
                      WHERE
                        rsnum = @iv_reserv_no.
      ENDIF.
      IF lt_comp_list[] IS NOT INITIAL.
        "Get the latest component number from the component tab ,returned by the BAPI
        SORT lt_comp_list BY item_number DESCENDING .
        DATA(lv_comp_no_new_bapi) = lt_comp_list[ 1 ]-item_number.
      ENDIF.

      "Find the latest component serial number
      "Comparing the one returned by the BAPI vs the one returned from DB
      "Hope one of them contains the latest from BUFFER
      "In case there was a corrupt-halfway-termination
      IF lv_comp_no_new_db >= lv_comp_no_new_bapi.
        cv_comp_no_new = lv_comp_no_new_db + 10.
      ELSEIF lv_comp_no_new_bapi > lv_comp_no_new_db.
        cv_comp_no_new = lv_comp_no_new_bapi + 10.
      ENDIF.
    ELSE. "We have already added some components to the PM Order
      ADD 10 TO cv_comp_no_new."Increment component number by 10
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>FILL_COMPONENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [--->] IV_COMP_NO                     TYPE        RSPOS
* | [--->] IV_OVERRIDE_ITEM_NUM           TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] IS_PMORD_HDR                   TYPE        BAPI_ALM_ORDER_HEADER_E
* | [--->] IS_EKKO                        TYPE        EKKO
* | [--->] IS_EKPO                        TYPE        UEKPO
* | [--->] IT_COMPONENT_OLD_BAPI          TYPE        BAPI_ALM_ORDER_COMPONENT_ET
* | [--->] IT_COMPONENT_OLD_DB            TYPE        RESB_T
* | [<-->] CT_COMPONENT                   TYPE        BAPI_ALM_ORDER_COMPONENT_T
* | [<-->] CT_METHOD                      TYPE        BAPI_ALM_ORDER_METHOD_T
* | [<-->] CT_COMPONENT_UPD_FLAGS         TYPE        BAPI_ALM_ORDER_COMPONENT_UT
* | [<-->] CT_EXTENSIONS                  TYPE        T_BAPIPAREX
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD fill_component.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Add component to BAPI Export tables                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
    DATA: lv_method             TYPE swo_method,
          lv_comp_no            TYPE rspos,
          lv_item_no            TYPE aposn,
          lv_unload_pt          TYPE ablad,

          ls_component          TYPE bapi_alm_order_component,
          ls_upd_flags          TYPE bapi_alm_order_component_up,
          ls_method             TYPE bapi_alm_order_method,
          cro_po_link           TYPE zpm_cro_po_link,

          lt_component_old_bapi TYPE bapi_alm_order_component_et,
          lt_component_old_db   TYPE resb_t,
          lt_component_buf      TYPE bapi_alm_order_component_t.

    lt_component_old_bapi = it_component_old_bapi.
    lt_component_old_db = it_component_old_db.
    lt_component_buf = ct_component.

    "The PO Item/Number is coded into the Unload point
    lv_unload_pt = |{ is_ekko-ebeln }_{ is_ekpo-ebelp }|.

    "Find if any existing, valid component is linked to the PO item we are trying to add
*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026
    zcl_mm_po_to_pmo=>find_existing_pmo_item(
    EXPORTING
      orderid = is_pmord_hdr-orderid
      ebeln   = is_ekko-ebeln
      ebelp   = is_ekpo-ebelp
      existing_components = it_component_old_bapi
    IMPORTING
      linked_component = DATA(ls_existing_component)
    ).
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026


    "IF line_exists( it_component_old_bapi[ unload_pt = lv_unload_pt delete_ind = abap_false ] )."Component is already part of the order
    IF ls_existing_component IS NOT INITIAL."Component is already part of the order
      "DATA(ls_component_old) = it_component_old_bapi[ unload_pt = lv_unload_pt delete_ind = abap_false ].
      DATA(ls_component_old) = ls_existing_component.
      IF is_ekpo-loekz = 'L'.
        lv_method = 'DELETE'.
      ELSE.
        lv_method = 'CHANGE'.
      ENDIF.
      lv_comp_no = ls_component_old-res_item.
      MOVE-CORRESPONDING ls_component_old TO ls_component.

      "ls_component-reserv_no = is_pmord_hdr-reserv_no.
      "ls_component-res_item = lv_comp_no.

    ELSE. "Component not already in the PM Order
      IF is_ekpo-loekz NE 'L'. "It is not marked for deletion in PO
        lv_method = 'CREATE'.

        IF iv_override_item_num = abap_true.
          IF lt_component_buf[] IS INITIAL AND
             lt_component_old_bapi[] IS INITIAL."If there is nothing in DB and nothing pending Creation
            lv_item_no = 10.
          ELSE.
            "Find the latest operation number present
            SORT lt_component_old_bapi BY item_number DESCENDING.
            SORT lt_component_old_db BY posnr DESCENDING.
            SORT lt_component_buf BY item_number DESCENDING.
            IF lt_component_buf[] IS NOT INITIAL."Based on the entries we attempt to change/add
              DATA(ls_latest_component_buf) = lt_component_buf[ 1 ].
            ENDIF.
            IF lt_component_old_bapi[] IS NOT INITIAL."Based on the entries already in DB
              DATA(ls_latest_component_bapi) = lt_component_old_bapi[ 1 ].
            ENDIF.
            IF lt_component_old_db[] IS NOT INITIAL."Based on the entries already in DB
              DATA(ls_latest_component_db) = lt_component_old_db[ 1 ].
            ENDIF.

            IF ls_latest_component_buf-item_number GE ls_latest_component_bapi-item_number AND
               ls_latest_component_buf-item_number GE ls_latest_component_db-posnr.
              lv_item_no = ls_latest_component_buf-item_number + 10.
            ELSEIF ls_latest_component_bapi-activity GE ls_latest_component_buf-item_number AND
                   ls_latest_component_bapi-activity GE ls_latest_component_db-posnr.
              lv_item_no = ls_latest_component_bapi-item_number + 10.
            ELSEIF ls_latest_component_db-posnr GE ls_latest_component_buf-item_number AND
                   ls_latest_component_db-posnr GE ls_latest_component_bapi-item_number.
              lv_item_no = ls_latest_component_db-posnr + 10.
            ENDIF.
          ENDIF.

          "Populate the activity number
          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
            EXPORTING
              input  = lv_item_no
            IMPORTING
              output = ls_component-item_number.
        ENDIF.
      ELSE.
        "Line is marked for deletion and already does not exist in the PM Order
        "Nothing to do here
        RETURN.
      ENDIF.
    ENDIF.

    ls_component-activity = is_ekpo-opref_vornr.

    ls_component-material = is_ekpo-matnr.
    ls_component-matl_group = is_ekpo-matkl.
    ls_component-matl_desc = is_ekpo-txz01.
    ls_component-item_cat = gc_item_cat_pmo_cro_component.
    ls_component-plant = is_ekpo-werks.
    ls_component-stge_loc = is_ekpo-lgort.
    ls_component-original_quantity = is_ekpo-menge.
    ls_component-price = is_ekpo-netpr.
    ls_component-price_unit = is_ekpo-peinh.
    ls_component-requirement_quantity = is_ekpo-menge.
    ls_component-requirement_quantity_unit = is_ekpo-meins.
    ls_component-currency = is_ekko-waers.
*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026
    "We do this using custom table going forward
*****    "Store a reference to the PO & Item, for easier lookup later
*****    ls_component-unload_pt = lv_unload_pt.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026

    ls_component-agreement = is_ekpo-konnr.
    ls_component-agmt_item = is_ekpo-ktpnr.

    ls_component-pur_group = is_ekko-ekgrp.
    ls_component-purch_org = is_ekko-ekorg.
    ls_component-vendor_no = is_ekko-lifnr.

    ls_component-mrp_relevant = '1'. "Never

*      	Not Relevant to Costing
*    1  50% Relevant to Costing
*    2  25% Relevant to Costing
*    3  75% Relevant to Costing
*    X  100% Relevant to Costing
    ls_component-cost_relevant = abap_true. "Fully Relevant

    APPEND ls_component TO ct_component.


    IF lv_method = 'CHANGE' OR
       lv_method = 'DELETE'.
      "Fill in update flags based on the fields that have changed
      zcl_abap_helper=>check_set_bapi_upd_flags(
      EXPORTING
        it_check_field_list = gt_po_pmo_comp_fieldlist
        is_old_data = ls_component_old
        is_new_data = ls_component
      CHANGING
        cs_upd_flags = ls_upd_flags
      ).
      APPEND ls_upd_flags TO ct_component_upd_flags.

      ls_method-objectkey = |{ is_pmord_hdr-orderid }{ lv_comp_no }|.
    ELSEIF lv_method = 'CREATE'.
      ls_method-objectkey = is_pmord_hdr-orderid.
    ENDIF.

    ls_method-objecttype = 'COMPONENT'.
    ls_method-method = lv_method.
    ls_method-refnumber = lines( ct_component ).

    APPEND ls_method TO ct_method.

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-18 May 2026
    "Fill in the extension structure to map the operation to PO item
    cro_po_link = VALUE #(
      orderid = is_pmord_hdr-orderid
      activity = ls_component-activity
      item_number = ls_component-item_number
*****      reserv_no = is_pmord_hdr-reserv_no
*****      RES_ITEM
      ebeln = is_ekko-ebeln
      ebelp = is_ekpo-ebelp
    ).
    ct_extensions = VALUE #( BASE ct_extensions
      (
        structure = 'ZPM_CRO_PO_LINK'
        valuepart1 = cro_po_link
      )
    ).
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-18 May 2026

    zcl_xx_msg_logger=>add_msg_to_log(
    EXPORTING
    iv_log_hdl = iv_log_hdl
    iv_msgty = 'I'
    iv_msgid = 'ZMM'
    iv_msgno = '033'
    iv_msgv1 = CONV symsgv( |{ lv_comp_no }| )
    iv_msgv2 = CONV symsgv( |{ is_pmord_hdr-orderid }| )
    iv_msgv3 = CONV symsgv( |{ ls_method-method }| )
    iv_msgv4 = space ).
    IF 1 = 2.
      MESSAGE ID 'ZMM' TYPE 'I' NUMBER '033'.
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>FILL_COMPONENT_001
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [--->] IV_UPD_MODE                    TYPE        VBKZ
* | [--->] IV_COMP_REFNUM                 TYPE        IFREFNUM
* | [--->] IV_COMP_NO                     TYPE        RSPOS
* | [--->] IV_CTRL_KEY                    TYPE        STEUS
* | [--->] IS_PMORD_HDR                   TYPE        BAPI_ALM_ORDER_HEADER_E
* | [--->] IS_EKKO                        TYPE        EKKO
* | [--->] IS_EKPO                        TYPE        UEKPO
* | [--->] IT_COMPONENT_OLD               TYPE        BAPI_ALM_ORDER_COMPONENT_ET
* | [<-->] CT_COMPONENT                   TYPE        BAPI_ALM_ORDER_COMPONENT_T
* | [<-->] CT_METHOD                      TYPE        BAPI_ALM_ORDER_METHOD_T
* | [<-->] CT_COMPONENT_UPD_FLAGS         TYPE        BAPI_ALM_ORDER_COMPONENT_UT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD FILL_COMPONENT_001.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Add component to BAPI Export tables                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
    DATA: ls_component TYPE bapi_alm_order_component,
          ls_method    TYPE bapi_alm_order_method,

          ls_upd_flags TYPE bapi_alm_order_component_up.

    IF iv_upd_mode = 'U'.
      ls_method-method = 'CHANGE'.
      ls_method-objectkey = |{ is_pmord_hdr-orderid }{ iv_comp_no }|."'%00000000001'.
    ELSEIF  iv_upd_mode = 'I'.
      ls_method-method = 'CREATE'.
      ls_method-objectkey = is_pmord_hdr-orderid."COMMENTING-LMASDI-AGHSDFO-HDSFUI-31st Mar 2026
*****    ls_method-objectkey = iv_comp_no_placeholder."INSERTING-LMASDI-AGHSDFO-HDSFUI-31st Mar 2026
    ELSEIF iv_upd_mode = 'D'.
      ls_method-method = 'DELETE'.
      ls_method-objectkey = |{ is_pmord_hdr-orderid }{ iv_comp_no }|."'%00000000001'.
    ENDIF.

    ls_method-refnumber = iv_comp_refnum.
    ls_method-objecttype = 'COMPONENT'.

    APPEND ls_method TO ct_method.

    IF iv_upd_mode = 'U' OR
       iv_upd_mode = 'D'.
      "Mention the the Reservation item identifiers in case of CHANGE
      ls_component-reserv_no = is_pmord_hdr-reserv_no.
      ls_component-res_item  = iv_comp_no.

      "Read the existing component detail from DB to determine what has changed
      DATA(ls_component_old) = it_component_old[ reserv_no = is_pmord_hdr-reserv_no res_item = iv_comp_no ].
    ENDIF.
    "Determine the correct operation number
    "It should be the default operation added when the PM Order was first created
    ls_component-activity = is_ekpo-opref_vornr.

    ls_component-material = is_ekpo-matnr.
    ls_component-matl_group = is_ekpo-matkl.
    ls_component-matl_desc = is_ekpo-txz01.
    ls_component-item_cat = gc_item_cat_pmo_cro_component."<TBD>Determine the correct Item Category
    ls_component-plant = is_ekpo-werks.
    ls_component-stge_loc = is_ekpo-lgort.
    ls_component-original_quantity = is_ekpo-menge.
    ls_component-price = is_ekpo-netpr.
    ls_component-price_unit = is_ekpo-peinh.
    ls_component-requirement_quantity = is_ekpo-menge.
    ls_component-requirement_quantity_unit = is_ekpo-meins.
    ls_component-currency = is_ekko-waers.
*****  ls_component-agreement = is_ekko-ebeln.
*****  ls_component-agmt_item = is_ekpo-ebelp.

    "Store a referenec to the PO & Item, for easier lookup later
    ls_component-unload_pt = |{ is_ekko-ebeln }_{ is_ekpo-ebelp }|.

    ls_component-agreement = is_ekpo-konnr.
    ls_component-agmt_item = is_ekpo-ktpnr.

    ls_component-pur_group = is_ekko-ekgrp.
    ls_component-purch_org = is_ekko-ekorg.
    ls_component-vendor_no = is_ekko-lifnr.

    ls_component-mrp_relevant = '1'. "Never
    ls_component-cost_relevant = abap_true. "Fully Relevant
*      	Not Relevant to Costing
*    1  50% Relevant to Costing
*    2  25% Relevant to Costing
*    3  75% Relevant to Costing
*    X  100% Relevant to Costing

    APPEND ls_component TO ct_component.

    IF iv_upd_mode = 'U'.
      "Fill in update flags based on the fields that have changed
      zcl_abap_helper=>check_set_bapi_upd_flags(
      EXPORTING
        it_check_field_list = gt_po_pmo_comp_fieldlist
        is_old_data = ls_component_old
        is_new_data = ls_component
      CHANGING
        cs_upd_flags = ls_upd_flags
      ).
      APPEND ls_upd_flags TO ct_component_upd_flags.
    ENDIF.

    zcl_xx_msg_logger=>add_msg_to_log(
    EXPORTING
    iv_log_hdl = iv_log_hdl
    iv_msgty = 'I'
    iv_msgid = 'ZMM'
    iv_msgno = '033'
    iv_msgv1 = CONV symsgv( |{ iv_comp_no }| )
    iv_msgv2 = CONV symsgv( |{ is_pmord_hdr-orderid }| )
    iv_msgv3 = CONV symsgv( |{ ls_method-method }| )
    iv_msgv4 = space ).
    IF 1 = 2.
      MESSAGE ID 'ZMM' TYPE 'I' NUMBER '033'.
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>FILL_EXTERNAL_SERVICE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [--->] IV_AUFNR                       TYPE        AUFNR
* | [--->] IV_VORNR                       TYPE        VORNR
* | [--->] IT_SERVICES_PO                 TYPE        MMSRV_ESLL
* | [--->] IT_SERVICE_OUTLINES_OLD        TYPE        BAPI_ALM_SRV_OUTLINE_T
* | [--->] IT_SERVICES_OLD                TYPE        BAPI_ALM_SRV_SERVICE_LINE_T
* | [<-->] CT_SERVICE_OUTLINES_UPD_FLAGS  TYPE        BAPI_ALM_SRV_OUTLINE_UP_T
* | [<-->] CT_SERVICE_OUTLINES            TYPE        BAPI_ALM_SRV_OUTLINE_T
* | [<-->] CT_SERVICES_UPD_FLAGS          TYPE        BAPI_ALM_SRV_SERVICE_LINE_UP_T
* | [<-->] CT_SERVICES                    TYPE        BAPI_ALM_SRV_SERVICE_LINE_T
* | [<-->] CT_METHODS                     TYPE        BAPI_ALM_ORDER_METHOD_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD fill_external_service.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Prepare BAPI parameters to add external services        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-22 Apr 2026
    DATA: lv_line_num          TYPE extrow,
          lv_vornr             TYPE vornr,
          lv_outline           TYPE outline_no,
          lv_packno            TYPE packno,
          lv_introw            TYPE numzeile,
          lv_srv_line_short(4) TYPE n,
          lv_objkey            TYPE objidext,

          lv_ref_text          TYPE userf1_txt,
          lv_method            TYPE swo_method,

          ls_service           TYPE bapi_alm_srv_service_line,
          ls_service_old       TYPE bapi_alm_srv_service_line,
          ls_upd_flags         TYPE bapi_alm_srv_service_line_up.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = iv_vornr
      IMPORTING
        output = lv_vornr.

    "Check if an outline already exist for the operation
    IF line_exists( it_service_outlines_old[ activity = lv_vornr ] )."If an outline already exists, use it
      DATA(ls_service_outline_old) = it_service_outlines_old[ activity = lv_vornr ].
      APPEND ls_service_outline_old TO ct_service_outlines.
      lv_outline = ls_service_outline_old-outline.
    ELSE.
      ct_service_outlines = VALUE #( BASE ct_service_outlines
        (
          activity = lv_vornr
          outline  = 1
          short_text = |Services_{ iv_aufnr }_{ sy-datum }{ sy-uzeit }|
          from_line  = 1
        )
      ).
      lv_outline = 1.
    ENDIF.

    "Find the latest service line number which is already in the PM Order
    IF line_exists( it_services_old[ activity = lv_vornr ] ).
      DATA(lt_services_old) = VALUE bapi_alm_srv_service_line_t(
      FOR ls_services_old_001 IN it_services_old WHERE ( activity = lv_vornr )
      (
        ls_services_old_001
      )
      ).
      SORT lt_services_old BY srv_line DESCENDING.
      lv_line_num = lt_services_old[ 1 ]-srv_line.
    ELSE.
      lv_line_num = 'LMASDI'.
    ENDIF.

    LOOP AT it_services_po INTO DATA(ls_service_po).
      "Check if the service already exists in the PM Order
      lv_ref_text = |{ ls_service_po-packno }_{ ls_service_po-introw }|.

      IF line_exists( lt_services_old[ userf1_txt = lv_ref_text ] )."If service is already present
        lv_method = 'CHANGE'.

        "Use the data from the existing service
        ls_service_old = lt_services_old[ userf1_txt = lv_ref_text ].
        CLEAR: ls_service.
        MOVE-CORRESPONDING ls_service_old TO ls_service.

        "Set the latest values from the PO
        ls_service-service  = ls_service_po-srvpos.
        ls_service-short_text = ls_service_po-ktext1.
        ls_service-quantity = ls_service_po-menge.
        ls_service-uom = ls_service_po-meins.
        ls_service-gross_price = ls_service_po-tbtwr.
        ls_service-net_price = ls_service_po-netwr.

        "Fill in update flags based on the fields that have changed
        zcl_abap_helper=>check_set_bapi_upd_flags(
        EXPORTING
          it_check_field_list = gt_po_pmo_ext_srv_fieldlist
          is_old_data = ls_service_old
          is_new_data = ls_service
        CHANGING
          cs_upd_flags = ls_upd_flags
        ).

        "lv_srv_line_short = ls_service-srv_line.
        "lv_objkey = |{ iv_aufnr }{ lv_vornr }{ ls_service-srv_line }|.
        lv_objkey = |{ iv_aufnr }{ lv_vornr }|.
        APPEND ls_service TO ct_services.

        ls_upd_flags-activity = ls_service-activity.
        ls_upd_flags-outline = ls_service-outline.
        ls_upd_flags-srv_line = ls_service-srv_line.
        APPEND ls_upd_flags TO ct_services_upd_flags.
      ELSE.
        lv_method = 'CREATE'.

        lv_line_num = lv_line_num + 10.

        ct_services = VALUE #( BASE ct_services
          (
            activity      = lv_vornr
            outline       = lv_outline
            srv_line      = lv_line_num
            service       = ls_service_po-srvpos
            short_text    = ls_service_po-ktext1
            quantity      = ls_service_po-menge
            uom           = ls_service_po-meins
            gross_price   = ls_service_po-tbtwr
            net_price     = ls_service_po-netwr
            "external_item_id = |{ ls_service_po-packno }_{ ls_service_po-introw }|
            userf1_txt    = lv_ref_text
          )
        ).

        lv_objkey = |{ iv_aufnr }{ lv_vornr }|.
      ENDIF.

      ct_methods = VALUE #( BASE ct_methods
        (
          refnumber = lines( ct_services )
          objecttype = 'SERVICELINE'
          method = lv_method
          objectkey = lv_objkey
        )
      ).

      zcl_xx_msg_logger=>add_msg_to_log(
      EXPORTING
      iv_log_hdl = iv_log_hdl
      iv_msgty = 'I'
      iv_msgid = gc_msgid
      iv_msgno = gc_msgno_service_filled
      iv_msgv1 = CONV symsgv( |{ ls_service_po-srvpos }| )
      iv_msgv2 = CONV symsgv( |{ iv_aufnr }| )
      iv_msgv3 = CONV symsgv( |{ lv_vornr }| )
      iv_msgv4 = space ).
      IF 1 = 2.
        MESSAGE i025(zpm).
      ENDIF.
    ENDLOOP.

    "If a Service is present in old service list but not in the latest list from PO
    "It should be deleted
    LOOP AT lt_services_old INTO ls_service_old.
      SPLIT ls_service_old-userf1_txt AT '_' INTO lv_packno lv_introw.
      IF sy-subrc = 0.
        IF NOT line_exists( it_services_po[ packno = lv_packno introw = lv_introw ] ).
          CLEAR: ls_upd_flags.
          APPEND ls_service_old TO ct_services.
          lv_srv_line_short = ls_service_old-srv_line.
          ct_methods = VALUE #( BASE ct_methods
            (
              refnumber = lines( ct_services )
              objecttype = 'SERVICELINE'
              method = 'DELETE'
              "objectkey = |{ iv_aufnr }{ lv_vornr }{ ls_service_old-srv_line }|
              objectkey = |{ iv_aufnr }{ lv_vornr }|
            )
          ).

          ls_upd_flags-activity = ls_service_old-activity.
          ls_upd_flags-outline = ls_service_old-outline.
          ls_upd_flags-srv_line = ls_service_old-srv_line.
          APPEND ls_upd_flags TO ct_services_upd_flags.
        ENDIF.
      ENDIF.
    ENDLOOP.

*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-22 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>FILL_OPERATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [--->] IV_CTRL_KEY                    TYPE        STEUS
* | [--->] IS_PMORD_HDR                   TYPE        BAPI_ALM_ORDER_HEADER_E
* | [--->] IS_EKKO                        TYPE        EKKO
* | [--->] IS_EKPO                        TYPE        UEKPO
* | [--->] IT_OPERATION_OLD_BAPI          TYPE        BAPI_ALM_ORDER_OPERATION_ET
* | [--->] IT_OPERATION_OLD_DB            TYPE        AFVC_T
* | [<---] EV_ACTVT_NO                    TYPE        VORNR
* | [<---] EV_UPD_METHOD                  TYPE        SWO_METHOD
* | [<-->] CT_OPERATION                   TYPE        BAPI_ALM_ORDER_OPERATION_T
* | [<-->] CT_METHOD                      TYPE        BAPI_ALM_ORDER_METHOD_T
* | [<-->] CT_OPERATION_UPD_FLAGS         TYPE        BAPI_ALM_ORDER_OPERATION_UT
* | [<-->] CT_EXTENSIONS                  TYPE        T_BAPIPAREX
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD fill_operation.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Add an Operation to BAPI Internal table                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
    "~~~~~~~~~~
    DATA: lv_method             TYPE swo_method,
          lv_actvt_no	          TYPE vornr,

          ls_operation          TYPE bapi_alm_order_operation,
          ls_upd_flags          TYPE bapi_alm_order_operation_up,
          ls_method             TYPE bapi_alm_order_method,
          cro_po_link           TYPE zpm_cro_po_link,

          lt_operation_old_bapi TYPE bapi_alm_order_operation_et,
          lt_operation_old_db   TYPE afvc_t,
          lt_operation_buf      TYPE bapi_alm_order_operation_t.

    lt_operation_old_bapi = it_operation_old_bapi.
    lt_operation_old_db = it_operation_old_db.
    lt_operation_buf = ct_operation.

    IF line_exists( it_operation_old_bapi[ fw_order = is_ekko-ebeln order_item = is_ekpo-ebelp ] )."Operation is already part of the order
      DATA(ls_operation_old) = it_operation_old_bapi[ fw_order = is_ekko-ebeln order_item = is_ekpo-ebelp ].
      IF is_ekpo-loekz = 'L'.
        lv_method = 'DELETE'.
      ELSE.
        lv_method = 'CHANGE'.
      ENDIF.
      lv_actvt_no = ls_operation_old-activity.
      MOVE-CORRESPONDING ls_operation_old TO ls_operation.
    ELSE. "Operation not already in the PM Order
      IF is_ekpo-loekz NE 'L'. "It is not marked for deletion in PO
        lv_method = 'CREATE'.
        IF lt_operation_buf[] IS INITIAL AND
           lt_operation_old_bapi[] IS INITIAL AND"If there is nothing in DB and nothing pending Creation
           lt_operation_old_db[] IS INITIAL.
          lv_actvt_no = 10.
        ELSE.
          "Find the latest operation number present
          SORT lt_operation_old_bapi BY activity DESCENDING.
          SORT lt_operation_old_db BY vornr DESCENDING.
          SORT lt_operation_buf BY activity DESCENDING.
          IF lt_operation_buf[] IS NOT INITIAL."Based on the entries we attempt to change/add
            DATA(ls_latest_operation_buf) = lt_operation_buf[ 1 ].
          ENDIF.
          IF lt_operation_old_bapi[] IS NOT INITIAL."Based on the entries already in DB returned by BAPI
            DATA(ls_latest_operation_bapi) = lt_operation_old_bapi[ 1 ].
          ENDIF.
          IF lt_operation_old_db[] IS NOT INITIAL."Based on the entries already in DB
            DATA(ls_latest_operation_db) = lt_operation_old_db[ 1 ].
          ENDIF.

          IF ls_latest_operation_buf-activity GE ls_latest_operation_db-vornr AND
             ls_latest_operation_buf-activity GE ls_latest_operation_bapi-activity.
            lv_actvt_no = ls_latest_operation_buf-activity + 10.
          ELSEIF ls_latest_operation_db-vornr GE ls_latest_operation_buf-activity AND
                 ls_latest_operation_db-vornr GE ls_latest_operation_bapi-activity.
            lv_actvt_no = ls_latest_operation_db-vornr + 10.
          ELSEIF ls_latest_operation_bapi-activity GE ls_latest_operation_buf-activity AND
                 ls_latest_operation_bapi-activity GE ls_latest_operation_db-vornr.
            lv_actvt_no = ls_latest_operation_bapi-activity + 10.
          ENDIF.
        ENDIF.
      ELSE.
        "Line is marked for deletion and already does not exist in the PM Order
        "Nothing to do here
        RETURN.
      ENDIF.
    ENDIF.

    "Populate the activity number
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = lv_actvt_no
      IMPORTING
        output = ls_operation-activity.

    "Populate data from PO Item
    "Any existing data (in case of existing PMO Item) will be overwritten
    ls_operation-work_cntr = is_ekpo-arbpl.
    ls_operation-plant = is_ekpo-werks.
    ls_operation-control_key = iv_ctrl_key.
    ls_operation-description = is_ekpo-txz01.
    ls_operation-matl_group = is_ekpo-matkl.
    ls_operation-fw_order = is_ekko-ebeln.
    ls_operation-order_item = is_ekpo-ebelp.
    ls_operation-acttype = is_ekpo-op_acttype.
    ls_operation-purch_org = is_ekko-ekorg.
    ls_operation-pur_group = is_ekko-ekgrp.
    ls_operation-vendor_no = is_ekko-lifnr.
    ls_operation-mrp_relevant = '1'. "Never

    APPEND ls_operation TO ct_operation.

    ev_actvt_no = ls_operation-activity.

    IF lv_method = 'CHANGE' OR
       lv_method = 'DELETE'.
      "Fill in update flags based on the fields that have changed
      zcl_abap_helper=>check_set_bapi_upd_flags(
      EXPORTING
        it_check_field_list = gt_po_pmo_oper_fieldlist
        is_old_data = ls_operation_old
        is_new_data = ls_operation
      CHANGING
        cs_upd_flags = ls_upd_flags
      ).
      APPEND ls_upd_flags TO ct_operation_upd_flags.

      ls_method-objectkey = |{ is_pmord_hdr-orderid }{ ls_operation-activity }|.
    ELSEIF lv_method = 'CREATE'.
      ls_method-objectkey = is_pmord_hdr-orderid.
    ENDIF.

    ls_method-objecttype = 'OPERATION'.
    ls_method-method = lv_method.
    ls_method-refnumber = lines( ct_operation ).

    APPEND ls_method TO ct_method.

    ev_upd_method = lv_method.

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-18 May 2026
    "Fill in the extension structure to map the operation to PO item
    cro_po_link = VALUE #(
      orderid = is_pmord_hdr-orderid
      activity = ls_operation-activity
*      ITEM_NUMBER
*      RESERV_NO
*      RES_ITEM
      ebeln = ls_operation-fw_order
      ebelp = ls_operation-order_item
    ).
    ct_extensions = VALUE #( BASE ct_extensions
      (
        structure = 'ZPM_CRO_PO_LINK'
        valuepart1 = cro_po_link
      )
    ).
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-18 May 2026

    zcl_xx_msg_logger=>add_msg_to_log(
    EXPORTING
    iv_log_hdl = iv_log_hdl
    iv_msgty = 'I'
    iv_msgid = 'ZMM'
    iv_msgno = '025'
    iv_msgv1 = CONV symsgv( |{ ls_operation-activity }| )
    iv_msgv2 = CONV symsgv( |{ is_pmord_hdr-orderid }| )
    iv_msgv3 = CONV symsgv( |{ ls_method-method }| )
    iv_msgv4 = space ).
    IF 1 = 2.
      MESSAGE ID 'ZMM' TYPE 'I' NUMBER '025'.
    ENDIF.

*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>FILL_OPERATION_001
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [--->] IV_UPD_MODE                    TYPE        VBKZ
* | [--->] IV_OPER_REFNUM                 TYPE        IFREFNUM
* | [--->] IV_ACTVT_NO                    TYPE        VORNR
* | [--->] IV_CTRL_KEY                    TYPE        STEUS
* | [--->] IS_PMORD_HDR                   TYPE        BAPI_ALM_ORDER_HEADER_E
* | [--->] IS_EKKO                        TYPE        EKKO
* | [--->] IS_EKPO                        TYPE        UEKPO
* | [--->] IT_OPERATION_OLD               TYPE        BAPI_ALM_ORDER_OPERATION_ET
* | [<-->] CT_OPERATION                   TYPE        BAPI_ALM_ORDER_OPERATION_T
* | [<-->] CT_METHOD                      TYPE        BAPI_ALM_ORDER_METHOD_T
* | [<-->] CT_OPERATION_UPD_FLAGS         TYPE        BAPI_ALM_ORDER_OPERATION_UT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD FILL_OPERATION_001.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Add an Operation to BAPI Internal table                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
    DATA: ls_operation TYPE bapi_alm_order_operation,
          ls_method    TYPE bapi_alm_order_method,

          ls_upd_flags TYPE bapi_alm_order_operation_up.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = iv_actvt_no
      IMPORTING
        output = ls_operation-activity.

*****  ls_operation-activity = iv_actvt_no.
    ls_operation-work_cntr = is_ekpo-arbpl.
    ls_operation-plant = is_ekpo-werks.
    ls_operation-control_key = iv_ctrl_key.
    ls_operation-description = is_ekpo-txz01.
    ls_operation-matl_group = is_ekpo-matkl.

    ls_operation-fw_order = is_ekko-ebeln.
    ls_operation-order_item = is_ekpo-ebelp.
    """""ls_operation-quantity = is_ekpo-menge.
    """""ls_operation-base_uom = is_ekpo-meins.
    "ls_operation-work_activity = 1."<TBD>Retrieve from correct source field

    "ls_operation-duration_normal = 1."<TBD>Retrieve from correct source field
    "ls_operation-duration_normal_unit = 'H'."<TBD>Retrieve from correct source field
    ls_operation-acttype = is_ekpo-op_acttype."Retrieve from EKPO Custom Field

    """""ls_operation-price = is_ekpo-netpr.
    """""ls_operation-price_unit = is_ekpo-peinh.
    """""ls_operation-currency = is_ekko-waers.
    "ls_operation-

    ls_operation-purch_org = is_ekko-ekorg.
    ls_operation-pur_group = is_ekko-ekgrp.
    ls_operation-vendor_no = is_ekko-lifnr.

    ls_operation-mrp_relevant = '1'. "Never

    IF iv_upd_mode = 'U'.
      ls_method-method = 'CHANGE'.
      ls_method-objectkey = |{ is_pmord_hdr-orderid }{ ls_operation-activity }|.
    ELSEIF  iv_upd_mode = 'I'.
      ls_method-method = 'CREATE'.
      ls_method-objectkey = is_pmord_hdr-orderid."COMMENTING-LMASDI-AGHSDFO-HDSFUI-31st Mar 2026
*****    ls_method-objectkey = iv_actvt_no_placeholder."INSERTING-LMASDI-AGHSDFO-HDSFUI-31st Mar 2026
    ELSEIF iv_upd_mode = 'D'.
      ls_method-method = 'DELETE'.
      ls_method-objectkey = |{ is_pmord_hdr-orderid }{ ls_operation-activity }|."'%00000000001'.
    ENDIF.

    ls_method-refnumber = iv_oper_refnum.
    ls_method-objecttype = 'OPERATION'.

    APPEND ls_method TO ct_method.
    APPEND ls_operation TO ct_operation.

    IF iv_upd_mode = 'U' OR
       iv_upd_mode = 'D'.
      "Retrieve the existing fields values in the DB
      DATA(ls_operation_old) = it_operation_old[ activity = ls_operation-activity ].
      "Determine which fields have changed and set the update flag accordingly
      zcl_abap_helper=>check_set_bapi_upd_flags(
      EXPORTING
        it_check_field_list = gt_po_pmo_oper_fieldlist
        is_old_data = ls_operation_old
        is_new_data = ls_operation
      CHANGING
        cs_upd_flags = ls_upd_flags
      ).
      APPEND ls_upd_flags TO ct_operation_upd_flags.
    ENDIF.

    zcl_xx_msg_logger=>add_msg_to_log(
    EXPORTING
    iv_log_hdl = iv_log_hdl
    iv_msgty = 'I'
    iv_msgid = 'ZMM'
    iv_msgno = '025'
    iv_msgv1 = CONV symsgv( |{ ls_operation-activity }| )
    iv_msgv2 = CONV symsgv( |{ is_pmord_hdr-orderid }| )
    iv_msgv3 = CONV symsgv( |{ ls_method-method }| )
    iv_msgv4 = space ).
    IF 1 = 2.
      MESSAGE ID 'ZMM' TYPE 'I' NUMBER '025'.
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>GET_COMP_PM_ORDER_BUFFER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] COMPONENTS                     TYPE        PRJ_T_RESBB
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_comp_pm_order_buffer.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Get Operations from Order Buffer                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026
    DATA: component TYPE resbb.

    FIELD-SYMBOLS: <t_resb_bt> TYPE ANY TABLE.



    DATA(buffer_name) = |(SAPLCOBC)RESB_BT[]|.

    ASSIGN (buffer_name) TO <t_resb_bt>.

    LOOP AT <t_resb_bt> ASSIGNING FIELD-SYMBOL(<s_resb_bt>).
      MOVE-CORRESPONDING <s_resb_bt> TO component.
      APPEND component TO components.
    ENDLOOP.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>GET_OPER_PM_ORDER_BUFFER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] OPERATIONS                     TYPE        AFVGB_TAB
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_oper_pm_order_buffer.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Get Operations from Order Buffer                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026
    DATA: operation TYPE afvgb.

    FIELD-SYMBOLS: <t_afvg_bt> TYPE ANY TABLE.



    DATA(buffer_name) = |(SAPLCOBO)AFVG_BT[]|.

    ASSIGN (buffer_name) TO <t_afvg_bt>.

    LOOP AT <t_afvg_bt> ASSIGNING FIELD-SYMBOL(<s_afvg_bt>).
      MOVE-CORRESPONDING <s_afvg_bt> TO operation.
      APPEND operation TO operations.
    ENDLOOP.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-19 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>HEADER_LVL_ACTIVITIES
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [--->] IV_PMORD_NO                    TYPE        AUFNR
* | [<-->] CT_SERVICE_OUTLINES_OLD        TYPE        BAPI_ALM_SRV_OUTLINE_T
* | [<-->] CT_SERVICES_OLD                TYPE        BAPI_ALM_SRV_SERVICE_LINE_T
* | [<-->] CS_PMORD_HEADER                TYPE        BAPI_ALM_ORDER_HEADER_E
* | [<-->] CT_OPERATION_OLD_BAPI          TYPE        BAPI_ALM_ORDER_OPERATION_ET
* | [<-->] CT_OPERATION_OLD_DB            TYPE        AFVC_T
* | [<-->] CT_COMPONENT_OLD_BAPI          TYPE        BAPI_ALM_ORDER_COMPONENT_ET
* | [<-->] CT_COMPONENT_OLD_DB            TYPE        RESB_T
* | [<-->] CT_RETURN_BAPI_OLD             TYPE        BAPIRET2_T
* | [<-->] CT_HEADER                      TYPE        BAPI_ALM_ORDER_HEADERS_I_T
* | [<-->] CT_HEADER_UP                   TYPE        BAPI_ALM_ORDER_HEADERS_I_UT
* | [<-->] CT_METHOD                      TYPE        BAPI_ALM_ORDER_METHOD_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD header_lvl_activities.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      17th Jul 2025                                             *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Fill details related to PM Order header                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*
*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
    "Call FM BAPI_ALM_ORDER_GET_DETAIL to get the order header details
    "Get the details of the existing PM Order
    CALL FUNCTION 'BAPI_ALM_ORDER_GET_DETAIL'
      EXPORTING
        number            = iv_pmord_no
      IMPORTING
        es_header         = cs_pmord_header
*       ES_SRVDATA        =
*       ES_REFORDER_ITEM  =
      TABLES
*       ET_PARTNER        =
        et_operations     = ct_operation_old_bapi
        et_components     = ct_component_old_bapi
*       ET_RELATIONS      =
*       ET_SRULES         =
*       ET_OLIST          =
*****      et_oprol      = lt_oprol
*       ET_TEXTS          =
*       ET_TEXT_LINES     =
*       ET_PRTS           =
*       ET_COSTS_SUM      =
*       ET_COSTS_DETAILS  =
        return            = ct_return_bapi_old
*       EXTENSION_IN      =
*       EXTENSION_OUT     =
*       ET_REFORDER_SERNO_OLIST  =
        et_serviceoutline = ct_service_outlines_old
        et_servicelines   = ct_services_old
*       et_servicelimit   = lt_003[]
*       et_servicecontractlimits = lt_004[]
*       ET_PERMIT         =
*       ET_PERMIT_ISSUE   =
      .

    "Also return data from AFVC & RESB
    SELECT * FROM afvc
             INTO TABLE @ct_operation_old_db
             WHERE
              aufpl = @cs_pmord_header-routing_no.

    SELECT * FROM resb
             INTO TABLE @ct_component_old_db
             WHERE
              rsnum = @cs_pmord_header-reserv_no.


    "Initialize input structures
    APPEND VALUE #( orderid = iv_pmord_no ) TO ct_header.
    APPEND VALUE #( orderid = iv_pmord_no ) TO ct_header_up.
    ct_method = VALUE #(
              (
                refnumber = '1'
                objecttype = 'HEADER'
                method = 'CHANGE'
                objectkey = iv_pmord_no
                )
               ).

    zcl_xx_msg_logger=>add_msg_to_log(
    EXPORTING
    iv_log_hdl = iv_log_hdl
    iv_msgty = 'I'
    iv_msgid = 'ZMM'
    iv_msgno = '024'
    iv_msgv1 = CONV symsgv( |{ iv_pmord_no }| )
    iv_msgv2 = space
    iv_msgv3 = space
    iv_msgv4 = space ).
    IF 1 = 2.
      MESSAGE ID 'ZMM' TYPE 'I' NUMBER '024'.
    ENDIF.

*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-23 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>LOCK_PM_ORDER
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_AUFNR                       TYPE        AUFNR
* | [<---] EV_SUCCESS                     TYPE        BOOLE_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD lock_pm_order.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Lock a PM Order                                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-28 Apr 2026

    DATA: lt_jstat TYPE tt_jstat.

    "Find the internal object number of the PM Order
    SELECT SINGLE objnr FROM aufk
                        INTO @DATA(lv_objnr)
                        WHERE
                          aufnr = @iv_aufnr.

    "Add the LOCK status
    lt_jstat = VALUE #(
      (
        stat = gc_pmord_status_lock
      )
    ).

    CALL FUNCTION 'STATUS_CHANGE_INTERN'
      EXPORTING
*       CHECK_ONLY          = ' '
        client              = sy-mandt
        objnr               = lv_objnr
*       ZEILE               = ' '
        set_chgkz           = abap_true
* IMPORTING
*       ERROR_OCCURRED      =
*       OBJECT_NOT_FOUND    =
*       STATUS_INCONSISTENT =
*       STATUS_NOT_ALLOWED  =
      TABLES
        status              = lt_jstat
      EXCEPTIONS
        object_not_found    = 1
        status_inconsistent = 2
        status_not_allowed  = 3
        OTHERS              = 4.
    IF sy-subrc = 0.
* Implement suitable error handling here
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
    ENDIF.



*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-28 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>PEEK_PM_ORDER_OP_BUFFER
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_VORNR                       TYPE        VORNR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD peek_pm_order_op_buffer.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: SAP Does not have clear visibility of the operation num *
*              in case the previous attempt to add the operation ended *
*              in a limbo. So, we use brute force......................*
*              "You better start talking"                              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-1st Apr 2026
    DATA: lv_fname_vornr TYPE fieldname VALUE 'VORNR',

          lt_afvg_bt     TYPE STANDARD TABLE OF afvgd.
    FIELD-SYMBOLS: <lfs_t_afvg_bt> TYPE INDEX TABLE.

    DATA(lv_buffer_name) = |(SAPLCOBO)AFVG_BT[]|.
    DATA(lv_del_cond) = |VBKZ = 'D'|.

    ASSIGN (lv_buffer_name) TO <lfs_t_afvg_bt>.

    IF <lfs_t_afvg_bt> IS ASSIGNED.
      SORT <lfs_t_afvg_bt> BY (lv_fname_vornr) DESCENDING.
      DELETE <lfs_t_afvg_bt> WHERE (lv_del_cond).
      IF <lfs_t_afvg_bt>[] IS NOT INITIAL.
        ASSIGN COMPONENT 'VORNR' OF STRUCTURE <lfs_t_afvg_bt>[ 1 ] TO FIELD-SYMBOL(<lfs_v_latest_vornr>).
        ev_vornr = <lfs_v_latest_vornr>.
      ENDIF.
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-1st Apr 2026

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>PM_ORDER_FIND_DEFAULTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_AUFNR                       TYPE        AUFNR
* | [<---] ET_DEFAULT_OPER                TYPE        BAPI_ALM_ORDER_OPERATION_ET
* | [<---] ES_HEADER                      TYPE        BAPI_ALM_ORDER_HEADER_E
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD pm_order_find_defaults.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Find Default Operation Number from PM Order             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-17 Apr 2026

    DATA: ls_pmo_header  TYPE bapi_alm_order_header_e,

          lt_pmo_oper    TYPE bapi_alm_order_operation_et,
          lt_return_bapi TYPE bapiret2_t.

    CALL FUNCTION 'BAPI_ALM_ORDER_GET_DETAIL'
      EXPORTING
        number        = iv_aufnr
      IMPORTING
        es_header     = es_header
      TABLES
        et_operations = lt_pmo_oper
        return        = lt_return_bapi.

    "Default operations have Control key PM01
    et_default_oper = VALUE #(
      FOR ls_pmo_oper IN lt_pmo_oper WHERE ( control_key = zcl_mm_po_to_pmo=>gv_c_ctrl_key_labor )
      (
        ls_pmo_oper
      )
    ).


*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-17 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>TRIGGER_COST_CALCULATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_AUFNR                       TYPE        AUFNR
* | [--->] IV_LOG_HDL                     TYPE        BALLOGHNDL
* | [<---] EV_SUCCESS                     TYPE        BOOLE_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD trigger_cost_calculation.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Trigger calculation of Costs for a PM Order             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-04 May 2026
    DATA: ls_return_comt TYPE bapiret2,

          lt_method      TYPE bapi_alm_order_method_t,
          lt_header      TYPE bapi_alm_order_headers_i_t,
          lt_header_up   TYPE bapi_alm_order_headers_i_ut,
          lt_return_bapi TYPE bapiret2_t.

    "Reset the buffer
    CALL FUNCTION 'CO_ZF_DATA_RESET_COMPLETE'
*     EXPORTING
*       I_NO_OCM_RESET       = ' '
*       I_STATUS_RESET       = 'X'
*       I_NO_MAT_RESET       = ' '
      .


    lt_method = VALUE #(
      ( refnumber = 1 objecttype = 'HEADER' method = 'CHANGE' objectkey = iv_aufnr  )
      ( refnumber = 1 objecttype = 'HEADER' method = 'CALCULATE' objectkey = iv_aufnr  )
      ( refnumber = 1 objecttype = space method = 'SAVE'   )

    ).

    lt_header = VALUE #(
      ( orderid = iv_aufnr )
    ).

    lt_header_up = VALUE #(
    ( orderid = iv_aufnr )
    ).

    CALL FUNCTION 'BAPI_ALM_ORDER_MAINTAIN'
      DESTINATION 'NONE'
      TABLES
        it_methods   = lt_method
        it_header    = lt_header
        it_header_up = lt_header_up
        return       = lt_return_bapi.

    IF line_exists( lt_return_bapi[ type = 'E' ] )."Costin ended with error
      ev_success = abap_false.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK' DESTINATION 'NONE'.
      CALL FUNCTION 'RFC_CONNECTION_CLOSE'
        EXPORTING
          destination          = 'NONE'
        EXCEPTIONS
          destination_not_open = 1
          OTHERS               = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
      zcl_xx_msg_logger=>add_msg_to_log(
      EXPORTING
      iv_log_hdl = iv_log_hdl
      iv_msgty = 'E'
      iv_msgid = gc_msgid
      iv_msgno = gc_msgno_cost_error
      iv_msgv1 = CONV symsgv( |{ iv_aufnr }| ) ).
      IF 1 = 2.
        MESSAGE ID 'ZPM' TYPE 'I' NUMBER '053'.
      ENDIF.

      LOOP AT lt_return_bapi INTO DATA(ls_bapi_err) WHERE type = 'E'.
        zcl_xx_msg_logger=>add_msg_to_log(
        EXPORTING
        iv_log_hdl = iv_log_hdl
        iv_msgty = ls_bapi_err-type
        iv_msgid = ls_bapi_err-id
        iv_msgno = ls_bapi_err-number
        iv_msgv1 = CONV symsgv( |{ ls_bapi_err-message_v1 }| )
        iv_msgv2 = CONV symsgv( |{ ls_bapi_err-message_v2 }| )
        iv_msgv3 = CONV symsgv( |{ ls_bapi_err-message_v3 }| )
        iv_msgv4 = CONV symsgv( |{ ls_bapi_err-message_v4 }| ) ).
      ENDLOOP.
    ELSE. "Costing was successful

      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      DESTINATION 'NONE'
        EXPORTING
          wait   = abap_true
        IMPORTING
          return = ls_return_comt.
      CALL FUNCTION 'RFC_CONNECTION_CLOSE'
        EXPORTING
          destination          = 'NONE'
        EXCEPTIONS
          destination_not_open = 1
          OTHERS               = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
      zcl_xx_msg_logger=>add_msg_to_log(
      EXPORTING
      iv_log_hdl = iv_log_hdl
      iv_msgty = 'I'
      iv_msgid = gc_msgid
      iv_msgno = gc_msgno_cost_success
      iv_msgv1 = CONV symsgv( |{ iv_aufnr }| ) ).
      IF 1 = 2.
        MESSAGE ID 'ZPM' TYPE 'I' NUMBER '052'.
      ENDIF.
      ev_success = abap_true.
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-04 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>UNLOCK_PM_ORDER
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_AUFNR                       TYPE        AUFNR
* | [<---] EV_SUCCESS                     TYPE        BOOLE_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD unlock_pm_order.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Lock a PM Order                                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-28 Apr 2026
    DATA: lt_jstat TYPE tt_jstat.

    "Find the internal object number of the PM Order
    SELECT SINGLE objnr FROM aufk
                        INTO @DATA(lv_objnr)
                        WHERE
                          aufnr = @iv_aufnr.

    "Add the LOCK status
    lt_jstat = VALUE #(
      (
        stat = gc_pmord_status_lock
        inact = abap_true
      )
    ).

    CALL FUNCTION 'STATUS_CHANGE_INTERN'
      EXPORTING
*       CHECK_ONLY          = ' '
        client              = sy-mandt
        objnr               = lv_objnr
*       ZEILE               = ' '
        set_chgkz           = abap_true
* IMPORTING
*       ERROR_OCCURRED      =
*       OBJECT_NOT_FOUND    =
*       STATUS_INCONSISTENT =
*       STATUS_NOT_ALLOWED  =
      TABLES
        status              = lt_jstat
      EXCEPTIONS
        object_not_found    = 1
        status_inconsistent = 2
        status_not_allowed  = 3
        OTHERS              = 4.
    IF sy-subrc = 0.
* Implement suitable error handling here
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
    ENDIF.



*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-28 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_PM_HELPER=>VALIDATE_WORK_CENTER
* +-------------------------------------------------------------------------------------------------+
* | [--->] PM_ORDER                       TYPE        AUFNR
* | [--->] WORK_CENTER                    TYPE        ARBPL
* | [--->] PLANT                          TYPE        WERKS_D
* | [--->] DATE                           TYPE        DATS (default =SY-DATUM)
* | [!CX!] ZCX_STAT_GEN_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD validate_work_center.
*----------------------------------------------------------------------*
* Developer: AAAA (HDSFUI)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  LMASDI                               *
* Change Indicator: LMASDI-AGHSDFO-HDSFUI                         *
* Description: Validate the given work center                          *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-LMASDI-AGHSDFO-HDSFUI-15 May 2026
    DATA: pm_order_header   TYPE caufvd,
          pm_operation_info TYPE afvgd.

    IF pm_order IS INITIAL.
      RAISE EXCEPTION TYPE zcx_stat_gen_exception
        EXPORTING
          textid = VALUE #(
                      msgid = gc_msgid
                      msgno = gc_msgno_generic
                      attr1 = zcx_stat_gen_exception=>gc_attr_msgv1
          )
          msgv1  = condense( CONV symsgv( text-001 ) ).
    ENDIF.

    "Get the CAUFV entries required for validation
    SELECT SINGLE aufnr, auart, autyp, plnty
           FROM caufv
           INTO CORRESPONDING FIELDS OF @pm_order_header
           WHERE
            aufnr = @pm_order.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_stat_gen_exception
        EXPORTING
          textid = VALUE #(
                      msgid = gc_msgid
                      msgno = gc_msgno_generic
                      attr1 = zcx_stat_gen_exception=>gc_attr_msgv1
          )
          msgv1  = condense( CONV symsgv( text-002 ) ).
    ENDIF.

    "Fill in the Work Center Details
    pm_operation_info-werks = plant.
    pm_operation_info-arbpl = work_center.

    CALL FUNCTION 'CO_CHK_WORKSTATION'
      EXPORTING
        afvgd_imp        = pm_operation_info
        caufvd_imp       = pm_order_header
        sttag            = date
*     IMPORTING
*       AFVGD_EXP        =
*       RCR01_EXP        =
      EXCEPTIONS
        not_found        = 1
        type_not_allowed = 2
        OTHERS           = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_stat_gen_exception
        EXPORTING
          textid = VALUE #(
                      msgid = sy-msgid
                      msgno = sy-msgno
                      attr1 = zcx_stat_gen_exception=>gc_attr_msgv1
                      attr2 = zcx_stat_gen_exception=>gc_attr_msgv2
                      attr3 = zcx_stat_gen_exception=>gc_attr_msgv3
                      attr4 = zcx_stat_gen_exception=>gc_attr_msgv4
          )
          msgv1  = condense( CONV symsgv( sy-msgv1 ) )
          msgv2  = condense( CONV symsgv( sy-msgv2 ) )
          msgv3  = condense( CONV symsgv( sy-msgv3 ) )
          msgv4  = condense( CONV symsgv( sy-msgv4 ) ).
    ENDIF.
*<<<End of Changes-LMASDI-AGHSDFO-HDSFUI-15 May 2026
  ENDMETHOD.
ENDCLASS.
