class ZCL_MAIL_HELPER definition
  public
  final
  create public .

public section.

  types:
    mail_dl_list TYPE STANDARD TABLE OF so_obj_nam WITH EMPTY KEY .

  constants GC_MSGID type SYMSGID value 'ZXX' ##NO_TEXT.
  constants GC_MSGNO_NO_RECIPIENT type SYMSGID value '031' ##NO_TEXT.
  constants GC_MSGNO_MAIL_SEND_ERROR type SYMSGID value '032' ##NO_TEXT.
  constants MSGNO_INVALID_DL type SYMSGID value '033' ##NO_TEXT.
  constants GC_MAIL_PRIO_HIGH type BCS_DOCIMP value '1' ##NO_TEXT.
  constants GC_MAIL_PRIO_MED type BCS_DOCIMP value '5' ##NO_TEXT.
  constants GC_MAIL_PRIO_LOW type BCS_DOCIMP value '9' ##NO_TEXT.
  constants GC_MAIL_SENS_CONFIDENTIAL type SO_OBJ_SNS value 'P' ##NO_TEXT.
  constants GC_MAIL_SENS_FUNCTIONAL type SO_OBJ_SNS value 'F' ##NO_TEXT.
  constants GC_MAIL_SENS_STANDARD type SO_OBJ_SNS value 'O' ##NO_TEXT.
  constants GC_MAIL_SENS_BUSINESS type SO_OBJ_SNS value 'G' ##NO_TEXT.
  constants GC_MAIL_SENS_PERSONAL type SO_OBJ_SNS value 'E' ##NO_TEXT.

  class-methods SEND_MAIL
    importing
      !IT_REF_ATTACHMENTS type ZTT_XX_TAB_OF_REF optional
      !IT_EMAIL type PIQT_MAILADDR optional
      !DISTRIBUTION_LISTS type MAIL_DL_LIST optional
      value(I_TYPE) type SO_OBJ_TP default 'RAW'
      value(I_SUBJECT) type SO_OBJ_DES optional
      value(I_LENGTH) type SO_OBJ_LEN optional
      value(I_LANGUAGE) type SO_OBJ_LA default SPACE
      value(I_IMPORTANCE) type BCS_DOCIMP optional
      value(I_SENSITIVITY) type SO_OBJ_SNS optional
      !I_TEXT type SOLI_TAB optional
      !I_HEX type SOLIX_TAB optional
      !I_HEADER type SOLI_TAB optional
      value(I_SENDER) type ref to CL_CAM_ADDRESS_BCS optional
      value(IV_VSI_PROFILE) type VSCAN_PROFILE optional
      !IV_SOLIX_CONVERSION_REQD type BOOLE_D default ABAP_TRUE
    raising
      ZCX_STAT_GEN_EXCEPTION
      CX_DOCUMENT_BCS
      CX_SEND_REQ_BCS
      CX_ADDRESS_BCS
      CX_BCS .
  class-methods ITAB_TO_STRING
    importing
      !IT_ITAB type ANY TABLE
    returning
      value(RV_STRING) type STRING
    raising
      ZCX_STAT_GEN_EXCEPTION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MAIL_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MAIL_HELPER=>ITAB_TO_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_ITAB                        TYPE        ANY TABLE
* | [<-()] RV_STRING                      TYPE        STRING
* | [!CX!] ZCX_STAT_GEN_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD itab_to_string.
*----------------------------------------------------------------------*
* Developer: AAAAA (JOPPDF)                       *
* Date:      3rd Feb 2026                                              *
* Reference Change/Incident:  NNNN                                     *
* Change Indicator: NNNN-MPPLPP-JOPPDF                               *
* Description: Convert ITAB Content to a string                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-NNNN-MPPLPP-JOPPDF-4th Feb 2026
    DATA: lv_date       TYPE dats,
          lv_time       TYPE tims,
          lv_cell_value TYPE string,

          lt_stru_comp  TYPE cl_abap_structdescr=>component_table,

          lr_desc_itab  TYPE REF TO cl_abap_tabledescr,
          lr_desc_stru  TYPE REF TO cl_abap_structdescr,
          lr_desc_elem  TYPE REF TO cl_abap_elemdescr.

