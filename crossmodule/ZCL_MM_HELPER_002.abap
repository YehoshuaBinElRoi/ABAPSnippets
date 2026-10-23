class ZCL_MM_HELPER_002 definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF message_tracker_line,
        context       TYPE int4,
        busobj_id     TYPE int4,
        busobj        TYPE REF TO object,
        message_exist TYPE boole_d,
      END OF message_tracker_line .
  types:
    message_tracker TYPE STANDARD TABLE OF message_tracker_line WITH EMPTY KEY .

  constants GC_MSGID_MM type SYMSGID value 'ZMM' ##NO_TEXT.
  constants GC_DOC_TYP_PO type BSART value 'F' ##NO_TEXT.
  data FRONTEND_MESSAGES type MESSAGE_TRACKER .

  class-methods RETRIEVE_ME2M_DATA
    importing
      !IR_MATNR type MMPUR_T_MATNR
      !IR_WERKS type MMPUR_T_WERKS
    returning
      value(RT_ME2M_OUT) type ZMM_TT_ME2M_OUT .
  methods ADD_MM_MESSAGE
    importing
      !CONTEXT type INT4
      !OBJID type INT4 optional
      !OBJECT type ref to OBJECT optional
      !METAFIELD type INT4 optional
      !MSGID type SYMSGID
      !MSGTY type SYMSGTY
      !MSGNO type SYMSGNO
      !MSGV1 type SYMSGV default SPACE
      !MSGV2 type SYMSGV default SPACE
      !MSGV3 type SYMSGV default SPACE
      !MSGV4 type SYMSGV default SPACE .
  methods REMOVE_MM_MESSAGE
    importing
      !CONTEXT type INT4
      !OBJID type INT4 optional
      !OBJECT type ref to OBJECT optional .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_HELPER_002 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MM_HELPER_002->ADD_MM_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONTEXT                        TYPE        INT4
* | [--->] OBJID                          TYPE        INT4(optional)
* | [--->] OBJECT                         TYPE REF TO OBJECT(optional)
* | [--->] METAFIELD                      TYPE        INT4(optional)
* | [--->] MSGID                          TYPE        SYMSGID
* | [--->] MSGTY                          TYPE        SYMSGTY
* | [--->] MSGNO                          TYPE        SYMSGNO
* | [--->] MSGV1                          TYPE        SYMSGV (default =SPACE)
* | [--->] MSGV2                          TYPE        SYMSGV (default =SPACE)
* | [--->] MSGV3                          TYPE        SYMSGV (default =SPACE)
* | [--->] MSGV4                          TYPE        SYMSGV (default =SPACE)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_mm_message.
*----------------------------------------------------------------------*
* Developer: AAAAAAA (NLSFDO)                       *
* Date:      14 Jul 2026                                               *
* Reference Change/Incident:  MBOOAJO                               *
* Change Indicator: MBOOAJO-MBOAJSD-NLSFDO                         *
* Description: Add a message to log of ME* t-code                      *
*              This is a copy of ZCL_MM_HELPER=>ADD_PO_MM_MESSAGE      *
*              new and improved                                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-MBOOAJO-MBOAJSD-NLSFDO-14 Jul 2026
    INCLUDE mm_messages_mac.

    IF objid IS NOT INITIAL.
      "Pre-emptively check if the object ID exists in DB
      "The process is as follows
      "When PO is first opened, an object id is allcoated for header, item, schedule etc., and added to handlers
      "But this id is not updated to PO Item-ID until much later
      "If the ID is not available in the handler table, we do not have to add the message
      CALL METHOD cl_handle_manager_mm=>get
        EXPORTING
          im_id   = objid
        EXCEPTIONS
          failure = 1
          OTHERS  = 2.
      IF sy-subrc <> 0.
