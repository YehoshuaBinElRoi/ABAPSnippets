class ZCL_MAIL_HELPER definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF name_reference,
        name     TYPE  char50,
        data_ref TYPE REF TO data,
      END OF name_reference .
  types:
    tt_name_reference TYPE STANDARD TABLE OF name_reference
                               WITH DEFAULT KEY
                               WITH NON-UNIQUE SORTED KEY name COMPONENTS name .
  types:
    mail_dl_list TYPE STANDARD TABLE OF so_obj_nam WITH EMPTY KEY .

  constants MSGID type SYMSGID value 'ZXX' ##NO_TEXT.
  constants MSGNO_NO_RECIPIENT type SYMSGID value '031' ##NO_TEXT.
  constants MSGNO_MAIL_SEND_ERROR type SYMSGID value '032' ##NO_TEXT.
  constants MSGNO_INVALID_DL type SYMSGID value '033' ##NO_TEXT.
  constants MAIL_PRIO_HIGH type BCS_DOCIMP value '1' ##NO_TEXT.
  constants MAIL_PRIO_MED type BCS_DOCIMP value '5' ##NO_TEXT.
  constants MAIL_PRIO_LOW type BCS_DOCIMP value '9' ##NO_TEXT.
  constants MAIL_SENS_CONFIDENTIAL type SO_OBJ_SNS value 'P' ##NO_TEXT.
  constants MAIL_SENS_FUNCTIONAL type SO_OBJ_SNS value 'F' ##NO_TEXT.
  constants MAIL_SENS_STANDARD type SO_OBJ_SNS value 'O' ##NO_TEXT.
  constants MAIL_SENS_BUSINESS type SO_OBJ_SNS value 'G' ##NO_TEXT.
  constants MAIL_SENS_PERSONAL type SO_OBJ_SNS value 'E' ##NO_TEXT.

  class-methods SEND_MAIL
    importing
      !REF_ATTACHMENTS type TT_NAME_REFERENCE optional
      !EMAIL_IDS type PIQT_MAILADDR optional
      !USER_IDS type USMD_T_USER optional
      !DISTRIBUTION_LISTS type MAIL_DL_LIST optional
      !MAIL_TYPE type SO_OBJ_TP default 'RAW'
      !MAIL_SUBJECT type SO_OBJ_DES optional
      !MAIL_LENGTH type SO_OBJ_LEN optional
      !MAIL_LANGUAGE type SO_OBJ_LA default SPACE
      !MAIL_IMPORTANCE type BCS_DOCIMP optional
      !MAIL_SENSITIVITY type SO_OBJ_SNS optional
      !MAIL_TEXT type SOLI_TAB optional
      !MAIL_HEX type SOLIX_TAB optional
      !MAIL_HEADER type SOLI_TAB optional
      !MAIL_SENDER type ref to CL_CAM_ADDRESS_BCS optional
      !ADD_MAIL_SENDER type BOOLE_D default ABAP_TRUE
      !VSI_PROFILE type VSCAN_PROFILE optional
      !SOLIX_CONVERSION_REQD type BOOLE_D default ABAP_TRUE
    raising
      ZCX_STATIC_GENERIC_EXCEPTION
      CX_DOCUMENT_BCS
      CX_SEND_REQ_BCS
      CX_ADDRESS_BCS
      CX_BCS .
  class-methods ITAB_TO_STRING
    importing
      !ITAB type ANY TABLE
    returning
      value(STRING) type STRING
    raising
      ZCX_STATIC_GENERIC_EXCEPTION .
  class-methods GET_EXTENSION_FROM_STRING
    importing
      !FILE_NAME type STRING
    returning
      value(EXTENSION) type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MAIL_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MAIL_HELPER=>GET_EXTENSION_FROM_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] FILE_NAME                      TYPE        STRING