*****    "Get descriptor of the table
*****    lr_desc_itab ?= cl_abap_typedescr=>describe_by_data( it_itab ).
*****    "Get the structure descriptor of the table
*****    lr_desc_stru ?= lr_desc_itab->get_table_line_type( ).
    "Get the list of components in the structure
    lt_stru_comp = zcl_abap_helper=>construct_component_list(
    EXPORTING
    it_itab = it_itab )."lr_desc_stru->get_components( ).

    "Construct the header line
    LOOP AT lt_stru_comp INTO DATA(ls_stru_comp).
      DATA(lv_comp_idx) = sy-tabix.
      lr_desc_elem ?= ls_stru_comp-type.
      DATA(ls_ddic) = lr_desc_elem->get_ddic_field( ).

      IF lv_comp_idx = 1.
        rv_string = ls_ddic-scrtext_m.
      ELSE.
        rv_string = |{ rv_string }{ cl_abap_char_utilities=>horizontal_tab }{ ls_ddic-scrtext_m }|.
      ENDIF.
    ENDLOOP.

    "Fill in the data lines
    LOOP AT it_itab ASSIGNING FIELD-SYMBOL(<lfs_itab_line>).
      rv_string = |{ rv_string }{ cl_abap_char_utilities=>cr_lf }|. "Start a new line
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
*****          IF <lfv_itab_cell> IS NOT INITIAL.
*****            lv_itab_cell = |{ <lfv_itab_cell> NUMBER = (cl_abap_format=>n_user) }|.
*****          ELSE.
*****            CLEAR: <lfv_itab_cell>.
*****          ENDIF.
        ENDIF.




        IF lv_comp_idx = 1."First cell of the subsequent lines
          rv_string = |{ rv_string }{ lv_cell_value }|.
        ELSE.
          rv_string = |{ rv_string }{ cl_abap_char_utilities=>horizontal_tab }{ lv_cell_value }|.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

*<<<End of Changes-NNNN-MPPLPP-JOPPDF-4th Feb 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MAIL_HELPER=>SEND_MAIL
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_REF_ATTACHMENTS             TYPE        ZTT_XX_TAB_OF_REF(optional)
* | [--->] IT_EMAIL                       TYPE        PIQT_MAILADDR(optional)
* | [--->] DISTRIBUTION_LISTS             TYPE        MAIL_DL_LIST(optional)
* | [--->] I_TYPE                         TYPE        SO_OBJ_TP (default ='RAW')
* | [--->] I_SUBJECT                      TYPE        SO_OBJ_DES(optional)
* | [--->] I_LENGTH                       TYPE        SO_OBJ_LEN(optional)
* | [--->] I_LANGUAGE                     TYPE        SO_OBJ_LA (default =SPACE)
* | [--->] I_IMPORTANCE                   TYPE        BCS_DOCIMP(optional)
* | [--->] I_SENSITIVITY                  TYPE        SO_OBJ_SNS(optional)
* | [--->] I_TEXT                         TYPE        SOLI_TAB(optional)
* | [--->] I_HEX                          TYPE        SOLIX_TAB(optional)
* | [--->] I_HEADER                       TYPE        SOLI_TAB(optional)
* | [--->] I_SENDER                       TYPE REF TO CL_CAM_ADDRESS_BCS(optional)
* | [--->] IV_VSI_PROFILE                 TYPE        VSCAN_PROFILE(optional)
* | [--->] IV_SOLIX_CONVERSION_REQD       TYPE        BOOLE_D (default =ABAP_TRUE)
* | [!CX!] ZCX_STAT_GEN_EXCEPTION
* | [!CX!] CX_DOCUMENT_BCS
* | [!CX!] CX_SEND_REQ_BCS
* | [!CX!] CX_ADDRESS_BCS
* | [!CX!] CX_BCS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD send_mail.
*----------------------------------------------------------------------*
* Developer: AAAAA (JOPPDF)                       *
* Date:      3rd Feb 2026                                              *
* Reference Change/Incident:  NNNN                                     *
* Change Indicator: NNNN-MPPLPP-JOPPDF                               *
* Description: Send out an email to given list of recipients           *
*----------------------------------------------------------------------*