*     Implement suitable error handling here
        RETURN.
      ENDIF.

      mmpur_business_obj_id objid.
    ENDIF.

    IF metafield IS NOT INITIAL.
      mmpur_metafield metafield.
    ENDIF.

    mmpur_context context.
    mmpur_message_forced msgty msgid msgno msgv1 msgv2 msgv3 msgv4.


    ASSIGN frontend_messages[ context = context busobj_id = objid busobj = object ] TO FIELD-SYMBOL(<lfs_msg_tracker>).
    IF sy-subrc = 0.
      <lfs_msg_tracker>-message_exist = abap_true.
    ELSE.
      APPEND INITIAL LINE TO frontend_messages ASSIGNING <lfs_msg_tracker>.
      <lfs_msg_tracker>-context = context.
      <lfs_msg_tracker>-busobj_id = objid.
      <lfs_msg_tracker>-busobj = object.
      <lfs_msg_tracker>-message_exist = abap_true.
    ENDIF.

*<<<End of Changes-MBOOAJO-MBOAJSD-NLSFDO-14 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MM_HELPER_002->REMOVE_MM_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONTEXT                        TYPE        INT4
* | [--->] OBJID                          TYPE        INT4(optional)
* | [--->] OBJECT                         TYPE REF TO OBJECT(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD remove_mm_message.
*----------------------------------------------------------------------*
* Developer: AAAAAAA (NLSFDO)                       *
* Date:      14 Jul 2026                                               *
* Reference Change/Incident:  MBOOAJO                               *
* Change Indicator: MBOOAJO-MBOAJSD-NLSFDO                         *
* Description: Remove a message from log of ME* t-code                 *
*              This is a copy of ZCL_MM_HELPER=>REMOVE_PO_MM_MESSAGE   *
*              new and improved                                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-MBOOAJO-MBOAJSD-NLSFDO-14 Jul 2026
    INCLUDE mm_messages_mac.

    IF objid IS NOT INITIAL.
      "The below check happens inside the macro but we are unable to handle the exception
      "So, we check in advance, pre-emptively
      cl_handle_manager_mm=>get(
      EXPORTING
        im_id = objid
      EXCEPTIONS
        failure = 1
        OTHERS  = 2
        ).

      IF sy-subrc NE 0.
        RETURN.
      ENDIF.
    ENDIF.

    ASSIGN frontend_messages[ context = context busobj_id = objid busobj = object message_exist = abap_true ] TO FIELD-SYMBOL(<lfs_msg_tracker>).
    IF sy-subrc = 0.
      IF objid IS NOT INITIAL.
        mmpur_remove_msg_by_context objid context.
      ELSEIF object IS NOT INITIAL.
        cl_message_handler_mm=>get_handler(
          IMPORTING
            ex_handler = DATA(message_handler)
            ).

        message_handler->getlist(
          IMPORTING
            ex_events = DATA(events)
            ).

        "Ensure deleted events are not kept
        DATA(message_configuration) = message_handler->get_configuration( ).
        IF message_configuration-keep_deleted_events = abap_true.
          message_configuration-keep_deleted_events = abap_false.
          message_handler->set_configuration( im_configuration = message_configuration ).
        ENDIF.
        LOOP AT events INTO DATA(event) WHERE
                                         business_obj = object AND
                                         context      = context.
          message_handler->remove( event-event_obj ).
        ENDLOOP.

      ENDIF.
      <lfs_msg_tracker>-message_exist = abap_false.
    ENDIF.
*<<<End of Changes-MBOOAJO-MBOAJSD-NLSFDO-14 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MM_HELPER_002=>RETRIEVE_ME2M_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] IR_MATNR                       TYPE        MMPUR_T_MATNR
* | [--->] IR_WERKS                       TYPE        MMPUR_T_WERKS
* | [<-()] RT_ME2M_OUT                    TYPE        ZMM_TT_ME2M_OUT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD retrieve_me2m_data.
*----------------------------------------------------------------------*
* Developer: AAAAAAA (NLSFDO)                       *
* Date:      2nd Dec 2025                                              *
* Reference Change/Incident:  MBOOAJO                               *
* Change Indicator: MBOOAJO-MBOAJSD-NLSFDO                         *
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

*>>>Start of Changes-MBOOAJO-MBOAJSD-NLSFDO-2nd Dec 2025

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
    with em_werks in ir_werks[] "INSERTED -MBOOAJO-MBOAJSD-NLSFDO-28th Jan 2026
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

*<<<End of Changes-MBOOAJO-MBOAJSD-NLSFDO-2nd Dec 2025
  ENDMETHOD.
ENDCLASS.