* | [<-()] EXTENSION                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_extension_from_string.
*----------------------------------------------------------------------*
* Developer: AAAA (MNOPF)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:                                 *
* Change Indicator: -NBOPSD-MNOPF                         *
* Description: Retrieve extension from file name                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes--NBOPSD-MNOPF-08 Sep 2026
    IF file_name IS NOT INITIAL.
      TRY.
          FIND ALL OCCURRENCES OF '.' IN file_name MATCH OFFSET DATA(offset).
          ADD 1 TO offset.
          extension = file_name+offset.
        CATCH cx_root INTO DATA(lo_ex_root)."If any error occurred
          MESSAGE lo_ex_root->get_text( ) TYPE zcx_static_generic_exception=>msgty_status.
      ENDTRY.
    ENDIF.

*<<<End of Changes--NBOPSD-MNOPF-08 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MAIL_HELPER=>ITAB_TO_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] ITAB                           TYPE        ANY TABLE
* | [<-()] STRING                         TYPE        STRING
* | [!CX!] ZCX_STATIC_GENERIC_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD itab_to_string.
*----------------------------------------------------------------------*
* Developer: AAAA (MNOPF)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:                                 *
* Change Indicator: -NBOPSD-MNOPF                         *
* Description: Convert ITAB to a STRING                                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes--NBOPSD-MNOPF-08 Sep 2026
    DATA: lv_date       TYPE dats,
          lv_time       TYPE tims,
          lv_cell_value TYPE string,

          lt_stru_comp  TYPE cl_abap_structdescr=>component_table,

          lr_desc_itab  TYPE REF TO cl_abap_tabledescr,
          lr_desc_stru  TYPE REF TO cl_abap_structdescr,
          lr_desc_elem  TYPE REF TO cl_abap_elemdescr.


    "Get the list of components in the structure
    lt_stru_comp = zcl_abap_helper=>construct_component_list(
    EXPORTING
    it_itab = itab )."lr_desc_stru->get_components( ).

    "Construct the header line
    LOOP AT lt_stru_comp INTO DATA(ls_stru_comp).
      DATA(lv_comp_idx) = sy-tabix.
      lr_desc_elem ?= ls_stru_comp-type.
      DATA(ls_ddic) = lr_desc_elem->get_ddic_field( ).

      IF lv_comp_idx = 1.
        string = ls_ddic-scrtext_m.
      ELSE.
        string = |{ string }{ cl_abap_char_utilities=>horizontal_tab }{ ls_ddic-scrtext_m }|.
      ENDIF.
    ENDLOOP.

    "Fill in the data lines
    LOOP AT itab ASSIGNING FIELD-SYMBOL(<lfs_itab_line>).
      string = |{ string }{ cl_abap_char_utilities=>cr_lf }|. "Start a new line
      LOOP AT lt_stru_comp INTO ls_stru_comp.
        lv_comp_idx = sy-tabix.
        ASSIGN COMPONENT ls_stru_comp-name OF STRUCTURE <lfs_itab_line> TO FIELD-SYMBOL(<lfv_itab_cell>).
        lv_cell_value = <lfv_itab_cell>.

        IF ls_stru_comp-type->type_kind = cl_abap_typedescr=>typekind_date."Convert date type to output format
          IF lv_cell_value = '00000000' OR
             lv_cell_value IS INITIAL.
            CLEAR: lv_cell_value.
          ELSE.
            lv_date = lv_cell_value.
            lv_cell_value = |{ lv_date DATE = (cl_abap_format=>d_user) }|.
          ENDIF.
        ELSEIF ls_stru_comp-type->type_kind = cl_abap_typedescr=>typekind_time."Convert time type to output format
          IF lv_cell_value = '000000' OR
             lv_cell_value IS INITIAL.
            CLEAR: lv_cell_value.
          ELSE.
            lv_time = lv_cell_value.
            lv_cell_value = |{ lv_time TIME = (cl_abap_format=>t_user) }|.
          ENDIF.
        ELSEIF ls_stru_comp-type->type_kind = cl_abap_typedescr=>typekind_numeric."Convert numeric field to EMPTY, if no value present

        ENDIF.




        IF lv_comp_idx = 1."First cell of the subsequent lines
          string = |{ string }{ lv_cell_value }|.
        ELSE.
          string = |{ string }{ cl_abap_char_utilities=>horizontal_tab }{ lv_cell_value }|.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