*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAA (JOPPDF)                       *
* Date:      25 Jun 2026                                               *
* Reference Change/Incident:  NBOPDF                               *
* Change Indicator: NBOPDF-MPPLPP-JOPPDF                         *
* Description: Allow sending mails to DL                               *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-NNNN-MPPLPP-JOPPDF-4th Feb 2026
    DATA: lv_extension TYPE soodk-objtp,
          lv_success   TYPE os_boolean.
    FIELD-SYMBOLS: <lft_attachment> TYPE ANY TABLE.

    IF it_email[] IS INITIAL AND
       distribution_lists IS INITIAL."NBOPDF-MPPLPP-JOPPDF-07 Jul 2026
      RAISE EXCEPTION TYPE zcx_stat_gen_exception
        EXPORTING
          textid = VALUE #(
                      msgid = gc_msgid
                      msgno = gc_msgno_no_recipient
          ).
    ENDIF.

    "Create the mail document reference
    DATA(lo_mail) = cl_document_bcs=>create_document(
    EXPORTING
      i_type = i_type
      i_subject = i_subject
      i_length = i_length
      i_language = i_language
      i_importance = i_importance
      i_sensitivity = i_sensitivity
      i_text = i_text
      i_hex = i_hex
      i_header = i_header
      i_sender = i_sender
      iv_vsi_profile     = iv_vsi_profile
    ).

    "If there are attachments,
    "Parse through them and convert them to individual strings
    LOOP AT it_ref_attachments ASSIGNING FIELD-SYMBOL(<lfs_ref_attachment>).
      ASSIGN <lfs_ref_attachment>-data_ref->* TO <lft_attachment>.
      lv_extension = zcl_abap_helper=>get_ext_from_string(
      EXPORTING
        iv_file_name = |{ <lfs_ref_attachment>-name }|
      ).

      IF iv_solix_conversion_reqd = abap_true.
        "Convert the data to string
        DATA(lv_string) = itab_to_string(
        EXPORTING
          it_itab = <lft_attachment>[] ).

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

    LOOP AT it_email INTO DATA(ls_email).

      DATA(lr_recipient) = cl_cam_address_bcs=>create_internet_address(
      EXPORTING
        i_address_string = ls_email
      ).
      lo_mail_send_req->add_recipient( i_recipient =  lr_recipient ).

    ENDLOOP.

*>>>Start of Changes-NBOPDF-MPPLPP-JOPPDF-07 Jul 2026
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
              RAISE EXCEPTION TYPE zcx_stat_gen_exception
                EXPORTING
                  textid = VALUE #(
                              msgid = gc_msgid
                              msgno = msgno_invalid_dl
                              attr1 = zcx_stat_gen_exception=>gc_attr_msgv1
                              )
                  msgv1  = condense( CONV symsgv( distribution_list ) ).
          ENDTRY.
      ENDTRY.
      lo_mail_send_req->add_recipient( i_recipient =  dl_ref ).
    ENDLOOP.
*<<<End of Changes-NBOPDF-MPPLPP-JOPPDF-07 Jul 2026

    lv_success = lo_mail_send_req->send( ).
    IF lv_success = abap_true.
    ELSE.
      RAISE EXCEPTION TYPE zcx_stat_gen_exception
        EXPORTING
          textid = VALUE #(
                      msgid = gc_msgid
                      msgno = gc_msgno_mail_send_error
          ).
    ENDIF.
*<<<End of Changes-NNNN-MPPLPP-JOPPDF-4th Feb 2026
  ENDMETHOD.
ENDCLASS.