*<<<End of Changes-NNNN-NBOPSD-MNOPF-4th Feb 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MAIL_HELPER=>SEND_MAIL
* +-------------------------------------------------------------------------------------------------+
* | [--->] REF_ATTACHMENTS                TYPE        TT_NAME_REFERENCE(optional)
* | [--->] EMAIL_IDS                      TYPE        PIQT_MAILADDR(optional)
* | [--->] USER_IDS                       TYPE        USMD_T_USER(optional)
* | [--->] DISTRIBUTION_LISTS             TYPE        MAIL_DL_LIST(optional)
* | [--->] MAIL_TYPE                      TYPE        SO_OBJ_TP (default ='RAW')
* | [--->] MAIL_SUBJECT                   TYPE        SO_OBJ_DES(optional)
* | [--->] MAIL_LENGTH                    TYPE        SO_OBJ_LEN(optional)
* | [--->] MAIL_LANGUAGE                  TYPE        SO_OBJ_LA (default =SPACE)
* | [--->] MAIL_IMPORTANCE                TYPE        BCS_DOCIMP(optional)
* | [--->] MAIL_SENSITIVITY               TYPE        SO_OBJ_SNS(optional)
* | [--->] MAIL_TEXT                      TYPE        SOLI_TAB(optional)
* | [--->] MAIL_HEX                       TYPE        SOLIX_TAB(optional)
* | [--->] MAIL_HEADER                    TYPE        SOLI_TAB(optional)
* | [--->] MAIL_SENDER                    TYPE REF TO CL_CAM_ADDRESS_BCS(optional)
* | [--->] ADD_MAIL_SENDER                TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] VSI_PROFILE                    TYPE        VSCAN_PROFILE(optional)
* | [--->] SOLIX_CONVERSION_REQD          TYPE        BOOLE_D (default =ABAP_TRUE)
* | [!CX!] ZCX_STATIC_GENERIC_EXCEPTION
* | [!CX!] CX_DOCUMENT_BCS
* | [!CX!] CX_SEND_REQ_BCS
* | [!CX!] CX_ADDRESS_BCS
* | [!CX!] CX_BCS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD send_mail.
*----------------------------------------------------------------------*
* Developer: AAAA (MNOPF)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:                                 *
* Change Indicator: -NBOPSD-MNOPF                         *
* Description: Send out emails to given list of recipients/DL          *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-NNNN-NBOPSD-MNOPF-4th Feb 2026
    DATA: lv_extension TYPE soodk-objtp,
          lv_success   TYPE os_boolean.
    FIELD-SYMBOLS: <lft_attachment> TYPE ANY TABLE.

    IF email_ids[] IS INITIAL AND
       distribution_lists IS INITIAL AND "-NBOPSD-MNOPF-07 Jul 2026
       user_ids[] IS INITIAL.
      RAISE EXCEPTION TYPE zcx_static_generic_exception
        EXPORTING
          textid = VALUE #(
                      msgid = msgid
                      msgno = msgno_no_recipient
          ).
    ENDIF.

    "Set the email ID of the Sender as the sender ID, if not already provided
    IF mail_sender IS NOT INITIAL.
      DATA(mail_sender_lcl) = mail_sender.
    ELSE.
      IF add_mail_sender = abap_true.
        DATA(user_emails) = zcl_abap_helper=>get_sap_user_emails( iv_user_id = sy-uname ).
        ASSIGN user_emails[ 1 ] TO FIELD-SYMBOL(<lfs_user_email>).
        IF sy-subrc = 0 AND
           <lfs_user_email>-email IS NOT INITIAL.
          mail_sender_lcl = cl_cam_address_bcs=>create_internet_address(
          EXPORTING
            i_address_string = <lfs_user_email>-email
          ).
        ENDIF.
      ENDIF.
    ENDIF.

    "Create the mail document reference
    DATA(lo_mail) = cl_document_bcs=>create_document(
    EXPORTING
      i_type          = mail_type
      i_subject       = mail_subject
      i_length        = mail_length
      i_language      = mail_language
      i_importance    = mail_importance
      i_sensitivity   = mail_sensitivity
      i_text          = mail_text
      i_hex           = mail_hex
      i_header        = mail_header
      i_sender        = mail_sender_lcl
      iv_vsi_profile  = vsi_profile
    ).

    "If there are attachments,
    "Parse through them and convert them to individual strings
    LOOP AT ref_attachments ASSIGNING FIELD-SYMBOL(<lfs_ref_attachment>).
      ASSIGN <lfs_ref_attachment>-data_ref->* TO <lft_attachment>.
      lv_extension = get_extension_from_string(
      EXPORTING
        file_name = |{ <lfs_ref_attachment>-name }|
      ).

      IF solix_conversion_reqd = abap_true.
        "Convert the data to string
        DATA(lv_string) = itab_to_string(
        EXPORTING
          itab = <lft_attachment>[] ).

        "Convert the string to SOLIX
        cl_bcs_convert=>string_to_solix(
        EXPORTING
          iv_string = lv_string
          iv_codepage = '4103'
          iv_add_bom = abap_true
        IMPORTING
          et_solix = DATA(lt_solix)
          ev_size  = DATA(lv_size)
        ).
      ELSE.
        lt_solix = <lft_attachment>.
      ENDIF.

      "Add the attachment to the mail
      lo_mail->add_attachment(
      EXPORTING
        i_attachment_type = lv_extension
        i_attachment_subject = <lfs_ref_attachment>-name
        i_attachment_size = lv_size
        i_att_content_hex = lt_solix
      ).

    ENDLOOP.

    DATA(lo_mail_send_req) = cl_bcs=>create_persistent( ).
    lo_mail_send_req->set_document( lo_mail ).

    LOOP AT email_ids INTO DATA(ls_email).

      DATA(recipient_email) = cl_cam_address_bcs=>create_internet_address(
      EXPORTING
        i_address_string = ls_email
      ).
      lo_mail_send_req->add_recipient( i_recipient =  recipient_email ).

    ENDLOOP.

*>>>Start of Changes--NBOPSD-MNOPF-08 Sep 2026
    "IF user IDs are supposed to receive the E-Mail
    LOOP AT user_ids INTO DATA(user_id).
      DATA(recipient_user) = cl_sapuser_bcs=>create( user_id ).
      lo_mail_send_req->add_recipient( i_recipient =  recipient_user ).
    ENDLOOP.
*<<<End of Changes--NBOPSD-MNOPF-08 Sep 2026

*>>>Start of Changes--NBOPSD-MNOPF-07 Jul 2026
    "Fill in the DLs
    LOOP AT distribution_lists INTO DATA(distribution_list).
      TRY.
          "Check if there is a public DL
          DATA(dl_ref) = cl_distributionlist_bcs=>getu_persistent( i_dliname = distribution_list i_private = abap_false ).
        CATCH cx_root INTO DATA(exception_ref).
          "If not find the private DL
          TRY.
              dl_ref = cl_distributionlist_bcs=>getu_persistent( i_dliname = distribution_list i_private = abap_true ).
            CATCH cx_root INTO exception_ref.
              RAISE EXCEPTION TYPE zcx_static_generic_exception
                EXPORTING
                  textid = VALUE #(
                              msgid = msgid
                              msgno = msgno_invalid_dl
                              attr1 = zcx_static_generic_exception=>attr_msgv1
                              )
                  msgv1  = condense( CONV symsgv( distribution_list ) ).
          ENDTRY.
      ENDTRY.
      lo_mail_send_req->add_recipient( i_recipient =  dl_ref ).
    ENDLOOP.
*<<<End of Changes--NBOPSD-MNOPF-07 Jul 2026

    lv_success = lo_mail_send_req->send( ).
    IF lv_success = abap_true.
      COMMIT WORK.
    ELSE.
      RAISE EXCEPTION TYPE zcx_static_generic_exception
        EXPORTING
          textid = VALUE #(
                      msgid = msgid
                      msgno = msgno_mail_send_error
          ).
    ENDIF.
*<<<End of Changes-NNNN-NBOPSD-MNOPF-4th Feb 2026
  ENDMETHOD.
ENDCLASS.
