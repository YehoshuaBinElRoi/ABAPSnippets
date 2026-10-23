class ZCL_ABAP_HELPER_006 definition
  public
  create public .

public section.

  types:
    BEGIN OF key_value_pair,
             key   TYPE string,
             value TYPE string,
           END OF key_value_pair .
  types:
    BEGIN OF calendar_duration,
        years   TYPE int4,
        months  TYPE int4,
        days    TYPE int4,
        hours   TYPE int4,
        minutes TYPE int4,
        seconds TYPE int4,
      END OF calendar_duration .
  types:
    range_date TYPE RANGE OF dats .
  types:
    BEGIN OF line_job_status,
        jobname  TYPE tbtco-jobname,
        jobcount TYPE tbtco-jobcount,
        status   TYPE tbtco-status,
      END OF line_job_status .
  types:
    tt_job_status TYPE STANDARD TABLE OF line_job_status WITH DEFAULT KEY .
  types:
    range_string TYPE RANGE OF string .
  types:
    range_year TYPE RANGE OF gjahr .
  types:
    BEGIN OF month_year,
        month TYPE char02,
        year  TYPE char04, "gjahr,
      END OF month_year .
  types:
    t009c_entries TYPE STANDARD TABLE OF t009c WITH EMPTY KEY .
  types:
    BEGIN OF nested_component_mapping_line,
        component_name TYPE string,
        sub_components TYPE cl_abap_structdescr=>component_table,
      END OF nested_component_mapping_line .
  types:
    nested_component_mapping TYPE STANDARD TABLE OF nested_component_mapping_line WITH EMPTY KEY .
  types:
    range_period TYPE RANGE OF spmon .
  types:
    line_period TYPE LINE OF range_period .
  types:
    BEGIN OF elementary_fld_desc_line,
        index       TYPE i,
        string_name TYPE string.
            INCLUDE TYPE abap_compdescr.
    TYPES: suffix     TYPE string,
           as_include TYPE boole_d,
           END OF elementary_fld_desc_line .
  types:
    elementary_fld_desc TYPE SORTED TABLE OF elementary_fld_desc_line WITH UNIQUE KEY index .
  types:
    BEGIN OF element_line_detailed.
            INCLUDE TYPE elementary_fld_desc_line.
    TYPES: suffix_hier        TYPE stringtab,
           depth              TYPE i,
           element_descriptor TYPE REF TO cl_abap_datadescr,
           parent             TYPE string, "Immediate parent
           END OF element_line_detailed .
  types:
    element_list_detailed TYPE STANDARD TABLE OF element_line_detailed WITH EMPTY KEY .

  constants SUBMIT_TYPE_REPORT_ALV type NUMC2 value '01' ##NO_TEXT.
  constants SUBMIT_TYPE_REPORT_LIST type NUMC2 value '02' ##NO_TEXT.
  constants SUBMIT_TYPE_REPORT_IMPORT type NUMC2 value '03' ##NO_TEXT.
  constants MEMORY_ID_CONTROL_FLAGS type CHAR30 value 'ZAHCTRL' ##NO_TEXT.
  constants MSGID type SYMSGID value 'ZXX' ##NO_TEXT.
  constants MSGNO_DIR_SEARCH_FAILED type SYMSGNO value '131' ##NO_TEXT.
  constants MSGNO_DIR_CREATE_FAILED type SYMSGNO value '132' ##NO_TEXT.
  constants MSGNO_FIL_DLOAD_FAILED type SYMSGNO value '133' ##NO_TEXT.
  constants EXT_CMD_CREATE_DIR type SXPGLOGCMD value 'ZXX_MKDIR_AL11' ##NO_TEXT.
  constants CALENDAR_VARIANT_07_TO_06 type PERIV value 'V6' ##NO_TEXT.
  constants SECONDS_IN_A_DAY type I value 86400 ##NO_TEXT.
  constants SECONDS_IN_AN_HOUR type I value 3600 ##NO_TEXT.
  constants SECONDS_IN_A_MINUTE type I value 60 ##NO_TEXT.

  class-methods CALL_REPORT_GET_OUTPUT
    importing
      !REPORT_NAME type PROGRAMM
      !PARAMETERS type RSPARAMS_TT
      !MEMORY_ID_REPORT_OUTPUT type CHAR30 optional
      !SUBMIT_TYPE type NUMC2 default SUBMIT_TYPE_REPORT_ALV
    exporting
      value(OUTPUT_DATA) type ref to DATA
    raising
      CX_SALV_BS_SC_RUNTIME_INFO
      ZCX_STATIC_GENERIC_EXCEPTION .
  class-methods EXPORT_DATA_AND_TYPE_TO_MEMORY
    importing
      !DATA_TABLE type ANY TABLE optional
      !DATA type ANY optional
      !MEMORY_ID type CHAR30
      !RESOLVE_NESTED_TABLES type BOOLE_D default ABAP_TRUE
      !RESOLVE_NESTED_STRUCTURES type BOOLE_D default ABAP_TRUE .
  class-methods CREATE_ITAB_DYNAMIC
    importing
      !TYPE_NAME type ABAP_ABSTYPENAME optional
      !STRUCTURES type FAGL_TABNAME_RANGE optional
      !COMPONENTS type CL_ABAP_STRUCTDESCR=>COMPONENT_TABLE optional
      !ELEMENTARY_COMPONENTS type ELEMENTARY_FLD_DESC optional
      !GET_WA type BOOLE_D default ABAP_FALSE
    returning
      value(DATAREF) type ref to DATA .
  class-methods GET_ELEMENT_DESCRIPTOR
    importing
      !ELEMENTARY_COMPONENT type ELEMENTARY_FLD_DESC_LINE
    returning
      value(ELEMENT_DESCRIPTOR) type ref to CL_ABAP_ELEMDESCR .
  class-methods F4HELP_PERIOD
    importing
      !FIELD_TO_UPDATE type CHAR04 default 'LOW'
      !CALENDAR_VARIANT type PERIV default 'K4'
    changing
      !PERIODS type RANGE_PERIOD
      !PERIOD type LINE_PERIOD .
  class-methods RESOLVE_NESTED_STRUCTURES
    importing
      !ELEMENTARY_COMPONENTS type ELEMENTARY_FLD_DESC
    returning
      value(NESTED_COMPONENT_DESCRIPTORS) type ELEMENT_LIST_DETAILED .
  class-methods OBJECT_SERIALIZER
    importing
      !OBJECT type ref to OBJECT
    returning
      value(SERIALIZED) type STRING .
  class-methods OBJECT_DESERIALIZER
    importing
      !SERIALIZED type STRING
    returning
      value(OBJECT) type ref to OBJECT .
  class-methods GET_PERIOD_MASTER_INFORMATION
    importing
      !CALENDAR_VARIANT type PERIV
      !REFERENCE_DATE type DATS optional
    exporting
      !T009 type T009
      !T009T type T009T
      !T009B type FAA_T_T009B
      !T009C type T009C_ENTRIES
      !T247 type FTPS_WEB_MONTH_T .
  class-methods FILL_YEAR_MONTH_DROP_DOWN
    importing
      !T009 type T009
      !T009T type T009T
      !T009B type FAA_T_T009B
      !T009C type T009C_ENTRIES
      !T247 type FTPS_WEB_MONTH_T
      !YEARS type RANGE_YEAR optional
    exporting
      !MONTHS_DROPDOWN type VRM_VALUES
      !YEARS_DROPDOWN type VRM_VALUES .
  class-methods TNAPR_PRINT_GET_OTF
    importing
      !NAST type NAST
      !MEMID type CHAR30
    exporting
      !OTF type TT_ITCOO
      !MESSAGE type WZRE_MESSAGE .
  class-methods F4_HELP_FILE_PATH
    importing
      !WINDOW_TITLE type STRING optional
      !FILTER type STRING optional
      !EXTENSION type STRING optional
      !FOLDER type BOOLE_D default ABAP_FALSE
      !OPEN_MODE type BOOLE_D default ABAP_FALSE
    returning
      value(PATH) type LOCALFILE .
  class-methods DOWNLOAD_XSTRING_TO_PDF_FILE
    importing
      !XSTRING_CONTENT type XSTRING
      !TO_APPL_SERVER type BOOLE_D default ABAP_FALSE
      !FILE_SIZE type I
      !FILE_FULL_PATH type STRING
      !SHOW_TRANSFER_STATUS type BOOLE_D default ABAP_TRUE
    raising
      ZCX_STATIC_GENERIC_EXCEPTION .
  class-methods CREATE_DIRECTORY_PATH
    importing
      !FULL_PATH type STRING
      !ON_APPL_SERVER type BOOLE_D default ABAP_FALSE
    raising
      ZCX_STATIC_GENERIC_EXCEPTION .
  class-methods GET_PATH_FROM_DIR_ALIAS
    importing
      !ALIAS type STRING
    returning
      value(PATH) type STRING .
  class-methods CHOOSE_FILE_PATH
    importing
      !PREFERRED_DIR type STRING optional
      !PREFERRED_DIR_PATH type STRING optional
      !PREFERRED_SUB_PATH type STRING default SPACE
      !FALLBACK_DIR type STRING optional
      !FALLBACK_DIR_PATH type STRING optional
      !FALLBACK_SUB_PATH type STRING default SPACE
    returning
      value(CHOSEN_PATH) type STRING .
  class-methods IS_BG_MODE
    returning
      value(BG_MODE) type BOOLE_D .
  class-methods CHECK_DIRECTORY_EXISTS
    importing
      !FOLDER_PATH type STRING
      !ON_APPL_SERVER type BOOLE_D default ABAP_FALSE
    returning
      value(DIRECTORY_EXISTS) type BOOLE_D
    raising
      ZCX_STATIC_GENERIC_EXCEPTION .
  class-methods GET_FILE_SEPARATOR
    importing
      !ON_APPL_SERVER type BOOLE_D default ABAP_FALSE
    returning
      value(SEPARATOR) type CHAR01 .
  class-methods SPLIT_FILE_AND_PATH
    importing
      !FULL_PATH type STRING
      !ON_APPL_SERVER type BOOLE_D
    exporting
      !FOLDER_PATH type STRING
      !FILE_NAME type STRING .
  class-methods CHECK_BATCH_STATUS
    importing
      !JOB_LIST type TT_JOB_STATUS
    returning
      value(JOB_STATUS) type TT_JOB_STATUS .
  class-methods GET_FISCAL_YEAR_DATE_RANGE
    importing
      !FISCAL_YEAR type GJAHR
      !FISCAL_YEAR_VARIANT type PERIV default 'V6'
      !COMPANY_CODE type BUKRS default '1000'
    exporting
      !DATE_FROM type DATS
      !DATE_TO type DATS .
  class-methods FISCAL_RANGE_TO_DATE_RANGE
    importing
      !RANGE_YEARS type RANGE_YEAR
    returning
      value(RANGE_DATES) type RANGE_DATE .
  class-methods CALL_EXISTING_F4_HELP
    importing
      !SHLPNAME type SHLPNAME
      !VALFIELD type DDSHLPSFLD optional
      !CROSS_VALFIELD type DDSHLPSFLD optional
      !CROSS_VALUE type ANY optional
      !RETVALFIELD type DDSHLPSFLD
    exporting
      !RET_VALUE type ANY .
  class-methods GET_TIME_DIFF_DHMS
    importing
      !START_DATE type DATS
      !START_TIME type TIMS
      !END_DATE type DATS
      !END_TIME type TIMS
    exporting
      !DURATION type CALENDAR_DURATION
      !SECONDS type TZNTSTMPL .
  class-methods SEC_TO_DHMS
    importing
      !SECONDS type TZNTSTMPL
    exporting
      !DURATION type CALENDAR_DURATION .
  class-methods MAKE_SING_PLUR_SUFFIX
    importing
      !VALUE type INT4
      !TEXT type STRING
      !CONSIDER_ZERO type BOOLE_D default ABAP_FALSE
      !SUFFIX_SPACE_IF_NOT_EMPTY type BOOLE_D default ABAP_FALSE
    returning
      value(SUFFIXED) type STRING .
  class-methods CONV_DATE_RANGE_TO_STRING
    importing
      !DATES type RANGE_DATE
    returning
      value(FMT_STRING) type STRING .
  class-methods CONV_RANGE_TO_STRING
    importing
      !RANGE type ANY TABLE
      !ADD_ALL_LINES type BOOLE_D default ABAP_FALSE
      !UNIT type STRING optional
      !LBL_OPTION_I type STRING default 'Should Be'
      !LBL_OPTION_E type STRING default 'Should Not Be'
      !LBL_SIGN_EQ type STRING default 'Equal To'
      !LBL_SIGN_NE type STRING default 'Not Equal To'
      !LBL_SIGN_GT type STRING default 'Over'
      !LBL_SIGN_GE type STRING default 'And Above'
      !LBL_SIGN_LT type STRING default 'Under'
      !LBL_SIGN_LE type STRING default 'And Below'
      !LBL_SIGN_BT type STRING default 'Between'
      !VAL_SEPARATOR type STRING default 'Or'
      !SEC_SEPARATOR type STRING default '/'
    returning
      value(FMT_STRING) type STRING .
  class-methods DISPLAY_PDF_PREVIEW
    importing
      !REPID type SYREPID
      !DYNNR type SYDYNNR
      !CONTAINER_NAME type C default 'REP_CONTAINER'
      !OTF_DATA type TT_ITCOO optional
      !XSTRING_DATA type XSTRING optional .
  class-methods CONV_BIN_255_TO_1024
    importing
      !BIN_255 type SOLIX_TAB
      !LENGTH type I
    exporting
      !BIN_1024 type FKK_TBL1024_T .
  class-methods CALL_SELF .
  class-methods SPLIT_STRING_INTO_N
    importing
      !STRING type STRING
      !LENGTH type INT4
    returning
      value(SPLIT_STRINGS) type STRINGTAB .
protected section.
private section.

  class-data CHECK_EXEMPTED_FOLDERS type RANGE_STRING .
  class-data CONTAINER_PDF_PREVIEW type ref to CL_GUI_CUSTOM_CONTAINER .
ENDCLASS.



CLASS ZCL_ABAP_HELPER_006 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CALL_EXISTING_F4_HELP
* +-------------------------------------------------------------------------------------------------+
* | [--->] SHLPNAME                       TYPE        SHLPNAME
* | [--->] VALFIELD                       TYPE        DDSHLPSFLD(optional)
* | [--->] CROSS_VALFIELD                 TYPE        DDSHLPSFLD(optional)
* | [--->] CROSS_VALUE                    TYPE        ANY(optional)
* | [--->] RETVALFIELD                    TYPE        DDSHLPSFLD
* | [<---] RET_VALUE                      TYPE        ANY
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CALL_EXISTING_F4_HELP.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      2nd Mar 2026                                              *
* Reference Change/Incident:  5000008282                               *
* Change Indicator: 5000008282-Jonahs-XNSHDYK                         *
* Description: Call an existing F4 help                                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*


    "Courtesy: https://keremkoseoglu.wordpress.com/2009/03/25/how-to-call-a-sap-search-help-manually/
*>>>Start of Changes-5000008282-Jonahs-XNSHDYK-30 Sep 2026
    DATA: shlp          TYPE shlp_descr,

          return_values TYPE STANDARD TABLE OF ddshretval WITH DEFAULT KEY.



    CALL FUNCTION 'F4IF_GET_SHLP_DESCR'
      EXPORTING
        shlpname = shlpname
      IMPORTING
        shlp     = shlp.


    IF valfield IS NOT INITIAL.
      DATA(valfield_lcl) = valfield.
    ELSE.
      valfield_lcl = retvalfield.
    ENDIF.

    LOOP AT shlp-interface ASSIGNING FIELD-SYMBOL(<shlp_intf>).
      CASE <shlp_intf>-shlpfield.
        WHEN valfield.
          <shlp_intf>-valfield = abap_true.
        WHEN cross_valfield.
          APPEND INITIAL LINE TO shlp-selopt ASSIGNING FIELD-SYMBOL(<shlp_selopt>).
          <shlp_selopt>-shlpname = shlp-shlpname.
          <shlp_selopt>-shlpfield = <shlp_intf>-shlpfield.
          <shlp_selopt>-option = 'EQ'.
          <shlp_selopt>-sign = 'I'.
          <shlp_selopt>-low = cross_value.
      ENDCASE.
    ENDLOOP.

    CALL FUNCTION 'F4IF_START_VALUE_REQUEST'
      EXPORTING
        shlp          = shlp
      TABLES
        return_values = return_values.

    LOOP AT return_values ASSIGNING FIELD-SYMBOL(<return_value>).
      CASE <return_value>-fieldname.
        WHEN retvalfield. ret_value = <return_value>-fieldval.
      ENDCASE.
    ENDLOOP.
*<<<End of Changes-5000008282-Jonahs-XNSHDYK-30 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CALL_REPORT_GET_OUTPUT
* +-------------------------------------------------------------------------------------------------+
* | [--->] REPORT_NAME                    TYPE        PROGRAMM
* | [--->] PARAMETERS                     TYPE        RSPARAMS_TT
* | [--->] MEMORY_ID_REPORT_OUTPUT        TYPE        CHAR30(optional)
* | [--->] SUBMIT_TYPE                    TYPE        NUMC2 (default =SUBMIT_TYPE_REPORT_ALV)
* | [<---] OUTPUT_DATA                    TYPE REF TO DATA
* | [!CX!] CX_SALV_BS_SC_RUNTIME_INFO
* | [!CX!] ZCX_STATIC_GENERIC_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CALL_REPORT_GET_OUTPUT.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Call an ABAP report and return the output               *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-21 Jul 2026



    IF submit_type = submit_type_report_alv.
      "Set parameters to suppress display of ALV but return the data
      cl_salv_bs_runtime_info=>set(
        display = abap_false
        metadata = abap_false
        data = abap_true
      ).

      "Call the report
      SUBMIT (report_name)
      WITH SELECTION-TABLE parameters[]
      AND RETURN.                                        "#EC CI_SUBMIT

      "Get a reference of the output
      cl_salv_bs_runtime_info=>get_data_ref(
      IMPORTING

        r_data = output_data
      ).

      "Clear the settings which prevent ALV display
      cl_salv_bs_runtime_info=>clear_all( ).

    ELSEIF submit_type = submit_type_report_list.
      DATA: abap_list  TYPE table_abaplist,
            ascii_list TYPE STANDARD TABLE OF text1024.

      "Call the report
      SUBMIT (report_name)
      WITH SELECTION-TABLE parameters[]
      EXPORTING LIST TO MEMORY
      AND RETURN.                                        "#EC CI_SUBMIT

      "Get the output
      CALL FUNCTION 'LIST_FROM_MEMORY'
        TABLES
          listobject = abap_list
*       EXCEPTIONS
*         NOT_FOUND  = 1
*         OTHERS     = 2
        .
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_static_generic_exception
          EXPORTING
            textid = VALUE #(
                        msgid = sy-msgid
                        msgno = sy-msgno
                        attr1 = zcx_static_generic_exception=>gc_attr_msgv1
                        attr2 = zcx_static_generic_exception=>gc_attr_msgv2
                        attr3 = zcx_static_generic_exception=>gc_attr_msgv3
                        attr4 = zcx_static_generic_exception=>gc_attr_msgv4
            )
            msgv1  = sy-msgv1
            msgv2  = sy-msgv2
            msgv3  = sy-msgv3
            msgv4  = sy-msgv4.
      ELSE.
        CALL FUNCTION 'LIST_TO_ASCI'
*         EXPORTING
*           LIST_INDEX               = -1
*           WITH_LINE_BREAK          = ' '
*         IMPORTING
*           LIST_STRING_ASCII        =
*           LIST_DYN_ASCII           =
          TABLES
            listasci           = ascii_list
            listobject         = abap_list
          EXCEPTIONS
            empty_list         = 1
            list_index_invalid = 2
            OTHERS             = 3.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_static_generic_exception
            EXPORTING
              textid = VALUE #(
                          msgid = sy-msgid
                          msgno = sy-msgno
                          attr1 = zcx_static_generic_exception=>gc_attr_msgv1
                          attr2 = zcx_static_generic_exception=>gc_attr_msgv2
                          attr3 = zcx_static_generic_exception=>gc_attr_msgv3
                          attr4 = zcx_static_generic_exception=>gc_attr_msgv4
              )
              msgv1  = sy-msgv1
              msgv2  = sy-msgv2
              msgv3  = sy-msgv3
              msgv4  = sy-msgv4.
        ELSE.
          output_data = REF #( ascii_list ).
        ENDIF.

      ENDIF.

    ELSEIF submit_type = submit_type_report_import.

      EXPORT need_data_export = abap_true TO MEMORY ID memory_id_control_flags.

      "Call the report
      SUBMIT (report_name)
      WITH SELECTION-TABLE parameters[]
      EXPORTING LIST TO MEMORY
      AND RETURN.                                        "#EC CI_SUBMIT

      "Assumption:
      "The report being called has the below call
      "ZCL_ABAP_HELPER_004=>EXPORT_DATA_AND_TYPE_TO_MEMORY( ... ).


      "Get the type of the data
      DATA: component_list      TYPE elementary_fld_desc.
      "type_descriptor_xml TYPE string.
      IMPORT component_list = component_list FROM MEMORY ID memory_id_report_output.

      "Create a sample internal table of same type
      output_data = create_itab_dynamic( elementary_components = component_list ).
      ASSIGN output_data->* TO FIELD-SYMBOL(<output_fs>).


      "Import the data into the created internal table
      IMPORT data = <output_fs> FROM MEMORY ID memory_id_report_output.


    ELSE.
    ENDIF.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-21 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CALL_SELF
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CALL_SELF.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Call a report from within itself.                       *
*              Useful when we are N screens deep and want to go to     *
*              input screen                                            *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-19 Oct 2026
    DATA: parameters TYPE ty_rsparams.
    "Get the inputs specified on selection screen
    CALL FUNCTION 'RS_REFRESH_FROM_SELECTOPTIONS'
      EXPORTING
        curr_report     = sy-cprog
* IMPORTING
*       SP              =
      TABLES
        selection_table = parameters
*       SELECTION_TABLE_255       =
* EXCEPTIONS
*       NOT_FOUND       = 1
*       NO_REPORT       = 2
*       OTHERS          = 3
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      "Call the report again with same inputs
      SUBMIT (sy-cprog) WITH SELECTION-TABLE parameters
                        VIA SELECTION-SCREEN.
    ENDIF.

*<<<End of Changes-5000008399-Jonahs-XNSHDYK-19 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CHECK_BATCH_STATUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] JOB_LIST                       TYPE        TT_JOB_STATUS
* | [<-()] JOB_STATUS                     TYPE        TT_JOB_STATUS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CHECK_BATCH_STATUS.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: SPOC to download POs and invoices for a vendor          *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-11 Sep 2026
    IF job_list IS NOT INITIAL.
      DATA(job_list_lcl) = job_list.
      SORT job_list_lcl BY jobname jobcount.
      DELETE job_list_lcl WHERE jobname IS INITIAL AND
                                jobcount IS INITIAL.
      DELETE ADJACENT DUPLICATES FROM job_list_lcl COMPARING jobname jobcount.

      IF job_list_lcl IS NOT INITIAL.
        SELECT jobname, jobcount, status
               FROM tbtco
               INTO CORRESPONDING FIELDS OF TABLE @job_status
               FOR ALL ENTRIES IN @job_list_lcl
               WHERE
                jobname = @job_list_lcl-jobname AND
                jobcount = @job_list_lcl-jobcount.
      ENDIF.


    ENDIF.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-11 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CHECK_DIRECTORY_EXISTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] FOLDER_PATH                    TYPE        STRING
* | [--->] ON_APPL_SERVER                 TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<-()] DIRECTORY_EXISTS               TYPE        BOOLE_D
* | [!CX!] ZCX_STATIC_GENERIC_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CHECK_DIRECTORY_EXISTS.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Check if directory exists in Pres. or Appl. Server      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-04 Sep 2026

    DATA: appl_srv_dir_list TYPE eps2filis.

    IF on_appl_server = abap_true.
      DATA(dir_name_al11) = CONV eps2filnam( folder_path ).
      CALL FUNCTION 'EPS2_GET_DIRECTORY_LISTING'
        EXPORTING
          iv_dir_name            = dir_name_al11
*         FILE_MASK              = ' '
*       IMPORTING
*         DIR_NAME               =
*         FILE_COUNTER           =
*         ERROR_COUNTER          =
        TABLES
          dir_list               = appl_srv_dir_list
        EXCEPTIONS
          invalid_eps_subdir     = 1
          sapgparam_failed       = 2
          build_directory_failed = 3
          no_authorization       = 4
          read_directory_failed  = 5
          too_many_read_errors   = 6
          empty_directory_list   = 7
          error_message          = 99
          OTHERS                 = 8.
      IF sy-subrc = 5."Directory does not exist
        directory_exists = abap_false.
      ELSEIF sy-subrc = 7."Empty directory exists
        directory_exists = abap_true.
      ELSEIF sy-subrc <> 0.
* Implement suitable error handling here
        zcx_static_generic_exception=>raise_exception(
        msgid = sy-msgid
        msgno = sy-msgno
        msgv1 = sy-msgv1
        msgv2 = sy-msgv2
        msgv3 = sy-msgv3
        msgv4 = sy-msgv4
        ).
      ELSE.
        directory_exists = abap_true.
      ENDIF.
      IF sy-batch = abap_true.
        MESSAGE |Check:{ dir_name_al11 }----RC:{ sy-subrc }---Exists:{ directory_exists }| TYPE 'S'.
      ENDIF.

    ELSE.
      cl_gui_frontend_services=>directory_exist(
      EXPORTING
        directory = folder_path
      RECEIVING
        result = directory_exists
      EXCEPTIONS
        cntl_error = 1
        error_no_gui = 2
        wrong_parameter = 3
        not_supported_by_gui = 4
      ).

      IF sy-subrc <> 0.
        zcx_static_generic_exception=>raise_exception(
        msgid = msgid
        msgno = msgno_dir_search_failed
        ).
      ENDIF.
    ENDIF.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-04 Sep 2026

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CHOOSE_FILE_PATH
* +-------------------------------------------------------------------------------------------------+
* | [--->] PREFERRED_DIR                  TYPE        STRING(optional)
* | [--->] PREFERRED_DIR_PATH             TYPE        STRING(optional)
* | [--->] PREFERRED_SUB_PATH             TYPE        STRING (default =SPACE)
* | [--->] FALLBACK_DIR                   TYPE        STRING(optional)
* | [--->] FALLBACK_DIR_PATH              TYPE        STRING(optional)
* | [--->] FALLBACK_SUB_PATH              TYPE        STRING (default =SPACE)
* | [<-()] CHOSEN_PATH                    TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CHOOSE_FILE_PATH.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Pick and return a valid folder path in appl. server     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-26 Aug 2026
    "The path to the preferred directory
    IF preferred_dir IS NOT INITIAL.
      "Get the directory path mapped to the alias
      DATA(target_directory) = get_path_from_dir_alias( preferred_dir ).
    ELSEIF preferred_dir_path IS NOT INITIAL.
      "Use the directory path given as input
      target_directory = preferred_dir_path.
    ENDIF.

    IF target_directory IS NOT INITIAL.
      DATA(full_path) =  |{ target_directory }| &&
                         |{ COND #( WHEN preferred_sub_path IS NOT INITIAL THEN |\\{ preferred_sub_path }| ) }|.
      DATA(dir_name) = CONV epsf-epsdirnam( full_path ).

      "Check if the path exists
      DATA: dir_list TYPE STANDARD TABLE OF epsfili.
      CALL FUNCTION 'EPS_GET_DIRECTORY_LISTING'
        EXPORTING
          dir_name               = dir_name
        TABLES
          dir_list               = dir_list
        EXCEPTIONS
          invalid_eps_subdir     = 1
          sapgparam_failed       = 2
          build_directory_failed = 3
          no_authorization       = 4
          read_directory_failed  = 5
          too_many_read_errors   = 6
          empty_directory_list   = 7
          OTHERS                 = 8.
      IF sy-subrc = 0 OR
         sy-subrc = 7."Directory exists
        "The Full AL11 path where we need to upload the file
        chosen_path = full_path.
      ENDIF.
    ENDIF.
    IF chosen_path IS INITIAL. "The Preferred directory is not present Or Preferred Dir + Sub Path is not present Or Preferred Dir Path + Sub Path is not present
      "Use the fallback directory
      IF fallback_dir IS NOT INITIAL.
        "Get the fallback directory path mapped to the alias
        target_directory = get_path_from_dir_alias( fallback_dir ).
      ELSEIF fallback_dir_path IS NOT INITIAL.
        "Use the fallback irectory path given as input
        target_directory = fallback_dir_path.
      ENDIF.

      IF target_directory IS NOT INITIAL.
        full_path =  |{ target_directory }| &&
                     |{ COND #( WHEN fallback_sub_path IS NOT INITIAL THEN |\\{ fallback_sub_path }| ) }|.
        dir_name = CONV epsf-epsdirnam( full_path ).

        "Check if the fallback path exists
        CALL FUNCTION 'EPS_GET_DIRECTORY_LISTING'
          EXPORTING
            dir_name               = dir_name
          TABLES
            dir_list               = dir_list
          EXCEPTIONS
            invalid_eps_subdir     = 1
            sapgparam_failed       = 2
            build_directory_failed = 3
            no_authorization       = 4
            read_directory_failed  = 5
            too_many_read_errors   = 6
            empty_directory_list   = 7
            OTHERS                 = 8.
        IF sy-subrc = 0 OR
           sy-subrc = 7."Directory exists
          "The Full AL11 path where we need to upload the file
          chosen_path = full_path.
        ENDIF.
      ENDIF.
    ENDIF.

*<<<End of Changes-5000008399-Jonahs-XNSHDYK-26 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CONV_BIN_255_TO_1024
* +-------------------------------------------------------------------------------------------------+
* | [--->] BIN_255                        TYPE        SOLIX_TAB
* | [--->] LENGTH                         TYPE        I
* | [<---] BIN_1024                       TYPE        FKK_TBL1024_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CONV_BIN_255_TO_1024.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Conver a 255 char Bin to 1024 char bin                  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-15 Oct 2026
    DATA: xstring_data TYPE xstring.
    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
      EXPORTING
        input_length = length
      IMPORTING
        buffer       = xstring_data
      TABLES
        binary_tab   = bin_255.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer     = xstring_data
      TABLES
        binary_tab = bin_1024.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-15 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CONV_DATE_RANGE_TO_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] DATES                          TYPE        RANGE_DATE
* | [<-()] FMT_STRING                     TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CONV_DATE_RANGE_TO_STRING.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Convert a Range of Dates to String representation       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
    CHECK dates IS NOT INITIAL.

    DATA(dates_lcl) = dates.

    SORT dates_lcl BY low high.

    ASSIGN dates_lcl[ 1 ] TO FIELD-SYMBOL(<first_entry>).
    ASSIGN dates_lcl[ lines( dates_lcl ) ] TO FIELD-SYMBOL(<last_entry>).

    DATA(start_date) = <first_entry>-low.
    IF start_date IS INITIAL. "First entry just has High value?
      start_date = <first_entry>-high.
    ENDIF.

    DATA(end_date) = <last_entry>-high.
    IF end_date IS INITIAL. "Last entry just has Low Value
      end_date = <last_entry>-low.
    ENDIF.

    fmt_string = |{ start_date DATE = USER }|.
    IF end_date IS NOT INITIAL.
      fmt_string = |{ fmt_string } To { end_date DATE = USER }|.
    ENDIF.


*<<<End of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CONV_RANGE_TO_STRING
* +-------------------------------------------------------------------------------------------------+
* | [--->] RANGE                          TYPE        ANY TABLE
* | [--->] ADD_ALL_LINES                  TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] UNIT                           TYPE        STRING(optional)
* | [--->] LBL_OPTION_I                   TYPE        STRING (default ='Should Be')
* | [--->] LBL_OPTION_E                   TYPE        STRING (default ='Should Not Be')
* | [--->] LBL_SIGN_EQ                    TYPE        STRING (default ='Equal To')
* | [--->] LBL_SIGN_NE                    TYPE        STRING (default ='Not Equal To')
* | [--->] LBL_SIGN_GT                    TYPE        STRING (default ='Over')
* | [--->] LBL_SIGN_GE                    TYPE        STRING (default ='And Above')
* | [--->] LBL_SIGN_LT                    TYPE        STRING (default ='Under')
* | [--->] LBL_SIGN_LE                    TYPE        STRING (default ='And Below')
* | [--->] LBL_SIGN_BT                    TYPE        STRING (default ='Between')
* | [--->] VAL_SEPARATOR                  TYPE        STRING (default ='Or')
* | [--->] SEC_SEPARATOR                  TYPE        STRING (default ='/')
* | [<-()] FMT_STRING                     TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD conv_range_to_string.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Convert a Range of Anything to String representation    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Oct 2026                                               *
* Reference Change/Incident:  6000115929                               *
* Change Indicator: 6000115929-Jonahs-XNSHDYK                         *
* Description: Interpret Individual lines                              *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026

    DATA: current_sign   TYPE char01,
          current_option TYPE char02,
          total_options  TYPE int4,
          ref_range_lcl  TYPE REF TO data.

    FIELD-SYMBOLS: <range_lcl> TYPE STANDARD TABLE.

    CHECK range IS NOT INITIAL.

    CREATE DATA ref_range_lcl LIKE range.
    ASSIGN ref_range_lcl->* TO <range_lcl>.
    <range_lcl> = range.

*>>>Start of Changes-6000115929-Jonahs-XNSHDYK-21 Oct 2026
    IF add_all_lines = abap_true.
      SORT <range_lcl> BY ('SIGN') ('OPTION') ('LOW') ('HIGH').
      LOOP AT <range_lcl> ASSIGNING FIELD-SYMBOL(<range_line>).

        ASSIGN COMPONENT: 'SIGN' OF STRUCTURE <range_line> TO FIELD-SYMBOL(<sign>),
                          'OPTION' OF STRUCTURE <range_line> TO FIELD-SYMBOL(<option>),
                          'LOW' OF STRUCTURE <range_line> TO FIELD-SYMBOL(<low>),
                          'HIGH' OF STRUCTURE <range_line> TO FIELD-SYMBOL(<high>).

        IF <sign> NE current_sign.
          current_sign = <sign>.
          fmt_string = |{ COND #( WHEN fmt_string IS INITIAL THEN || ELSE |{ fmt_string } | ) }| && "Add a space, if needed
                       |{ COND #( WHEN current_sign EQ 'I' THEN |{ lbl_option_i }| ELSE |{ lbl_option_e }| ) }|.
          CLEAR: current_option,
                 total_options.
        ENDIF.

        IF <option> NE current_option. "First line with a given OPTION (EQ/NE/GT/GE/LT/LE/BT)
          current_option = <option>.
          ADD 1 TO total_options.
          "Between each section add a separator
          "i.e.,
          "Values should be 1 or 5
          "OR <----
          "Between 15-30
          IF total_options GT 1.
            fmt_string = |{ fmt_string } { sec_separator }|.
          ENDIF.

          IF current_option = 'EQ'."Equals
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_eq IS INITIAL THEN | | ELSE | { lbl_sign_eq } | ) }| &&
                         |{ <low> }|.
          ELSEIF current_option = 'NE'.
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_ne IS INITIAL THEN | | ELSE | { lbl_sign_ne } | ) }| &&
                         |{ <low> }|.
          ELSEIF current_option = 'GT'.
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_gt IS INITIAL THEN | | ELSE | { lbl_sign_gt } | ) }| &&
                         |{ <low> }|.
          ELSEIF current_option = 'GE'.
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_ge IS INITIAL THEN | | ELSE | { lbl_sign_ge } | ) }| &&
                         |{ <low> }|.
          ELSEIF current_option = 'LT'.
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_lt IS INITIAL THEN | | ELSE | { lbl_sign_lt } | ) }| &&
                         |{ <low> }|.
          ELSEIF current_option = 'LE'.
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_le IS INITIAL THEN | | ELSE | { lbl_sign_le } | ) }| &&
                         |{ <low> }|.
          ELSEIF current_option = 'BT'.
            fmt_string = |{ fmt_string }| &&
                         |{ COND #( WHEN lbl_sign_bt IS INITIAL THEN | | ELSE | { lbl_sign_bt } | ) }| &&
                         |{ <low> }-{ <high> }|.
          ENDIF.
        ELSE."Subsequent lines with a given OPTION (EQ/NE/GT/GE/LT/LE/BT)
          IF current_option = 'EQ' OR "Equals
             current_option = 'NE' OR
             current_option = 'GT' OR
             current_option = 'GE' OR
             current_option = 'LT' OR
             current_option = 'LE'.
            fmt_string = |{ fmt_string }| &&
                         | { val_separator } { <low> }|.
          ELSEIF current_option = 'BT'.
            fmt_string = |{ fmt_string }| &&
                         | { val_separator } { <low> }-{ <high> }|.
          ENDIF.
        ENDIF.

      ENDLOOP.
    ELSE.
*<<<End of Changes-6000115929-Jonahs-XNSHDYK-21 Oct 2026
      SORT <range_lcl> BY ('LOW') ('HIGH').
      ASSIGN <range_lcl>[ 1 ] TO FIELD-SYMBOL(<first_entry>).
      ASSIGN <range_lcl>[ lines( <range_lcl> ) ] TO FIELD-SYMBOL(<last_entry>).

      ASSIGN COMPONENT 'LOW' OF STRUCTURE <first_entry> TO FIELD-SYMBOL(<start>).
      IF <start> IS INITIAL. "First entry just has High value?
        ASSIGN COMPONENT 'HIGH' OF STRUCTURE <first_entry> TO <start>.
      ENDIF.

      ASSIGN COMPONENT 'HIGH' OF STRUCTURE <first_entry> TO FIELD-SYMBOL(<end>).
      IF <end> IS INITIAL. "Last entry just has Low Value
        ASSIGN COMPONENT 'LOW' OF STRUCTURE <first_entry> TO <end>.
      ENDIF.

      fmt_string = |{ <start> }|.
      IF <end> IS NOT INITIAL.
        fmt_string = |{ fmt_string } To { <end> }|.
      ENDIF.
*>>>Start of Changes-6000115929-Jonahs-XNSHDYK-21 Oct 2026
    ENDIF.

    fmt_string = |{ fmt_string } { unit }|.

*<<<End of Changes-6000115929-Jonahs-XNSHDYK-21 Oct 2026
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CREATE_DIRECTORY_PATH
* +-------------------------------------------------------------------------------------------------+
* | [--->] FULL_PATH                      TYPE        STRING
* | [--->] ON_APPL_SERVER                 TYPE        BOOLE_D (default =ABAP_FALSE)
* | [!CX!] ZCX_STATIC_GENERIC_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CREATE_DIRECTORY_PATH.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Create directory path                                   *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-24 Aug 2026

    DATA: al11_create_status   TYPE extcmdexex-status,
          al11_create_exitcode TYPE extcmdexex-exitcode,
          al11_create_messages TYPE smoi_ws_btcxpm_tt.


    DATA(file_path_partial) = VALUE string( ).
    DATA(dir_create_rc) = VALUE i( ).

    DATA(separator) = get_file_separator( on_appl_server ).

    SPLIT full_path AT separator INTO TABLE DATA(path_parts).

    "MESSAGE |{ full_path }_{ separator }| TYPE 'S'.
    IF on_appl_server = abap_false. "Some Pres. Server Folders will be exempted from checks
      IF check_exempted_folders IS INITIAL.
        "If the given folder is part of the path
        "We will not check any folder leading up to (included) for existence
        check_exempted_folders = VALUE #(
          ( sign = 'I' option = 'CP' low = 'Desktop' )
        ).
      ENDIF.

      "Check if the path contains one of the exempted folders
      LOOP AT path_parts INTO DATA(folder_name)
                         WHERE
                          table_line IN check_exempted_folders.
        EXIT.
      ENDLOOP.
      IF sy-subrc = 0.
        DATA(exempted_folder_exists) = abap_true.
        DATA(exempted_folder_reached) = abap_false.
      ENDIF.
    ENDIF.

    "MESSAGE |Lines{ lines( path_parts ) }| TYPE 'S'.
    LOOP AT path_parts INTO folder_name."For every folder in the directory
      "Construct the Full path, leading up to that folder (Folder inclusive)
      IF file_path_partial IS INITIAL.
        file_path_partial = |{ folder_name }|.
      ELSE.
        file_path_partial = |{ file_path_partial }{ separator }{ folder_name }|.
      ENDIF.
      "MESSAGE 'TEST003' TYPE 'S'.

      "Do not check anything until DESKTOP/Any exempted folder
      IF exempted_folder_exists = abap_true.
        IF exempted_folder_reached = abap_false.
          IF folder_name IN check_exempted_folders.
            exempted_folder_reached = abap_true.
          ENDIF.
          "DATA(skip_existence_check) = abap_true.
          CONTINUE.
        ELSE.
          "skip_existence_check = abap_false.
        ENDIF.
      ENDIF.

      DATA(directory_exists) = check_directory_exists(
        folder_path     = file_path_partial
        on_appl_server  = on_appl_server
      ).
      "MESSAGE 'TEST004' TYPE 'S'.

      IF directory_exists = abap_true."The path exists
        CONTINUE.
      ELSE."The path does not exist
        "Create the folder
        IF on_appl_server = abap_true.
          DATA(file_path_cmd_param) = CONV btcxpgpar( |"{ file_path_partial }"| ).
          CALL FUNCTION 'SXPG_COMMAND_EXECUTE'
            EXPORTING
              commandname                   = ext_cmd_create_dir
              additional_parameters         = file_path_cmd_param
            IMPORTING
              status                        = al11_create_status
              exitcode                      = al11_create_exitcode
            TABLES
              exec_protocol                 = al11_create_messages
            EXCEPTIONS
              no_permission                 = 1
              command_not_found             = 2
              parameters_too_long           = 3
              security_risk                 = 4
              wrong_check_call_interface    = 5
              program_start_error           = 6
              program_termination_error     = 7
              x_error                       = 8
              parameter_expected            = 9
              too_many_parameters           = 10
              illegal_command               = 11
              wrong_asynchronous_parameters = 12
              cant_enq_tbtco_entry          = 13
              jobcount_generation_error     = 14
              OTHERS                        = 15.
          IF sy-subrc <> 0.
            zcx_static_generic_exception=>raise_exception(
            msgid = sy-msgid
            msgno = sy-msgno
            msgv1 = sy-msgv1
            msgv2 = sy-msgv2
            msgv3 = sy-msgv3
            msgv4 = sy-msgv4
            ).
          ENDIF.

          IF sy-batch = abap_true.
            DATA(dummmy_string) = |SPXG: Status{ al11_create_status } ExitCd: { al11_create_exitcode }|.
            IF al11_create_messages IS NOT INITIAL.
              dummmy_string = |{ dummmy_string }_{ al11_create_messages[ 1 ]-message }|.
            ENDIF.
            MESSAGE dummmy_string TYPE 'S'.
          ENDIF.
          "zcx_static_generic_exception=>raise_exception( message_text = dummmy_string ).

        ELSE.
          cl_gui_frontend_services=>directory_create(
          EXPORTING
            directory = file_path_partial
          CHANGING
            rc = dir_create_rc
          EXCEPTIONS
            directory_create_failed = 1
            cntl_error = 2
            error_no_gui = 3
            directory_access_denied = 4
            directory_already_exists = 5
            path_not_found = 6
            unknown_error = 7
            not_supported_by_gui = 8
            wrong_parameter = 9
            ).

          IF sy-subrc <> 0.
            zcx_static_generic_exception=>raise_exception(
            msgid = msgid
            msgno = msgno_dir_create_failed
            ).
          ENDIF.
        ENDIF.
      ENDIF.

    ENDLOOP.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-24 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>CREATE_ITAB_DYNAMIC
* +-------------------------------------------------------------------------------------------------+
* | [--->] TYPE_NAME                      TYPE        ABAP_ABSTYPENAME(optional)
* | [--->] STRUCTURES                     TYPE        FAGL_TABNAME_RANGE(optional)
* | [--->] COMPONENTS                     TYPE        CL_ABAP_STRUCTDESCR=>COMPONENT_TABLE(optional)
* | [--->] ELEMENTARY_COMPONENTS          TYPE        ELEMENTARY_FLD_DESC(optional)
* | [--->] GET_WA                         TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<-()] DATAREF                        TYPE REF TO DATA
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CREATE_ITAB_DYNAMIC.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      3rd Feb 2026                                              *
* Reference Change/Incident:  NNNN                                     *
* Change Indicator: NNNN-Jonahs-XNSHDYK                               *
* Description: Dynamically create an internal table                    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      25th Feb 2026                                             *
* Reference Change/Incident:  5000008261                               *
* Change Indicator: 5000008261-Jonahs-XNSHDYK                         *
* Description: Accept component list containing individual fields as   *
*              input                                                   *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Create internal table using type name, elementary       *
*              component list                                          *
*----------------------------------------------------------------------*

*>>>Start of Changes-NNNN-Jonahs-XNSHDYK-3rd Feb 2026
    DATA: lt_components           TYPE cl_abap_structdescr=>component_table,
          lt_subcomponent_mapping TYPE nested_component_mapping,

          lo_struct_nested        TYPE REF TO cl_abap_structdescr,
          lo_struct_out           TYPE REF TO cl_abap_structdescr,
          lo_struct_out_dataref   TYPE REF TO data.

    FIELD-SYMBOLS: <lfs_struct_out> TYPE any.

*>>>Start of Changes-5000008220-Jonahs-XNSHDYK-25th Feb 2026
    IF components IS SUPPLIED AND
       components IS NOT INITIAL. "If field list is provided, use it
      lt_components = components.
    ELSEIF structures IS SUPPLIED AND
           structures IS NOT INITIAL.
*<<<End of Changes-5000008220-Jonahs-XNSHDYK-25th Feb 2026
      "Construct a table of components
      LOOP AT structures INTO DATA(ls_structures).
        DATA(lv_idx) = sy-tabix.
        lo_struct_nested ?= cl_abap_typedescr=>describe_by_name( ls_structures-low ).
        lt_components = VALUE #( BASE lt_components
          (
            name = |INCL_{ lv_idx }|
            type = lo_struct_nested
            as_include = abap_true
          )
        ).
      ENDLOOP.
*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-22 Jul 2026
    ELSEIF type_name IS NOT INITIAL.
      lo_struct_out ?= cl_abap_typedescr=>describe_by_name( type_name ).
      lt_components = lo_struct_out->get_components( ).
    ELSEIF elementary_components IS NOT INITIAL."If elementary component list is provided
      "Get a RTTS reference of each component and sub component
      DATA(nested_components) = resolve_nested_structures( elementary_components ).
      DATA(added_nested_components) = VALUE stringtab( ).

      LOOP AT elementary_components INTO DATA(element).
        IF element-suffix IS NOT INITIAL."The component is a structure or an internal table.
          "Name of the include structure this element belongs to (If any)
          FIND REGEX zcl_abap_helper=>regex_pattern_itab_stru_name
            IN element-suffix
            SUBMATCHES DATA(parent_structure).

          "If it has already been processed, and added to final structure, no need to re-process
          IF ( line_exists( added_nested_components[ table_line = element-suffix ] ) ) OR "All elements under same structure will have the same suffix
             ( parent_structure IS NOT INITIAL AND
               line_exists( added_nested_components[ table_line = parent_structure ] ) ). "All elements under same include structure
          ELSE.
            "Considering only depth = 1, as further deeper items are already resolved and part of level 1 components
            IF line_exists( nested_components[ suffix = element-suffix depth = 1 ] ).
              DATA(nested_component_info) = nested_components[ suffix = element-suffix depth = 1  ].
              lt_components = VALUE #( BASE lt_components
                (
                  name = nested_component_info-name
                  type = nested_component_info-element_descriptor
                )
              ).
            ENDIF.
            APPEND element-suffix TO added_nested_components."Add this to the list of processed structures
          ENDIF.
        ELSEIF element-as_include = abap_true.
          "If it has already been processed, and added to final structure, no need to re-process
          IF line_exists( added_nested_components[ table_line = element-name ] ).
          ELSE.
            "Considering only depth = 1, as further deeper items are already resolved and part of level 1 components
            IF line_exists( nested_components[ parent = element-string_name depth = 1 ] ).
              nested_component_info = nested_components[ parent = element-string_name depth = 1  ].
              lt_components = VALUE #( BASE lt_components
                (
                  name = space
                  type = nested_component_info-element_descriptor
                  as_include = abap_true
                )
              ).
            ENDIF.
            APPEND element-string_name TO added_nested_components."Add this to the list of processed structures
          ENDIF.
        ELSE.
          lt_components = VALUE #( BASE lt_components
            (
              name = element-name
              type = get_element_descriptor( element )
            )
          ).
        ENDIF.
        CLEAR: parent_structure.
      ENDLOOP.



*<<<End of Changes-5000008297-Jonahs-XNSHDYK-22 Jul 2026
    ENDIF.
    "Construct the structure type which includes the individual structures
    lo_struct_out = cl_abap_structdescr=>create( lt_components ).
    CREATE DATA lo_struct_out_dataref TYPE HANDLE lo_struct_out.
*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-27 Jul 2026
    IF get_wa = abap_true."User requested a work area instead of table
      dataref = lo_struct_out_dataref.
      RETURN.
    ENDIF.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-27 Jul 2026
    ASSIGN lo_struct_out_dataref->* TO <lfs_struct_out>.
    "Construct the table type
    CREATE DATA dataref LIKE TABLE OF <lfs_struct_out>.

*<<<End of Changes-NNNN-Jonahs-XNSHDYK-3rd Feb 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>DISPLAY_PDF_PREVIEW
* +-------------------------------------------------------------------------------------------------+
* | [--->] REPID                          TYPE        SYREPID
* | [--->] DYNNR                          TYPE        SYDYNNR
* | [--->] CONTAINER_NAME                 TYPE        C (default ='REP_CONTAINER')
* | [--->] OTF_DATA                       TYPE        TT_ITCOO(optional)
* | [--->] XSTRING_DATA                   TYPE        XSTRING(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD DISPLAY_PDF_PREVIEW.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Display a PDF as preview in a separate window           *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-15 Oct 2026
    DATA: lv_bin_filesize TYPE i,
          lv_content      TYPE xstring,
          lv_url(255),

          lt_pdf_data     TYPE tline_tty,
          lt_content_bin  TYPE tabtype_solix,

          lo_html_viewer  TYPE REF TO cl_gui_html_viewer.
    IF otf_data IS NOT INITIAL.
      CALL FUNCTION 'CONVERT_OTF'
        EXPORTING
          format                = 'PDF'
*         MAX_LINEWIDTH         = 132
*         ARCHIVE_INDEX         = ' '
*         COPYNUMBER            = 0
*         ASCII_BIDI_VIS2LOG    = ' '
*         PDF_DELETE_OTFTAB     = ' '
*         PDF_USERNAME          = ' '
*         PDF_PREVIEW           = ' '
*         USE_CASCADING         = ' '
*         MODIFIED_PARAM_TABLE  =
        IMPORTING
          bin_filesize          = lv_bin_filesize
          bin_file              = lv_content
        TABLES
          otf                   = otf_data
          lines                 = lt_pdf_data
        EXCEPTIONS
          err_max_linewidth     = 1
          err_format            = 2
          err_conv_not_possible = 3
          err_bad_otf           = 4
          OTHERS                = 5.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    ELSE.
      lv_content = xstring_data.
    ENDIF.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer     = lv_content
      TABLES
        binary_tab = lt_content_bin[].

    IF container_pdf_preview IS BOUND.
      container_pdf_preview->free( ).
    ENDIF.
    cl_gui_cfw=>flush( ).
    container_pdf_preview = NEW #( container_name = container_name repid = repid dynnr = dynnr ).


    lo_html_viewer = NEW #( parent = container_pdf_preview ).

    lo_html_viewer->load_data(
    EXPORTING
      type = 'application'
      subtype = 'pdf'
    IMPORTING
      assigned_url = lv_url
    CHANGING
      data_table = lt_content_bin

    ).

    lo_html_viewer->show_url(
    EXPORTING
      url = lv_url
      in_place = abap_true
    ).
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-15 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>DOWNLOAD_XSTRING_TO_PDF_FILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] XSTRING_CONTENT                TYPE        XSTRING
* | [--->] TO_APPL_SERVER                 TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] FILE_SIZE                      TYPE        I
* | [--->] FILE_FULL_PATH                 TYPE        STRING
* | [--->] SHOW_TRANSFER_STATUS           TYPE        BOOLE_D (default =ABAP_TRUE)
* | [!CX!] ZCX_STATIC_GENERIC_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD DOWNLOAD_XSTRING_TO_PDF_FILE.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Download XSTRING into a PDF file                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-24 Aug 2026
    DATA(binary_content) = VALUE tabtype_solix( ).
    DATA(binary_length)  = VALUE i( ).

    DATA(file_name) = VALUE string( ).
    DATA(file_path) = VALUE string( ).

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = xstring_content
      IMPORTING
        output_length = binary_length
      TABLES
        binary_tab    = binary_content
      EXCEPTIONS
        error_message = 99.


    split_file_and_path(
    EXPORTING
      full_path = file_full_path
      on_appl_server = to_appl_server
    IMPORTING
      folder_path = file_path
      file_name = file_name
    ).

    "Check if the target folder exists
    DATA(directory_exists) = check_directory_exists(
      folder_path = file_path
      on_appl_server = to_appl_server
    ).

    IF directory_exists = abap_true.
    ELSE.
      create_directory_path(
      EXPORTING
        full_path = file_path
        on_appl_server = to_appl_server
        ).
    ENDIF.

    IF to_appl_server = abap_true.
      OPEN DATASET file_full_path FOR OUTPUT IN BINARY MODE.
      IF sy-subrc <> 0.
        zcx_static_generic_exception=>raise_exception(
        msgid = sy-msgid
        msgno = sy-msgno
        msgv1 = sy-msgv1
        msgv2 = sy-msgv2
        msgv3 = sy-msgv3
        msgv4 = sy-msgv4
        ).
      ELSE.
        LOOP AT binary_content INTO DATA(binary_content_line).
          TRANSFER binary_content_line TO file_full_path.
        ENDLOOP.
        CLOSE DATASET file_full_path.
      ENDIF.
    ELSE.
      CALL FUNCTION 'GUI_DOWNLOAD'
        EXPORTING
          bin_filesize            = binary_length
          filename                = file_full_path
          filetype                = 'BIN'
          show_transfer_status    = show_transfer_status
        TABLES
          data_tab                = binary_content
        EXCEPTIONS
          file_write_error        = 1
          no_batch                = 2
          gui_refuse_filetransfer = 3
          invalid_type            = 4
          no_authority            = 5
          unknown_error           = 6
          header_not_allowed      = 7
          separator_not_allowed   = 8
          filesize_not_allowed    = 9
          header_too_long         = 10
          dp_error_create         = 11
          dp_error_send           = 12
          dp_error_write          = 13
          unknown_dp_error        = 14
          access_denied           = 15
          dp_out_of_memory        = 16
          disk_full               = 17
          dp_timeout              = 18
          file_not_found          = 19
          dataprovider_exception  = 20
          control_flush_error     = 21
          error_message           = 99
          OTHERS                  = 22.
      IF sy-subrc <> 0.
        IF sy-subrc <> 0.
          zcx_static_generic_exception=>raise_exception(
          msgid = msgid
          msgno = msgno_fil_dload_failed
          ).
        ENDIF.
      ENDIF.
    ENDIF.

*<<<End of Changes-5000008399-Jonahs-XNSHDYK-24 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>EXPORT_DATA_AND_TYPE_TO_MEMORY
* +-------------------------------------------------------------------------------------------------+
* | [--->] DATA_TABLE                     TYPE        ANY TABLE(optional)
* | [--->] DATA                           TYPE        ANY(optional)
* | [--->] MEMORY_ID                      TYPE        CHAR30
* | [--->] RESOLVE_NESTED_TABLES          TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] RESOLVE_NESTED_STRUCTURES      TYPE        BOOLE_D (default =ABAP_TRUE)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD EXPORT_DATA_AND_TYPE_TO_MEMORY.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Export to a memory id, the given data and its type info *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-22 Jul 2026
    IF data_table IS SUPPLIED.
      "Get the components of the internal table
      "This contains all components as reference of CL_ABAP_ELEMDESCR
      DATA(component_list) = zcl_abap_helper=>construct_component_list(
        it_itab                   = data_table
        resolve_nested_tables     = resolve_nested_tables
        resolve_nested_structures = resolve_nested_structures
      ).

      "We cannot export REFERENCES or any data/table/structure containing references
      "Resolve the references into individual elementary data
      DATA(component_list_elementary) = VALUE elementary_fld_desc(
        FOR component_ref IN component_list
                          INDEX INTO idx
        (
          index       = idx
          string_name = component_ref-name "Will contain full name in case we are using absolute names
          name        = component_ref-name
          type_kind   = component_ref-type->type_kind
          length      = component_ref-type->length "This is byte length
          decimals    = component_ref-type->decimals
          suffix      = component_ref-suffix
          as_include  = component_ref-as_include
        )
      ).


      EXPORT data = data_table[]
             component_list = component_list_elementary "Export the elementary component list
             "type_descriptor_xml = type_descriptor_xml
             TO MEMORY ID memory_id.

    ELSEIF data IS SUPPLIED.
      EXPORT data = data TO MEMORY ID memory_id.

      "<TBD>Get type description of the data
      "<TBD>Export details to memory ID
    ENDIF.



*<<<End of Changes-5000008297-Jonahs-XNSHDYK-22 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>F4HELP_PERIOD
* +-------------------------------------------------------------------------------------------------+
* | [--->] FIELD_TO_UPDATE                TYPE        CHAR04 (default ='LOW')
* | [--->] CALENDAR_VARIANT               TYPE        PERIV (default ='K4')
* | [<-->] PERIODS                        TYPE        RANGE_PERIOD
* | [<-->] PERIOD                         TYPE        LINE_PERIOD
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD F4HELP_PERIOD.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: F4 Help to select a month/year                          *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-23 Jul 2026

    DATA: selected_period TYPE spmon.

    ASSIGN periods[ 1 ] TO FIELD-SYMBOL(<period_line>).
    IF sy-subrc <> 0.
      INSERT INITIAL LINE INTO periods ASSIGNING <period_line>.
    ENDIF.

    ASSIGN COMPONENT field_to_update OF STRUCTURE <period_line> TO FIELD-SYMBOL(<period_value>).
    IF <period_value> IS INITIAL.
      <period_value> = sy-datum+0(6).
    ENDIF.

    CALL FUNCTION 'ZXX_PERIOD_POPUP'
      EXPORTING
        current_sel_period = <period_value>
        calendar_variant   = calendar_variant
      IMPORTING
        selected_period    = selected_period.

    IF selected_period IS NOT INITIAL.
      <period_value> = selected_period.
      period = periods[ 1 ].
    ENDIF.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-23 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>F4_HELP_FILE_PATH
* +-------------------------------------------------------------------------------------------------+
* | [--->] WINDOW_TITLE                   TYPE        STRING(optional)
* | [--->] FILTER                         TYPE        STRING(optional)
* | [--->] EXTENSION                      TYPE        STRING(optional)
* | [--->] FOLDER                         TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] OPEN_MODE                      TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<-()] PATH                           TYPE        LOCALFILE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD F4_HELP_FILE_PATH.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: F4 Help for File Path                                   *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-24 Aug 2026

    DATA: startpath         TYPE string,
          fullpath          TYPE string,
          filename_internal TYPE string,
          user_choice       TYPE int4,
          file_table        TYPE filetable,
          rc                TYPE i.


    cl_gui_frontend_services=>get_desktop_directory(
      CHANGING
        desktop_directory = startpath ).
    cl_gui_cfw=>flush( ).

    IF folder = abap_true.
      cl_gui_frontend_services=>directory_browse(
      EXPORTING
      window_title = window_title
      initial_folder = startpath
      CHANGING
      selected_folder = fullpath
      ).
      path = fullpath.
    ELSE.

      IF filter IS NOT INITIAL.
        DATA(filter_internal) = filter.
      ELSEIF extension IS NOT INITIAL.
        filter_internal = |{ to_upper( extension ) } Files (*.{ extension })\|*.{ extension }|.
      ELSE.
      ENDIF.



*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-15 Oct 2026
      IF open_mode = abap_true.
        CALL METHOD cl_gui_frontend_services=>file_open_dialog
          EXPORTING
            window_title            = window_title
            default_extension       = extension
            default_filename        = filename_internal
            file_filter             = filter_internal
*****WITH_ENCODING
            initial_directory       = startpath
*****MULTISELECTION
          CHANGING
            file_table              = file_table
            rc                      = rc
            user_action             = user_choice
*****            file_encoding           = 1
          EXCEPTIONS
            file_open_dialog_failed = 2
            cntl_error              = 3
            error_no_gui            = 4
            not_supported_by_gui    = 5
            OTHERS                  = 6.
        IF sy-subrc EQ 0 AND
           file_table IS NOT INITIAL.
          fullpath = file_table[ 1 ]-filename.
        ENDIF.
      ELSE.
        "File Save dialog so user can select the Download location
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-15 Oct 2026
        CALL METHOD cl_gui_frontend_services=>file_save_dialog
          EXPORTING
            window_title         = window_title
            default_extension    = extension
            default_file_name    = filename_internal
            initial_directory    = startpath
            file_filter          = filter_internal
          CHANGING
            filename             = filename_internal
            path                 = startpath
            fullpath             = fullpath
            user_action          = user_choice
          EXCEPTIONS
            cntl_error           = 1
            error_no_gui         = 2
            not_supported_by_gui = 3
            OTHERS               = 4.
      ENDIF.
      IF user_choice NE cl_gui_frontend_services=>action_cancel.
        path = fullpath.
      ENDIF.
    ENDIF.

*<<<End of Changes-5000008399-Jonahs-XNSHDYK-24 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>FILL_YEAR_MONTH_DROP_DOWN
* +-------------------------------------------------------------------------------------------------+
* | [--->] T009                           TYPE        T009
* | [--->] T009T                          TYPE        T009T
* | [--->] T009B                          TYPE        FAA_T_T009B
* | [--->] T009C                          TYPE        T009C_ENTRIES
* | [--->] T247                           TYPE        FTPS_WEB_MONTH_T
* | [--->] YEARS                          TYPE        RANGE_YEAR(optional)
* | [<---] MONTHS_DROPDOWN                TYPE        VRM_VALUES
* | [<---] YEARS_DROPDOWN                 TYPE        VRM_VALUES
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD FILL_YEAR_MONTH_DROP_DOWN.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Fill month and year into dropdowns                      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-03 Aug 2026
    IF t009-xkale = abap_true. "This is a regular calendar year
      "Add calendar months to the dropdown
      months_dropdown = VALUE vrm_values(
        FOR t247_line IN t247
        ( key = |{ t247_line-mnr ALPHA = IN WIDTH = 2 }| text = t247_line-ltx )
      ).
    ELSE.
      "Fill in fiscal year values as per configuration
      months_dropdown = VALUE vrm_values(
        FOR t009b_line IN t009b
        ( key = |{ t009b_line-bumon ALPHA = IN WIDTH = 2 }| text = t247[ mnr = t009b_line-poper ]-ltx )
      ).
    ENDIF.

    IF years IS NOT INITIAL.
      years_dropdown = VALUE vrm_values(
        FOR year = years[ 1 ]-low
            UNTIL year GT years[ 1 ]-high
            ( key = year text = year )

      ).
    ELSE.
      years_dropdown = VALUE vrm_values(
        FOR year_001 = sy-datum+0(4) - 50
            UNTIL year_001 GT sy-datum+0(4) + 50
            ( key = year_001 text = year_001 )
      ).
    ENDIF.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-03 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>FISCAL_RANGE_TO_DATE_RANGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] RANGE_YEARS                    TYPE        RANGE_YEAR
* | [<-()] RANGE_DATES                    TYPE        RANGE_DATE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD FISCAL_RANGE_TO_DATE_RANGE.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Convert Range of Fiscal Years to range of dates         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-29 Sep 2026
    DATA: date_range LIKE LINE OF range_dates.

    LOOP AT range_years INTO DATA(year_range).
      CLEAR: date_range.

      date_range-sign = 'I'.
      date_range-option = 'BT'.

      IF year_range-low IS NOT INITIAL.
        get_fiscal_year_date_range(
        EXPORTING
          fiscal_year = year_range-low
        IMPORTING
          date_from = DATA(start_date)
          date_to   = DATA(end_date)
        ).
        date_range-low  = start_date.
        date_range-high = end_date.
      ENDIF.

      IF year_range-high IS NOT INITIAL.
        get_fiscal_year_date_range(
        EXPORTING
          fiscal_year = year_range-high
        IMPORTING
          date_from = start_date
          date_to   = end_date
        ).
        IF date_range-low IS INITIAL. "The Fiscal year LOW was empty, just HIGH was populated
          date_range-low = start_date.
        ENDIF.
        date_range-high = end_date.
      ENDIF.

      APPEND date_range TO range_dates.

    ENDLOOP.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-29 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>GET_ELEMENT_DESCRIPTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] ELEMENTARY_COMPONENT           TYPE        ELEMENTARY_FLD_DESC_LINE
* | [<-()] ELEMENT_DESCRIPTOR             TYPE REF TO CL_ABAP_ELEMDESCR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_ELEMENT_DESCRIPTOR.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Create element description using given elementary info. *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-22 Jul 2026
    "For character fields, the length returned is byte length
    "In unicode system (or any dependent cases) this will be double the actual length we need
    DATA(char_length) = elementary_component-length / cl_abap_char_utilities=>charsize.
    CASE elementary_component-type_kind.

      WHEN cl_abap_elemdescr=>typekind_char."Internal type C.
        element_descriptor = cl_abap_elemdescr=>get_c( p_length = char_length ).
      WHEN cl_abap_elemdescr=>typekind_clike."Internal Type (Data Object).
        element_descriptor = cl_abap_elemdescr=>get_c( p_length = char_length ).
      WHEN cl_abap_elemdescr=>typekind_date."Internal type D.
        element_descriptor = cl_abap_elemdescr=>get_d( ).
      WHEN cl_abap_elemdescr=>typekind_decfloat16."Internal Type a (Decimal Floating Point, 16 Decimal Places).
        element_descriptor = cl_abap_elemdescr=>get_decfloat16( ).
      WHEN cl_abap_elemdescr=>typekind_decfloat34."Internal Type e (Decimal Floating Point, 34 Decimal Places).
        element_descriptor = cl_abap_elemdescr=>get_decfloat34( ).
      WHEN cl_abap_elemdescr=>typekind_float."Internal type F.
        element_descriptor = cl_abap_elemdescr=>get_f( ).
      WHEN cl_abap_elemdescr=>typekind_hex."Internal type X.
        element_descriptor = cl_abap_elemdescr=>get_x( p_length = char_length ).
      WHEN cl_abap_elemdescr=>typekind_int."Internal type I.
        element_descriptor = cl_abap_elemdescr=>get_i( ).
      WHEN cl_abap_elemdescr=>typekind_num."Internal type N.
        element_descriptor = cl_abap_elemdescr=>get_n( p_length = char_length ).
      WHEN cl_abap_elemdescr=>typekind_packed."Internal type P.
        element_descriptor = cl_abap_elemdescr=>get_p(
        p_length = elementary_component-length
        p_decimals = elementary_component-decimals
        ).
      WHEN cl_abap_elemdescr=>typekind_string."Internal type g (character string).
        element_descriptor = cl_abap_elemdescr=>get_string( ).
      WHEN cl_abap_elemdescr=>typekind_time."Internal type T.
        element_descriptor = cl_abap_elemdescr=>get_t( ).
      WHEN cl_abap_elemdescr=>typekind_xstring."Internal type y (byte string).
        element_descriptor = cl_abap_elemdescr=>get_xstring( ).

        "~~~Handler to be developed (If possible)~~~
      WHEN cl_abap_elemdescr=>typekind_class."Internal Type (Class).
      WHEN cl_abap_elemdescr=>typekind_csequence."Internal Type (Data Object).
      WHEN cl_abap_elemdescr=>typekind_data."Internal Type (Data Object).
      WHEN cl_abap_elemdescr=>typekind_decfloat."Internal Type (Generic Decimal Floating Point Type).
      WHEN cl_abap_elemdescr=>typekind_dref."Internal Type l (Data Object Reference).
      WHEN cl_abap_elemdescr=>typekind_int1."Internal Type b (1 Byte Integer).
      WHEN cl_abap_elemdescr=>typekind_int2."Internal Type s (2 Byte Integer).
      WHEN cl_abap_elemdescr=>typekind_intf."Internal Type (Interface).
      WHEN cl_abap_elemdescr=>typekind_iref."Internal Type m (Instance Reference).
      WHEN cl_abap_elemdescr=>typekind_numeric."Internal Type (Data Object).
      WHEN cl_abap_elemdescr=>typekind_oref."Internal type r (object reference).
      WHEN cl_abap_elemdescr=>typekind_simple."Internal Type (Data Object).
      WHEN cl_abap_elemdescr=>typekind_struct1."Internal type u (flat structure).
      WHEN cl_abap_elemdescr=>typekind_struct2."Internal type v (deep structure).
      WHEN cl_abap_elemdescr=>typekind_table."Internal Type h (Internal Table).
      WHEN cl_abap_elemdescr=>typekind_w."Internal type w (wide character).
      WHEN cl_abap_elemdescr=>typekind_xsequence."Internal Type (Data Object).
      WHEN cl_abap_elemdescr=>typekind_bref."Internal Type for Boxed Components/Attributes.
        "~~~Cannot be handled~~~
      WHEN cl_abap_elemdescr=>typekind_any."Internal Type (Data Object or Object).
    ENDCASE.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-22 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>GET_FILE_SEPARATOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] ON_APPL_SERVER                 TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<-()] SEPARATOR                      TYPE        CHAR01
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_FILE_SEPARATOR.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Get the file separator                                  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-04 Sep 2026
    IF on_appl_server = abap_true.
      IF sy-opsys CS 'Windows'.
        separator = '\'.
      ELSE.
        separator = '/'.
      ENDIF.
    ELSE.
      cl_gui_frontend_services=>get_file_separator(
      CHANGING
        file_separator = separator ).
    ENDIF.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-04 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>GET_FISCAL_YEAR_DATE_RANGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] FISCAL_YEAR                    TYPE        GJAHR
* | [--->] FISCAL_YEAR_VARIANT            TYPE        PERIV (default ='V6')
* | [--->] COMPANY_CODE                   TYPE        BUKRS (default ='1000')
* | [<---] DATE_FROM                      TYPE        DATS
* | [<---] DATE_TO                        TYPE        DATS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_FISCAL_YEAR_DATE_RANGE.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Get dates of the fiscal year                            *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-29 Sep 2026
    IF fiscal_year_variant IS SUPPLIED.       "If caller has provided a fiscal year variant
      DATA(calendar_variant) = fiscal_year_variant. "Use it
    ELSE. "
      "Get the fiscal year variant in use for the given/default company code
      SELECT SINGLE periv
             FROM t001
             INTO calendar_variant
             WHERE
              bukrs = company_code.
      IF sy-subrc <> 0."If no fiscal variant mapped to the company code
        calendar_variant = calendar_variant_07_to_06. "Use the variant V6
      ENDIF.
    ENDIF.

    CALL FUNCTION 'FIRST_DAY_IN_PERIOD_GET'
      EXPORTING
        i_gjahr = fiscal_year
        i_periv = fiscal_year_variant
        i_poper = 1
      IMPORTING
        e_date  = date_from.
    IF sy-subrc <> 0.

    ENDIF.

    CALL FUNCTION 'LAST_DAY_IN_PERIOD_GET'
      EXPORTING
        i_gjahr = fiscal_year
        i_periv = fiscal_year_variant
        i_poper = 12
      IMPORTING
        e_date  = date_to.
    IF sy-subrc <> 0.

    ENDIF.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-29 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>GET_PATH_FROM_DIR_ALIAS
* +-------------------------------------------------------------------------------------------------+
* | [--->] ALIAS                          TYPE        STRING
* | [<-()] PATH                           TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_PATH_FROM_DIR_ALIAS.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      25 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Get the folder mapped to a user defined directory name  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-25 Aug 2026
    "Try retrieving from user directories
    SELECT SINGLE dirname
                   FROM user_dir
                   INTO @path
                   WHERE
                    aliass = @alias.
    IF sy-subrc NE 0 OR
       path IS INITIAL.
      "Try retrieving from system parameters
      cl_spfl_profile_parameter=>get_value(
      EXPORTING
        name = alias
      IMPORTING
        value = path
      ).
    ENDIF.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-25 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>GET_PERIOD_MASTER_INFORMATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] CALENDAR_VARIANT               TYPE        PERIV
* | [--->] REFERENCE_DATE                 TYPE        DATS(optional)
* | [<---] T009                           TYPE        T009
* | [<---] T009T                          TYPE        T009T
* | [<---] T009B                          TYPE        FAA_T_T009B
* | [<---] T009C                          TYPE        T009C_ENTRIES
* | [<---] T247                           TYPE        FTPS_WEB_MONTH_T
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_PERIOD_MASTER_INFORMATION.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Get period definition information                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-03 Aug 2026
    DATA: year_range      TYPE RANGE OF char04,
          month_range     TYPE RANGE OF char02,
          day_range       TYPE RANGE OF char02,
          month_range_c03 TYPE RANGE OF char03.

    DATA(year) = reference_date+0(4).
    DATA(month) = reference_date+4(2).
    DATA(day) = reference_date+6(2).

    IF year EQ '0000'.
      year_range = VALUE #(
        ( sign = 'I' option = 'CP' low = '*' )
      ).
    ELSE.
      year_range = VALUE #(
        ( sign = 'I' option = 'EQ' low = year )
      ).
    ENDIF.

    IF month EQ '00'.
      month_range = VALUE #(
        ( sign = 'I' option = 'CP' low = '*' )
      ).
    ELSE.
      month_range = VALUE #(
        ( sign = 'I' option = 'EQ' low = month )
      ).
    ENDIF.

    IF month EQ '00'.
      month_range_c03 = VALUE #(
        ( sign = 'I' option = 'CP' low = '*' )
      ).
    ELSE.
      month_range_c03 = VALUE #(
        ( sign = 'I' option = 'EQ' low = | { month WIDTH = 3 } | )
      ).
    ENDIF.

    IF day EQ '00'.
      day_range = VALUE #(
        ( sign = 'I' option = 'CP' low = '*' )
      ).
    ELSE.
      day_range = VALUE #(
        ( sign = 'I' option = 'EQ' low = day )
      ).
    ENDIF.


    SELECT SINGLE * FROM t009
                    INTO @t009
                    WHERE
                      periv = @calendar_variant.
    IF sy-subrc = 0.
      SELECT SINGLE * FROM t009t
                      INTO @t009t
                      WHERE
                        spras = @sy-langu AND
                        periv = @calendar_variant.

      SELECT * FROM t009b
               INTO TABLE @t009b
               WHERE
                periv = @calendar_variant AND
                bdatj IN @year_range AND
                bumon IN @month_range AND
                butag IN @day_range.

      SELECT * FROM t009c
               INTO TABLE @t009c
               WHERE
                spras = @sy-langu AND
                periv = @calendar_variant AND
                poper IN @month_range_c03 AND
                bdatj IN @year_range.

      SELECT * FROM t247
               INTO TABLE @t247
               WHERE
                spras = @sy-langu.

    ENDIF.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-03 Aug 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>GET_TIME_DIFF_DHMS
* +-------------------------------------------------------------------------------------------------+
* | [--->] START_DATE                     TYPE        DATS
* | [--->] START_TIME                     TYPE        TIMS
* | [--->] END_DATE                       TYPE        DATS
* | [--->] END_TIME                       TYPE        TIMS
* | [<---] DURATION                       TYPE        CALENDAR_DURATION
* | [<---] SECONDS                        TYPE        TZNTSTMPL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_TIME_DIFF_DHMS.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Time difference in Calendar units                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
    "Convert the input date/time to time stamps
    CONVERT DATE start_date TIME start_time
      INTO TIME STAMP DATA(start_ts)
      TIME ZONE sy-zonlo.

    CONVERT DATE end_date TIME end_time
      INTO TIME STAMP DATA(end_ts)
      TIME ZONE sy-zonlo.

    "Get the difference in seconds
    seconds = cl_abap_tstmp=>subtract(
                        tstmp1 = end_ts
                        tstmp2 = start_ts ).

    "Convert S -> D H:M:S
    IF duration IS REQUESTED.
      sec_to_dhms(
      EXPORTING
        seconds = seconds
      IMPORTING
        duration = duration
      ).
    ENDIF.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>IS_BG_MODE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] BG_MODE                        TYPE        BOOLE_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD IS_BG_MODE.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Check if we are in BG mode                              *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-01 Sep 2026

    DATA: bg_task_info TYPE arfctid.

    IF sy-batch = abap_true.
      bg_mode = abap_true.
      RETURN.
    ENDIF.

    CALL FUNCTION 'ID_OF_BACKGROUNDTASK'
      IMPORTING
        tid = bg_task_info.
    IF bg_task_info IS NOT INITIAL.
      bg_mode = abap_true.
      RETURN.
    ENDIF.

    IF cl_gui_frontend_services=>gui_is_running = abap_false.
      bg_mode = abap_true.
      RETURN.
    ENDIF.


*<<<End of Changes-5000008399-Jonahs-XNSHDYK-01 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>MAKE_SING_PLUR_SUFFIX
* +-------------------------------------------------------------------------------------------------+
* | [--->] VALUE                          TYPE        INT4
* | [--->] TEXT                           TYPE        STRING
* | [--->] CONSIDER_ZERO                  TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] SUFFIX_SPACE_IF_NOT_EMPTY      TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<-()] SUFFIXED                       TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD MAKE_SING_PLUR_SUFFIX.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Construct Value + Text +Suffix                          *
*              e.g., 1 Day / 24 Years / 1 Year
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
    IF consider_zero EQ abap_false AND "Do not process if value is 0
       value IS INITIAL. "Value is 0
      RETURN.
    ENDIF.

    suffixed = |{ value } { text }|.

    IF value GT 1.
      suffixed = |{ suffixed }s|.
    ENDIF.

    IF suffix_space_if_not_empty = abap_true AND
       suffixed IS NOT INITIAL.
      suffixed = |{ suffixed } |.
    ENDIF.

*<<<End of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>OBJECT_DESERIALIZER
* +-------------------------------------------------------------------------------------------------+
* | [--->] SERIALIZED                     TYPE        STRING
* | [<-()] OBJECT                         TYPE REF TO OBJECT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD OBJECT_DESERIALIZER.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Convert Object to string                                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-28 Jul 2026
    CALL TRANSFORMATION id
         SOURCE xml = serialized
         RESULT obj = object.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-28 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>OBJECT_SERIALIZER
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT                         TYPE REF TO OBJECT
* | [<-()] SERIALIZED                     TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD OBJECT_SERIALIZER.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Convert Object to string                                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-28 Jul 2026
    CALL TRANSFORMATION id
         SOURCE obj = object
         RESULT xml = serialized.
*<<<End of Changes-5000008297-Jonahs-XNSHDYK-28 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>RESOLVE_NESTED_STRUCTURES
* +-------------------------------------------------------------------------------------------------+
* | [--->] ELEMENTARY_COMPONENTS          TYPE        ELEMENTARY_FLD_DESC
* | [<-()] NESTED_COMPONENT_DESCRIPTORS   TYPE        ELEMENT_LIST_DETAILED
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD RESOLVE_NESTED_STRUCTURES.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  5000008297                               *
* Change Indicator: 5000008297-Jonahs-XNSHDYK                         *
* Description: Dynamically create deep structure                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008297-Jonahs-XNSHDYK-28 Jul 2026
    DATA: nested_comps_for_ref  TYPE cl_abap_structdescr=>component_table,
          nested_element_detail TYPE element_line_detailed,
          nested_components     TYPE element_list_detailed.

    "Find all elements which are part of nested structures
    LOOP AT elementary_components INTO DATA(element)
                                  WHERE
                                    suffix CP zcl_abap_helper=>suffix_pattern_itab OR
                                    suffix CP zcl_abap_helper=>suffix_pattern_stru.
      "Separate the suffixes into an itab
      FIND ALL OCCURRENCES OF REGEX zcl_abap_helper=>regex_metadata_matcher
                              IN element-suffix
                              RESULTS DATA(suffix_position_details).

      "We need to capture more information than available in elementary information itab
      nested_element_detail = CORRESPONDING #( element ).
      LOOP AT suffix_position_details INTO DATA(suffix_position).
        DATA(element_suffix) = substring( val = element-suffix off = suffix_position-offset len = suffix_position-length ).
        nested_element_detail-suffix_hier = VALUE #( BASE nested_element_detail-suffix_hier
          ( element_suffix ) ).
      ENDLOOP.

      "Name of the structure this element belongs to
      "We are doing this based on last entry read in previous loop, this ensures the closest structure in multilevel is populated
      "to this field
      FIND REGEX zcl_abap_helper=>regex_pattern_itab_stru_name
        IN element_suffix
        SUBMATCHES nested_element_detail-parent.

      "Get the parent from the element list
      IF line_exists( elementary_components[ string_name = nested_element_detail-parent ] ).
        DATA(parent) = elementary_components[ string_name = nested_element_detail-parent ].
      ENDIF.
      IF parent-as_include = abap_true.
        nested_element_detail-depth = lines( suffix_position_details )." + 1."How deep is this element (We add 1 as this is in an include)
        nested_element_detail-as_include = abap_true.
      ELSE.
        nested_element_detail-depth = lines( suffix_position_details )."How deep is this element
      ENDIF.
      nested_element_detail-element_descriptor = get_element_descriptor( element ).

      APPEND nested_element_detail TO nested_components.

      CLEAR: parent.
    ENDLOOP.

    DATA(unique_nested_components) = nested_components.
    SORT unique_nested_components BY suffix.
    DELETE ADJACENT DUPLICATES FROM unique_nested_components COMPARING suffix.

    SORT unique_nested_components BY depth DESCENDING suffix ASCENDING.

    "For every unique component, that is part of nested hierarchy
    "We go from the bottom most entries
    "The bottom most entries will always be elementary
    LOOP AT unique_nested_components ASSIGNING FIELD-SYMBOL(<unique_nested_component>).
      CLEAR: nested_comps_for_ref.
      "Find the type of this nested component
      DATA(nested_component_type) = <unique_nested_component>-suffix_hier[ <unique_nested_component>-depth ].
      "Find the name of the nested component
      FIND REGEX zcl_abap_helper=>regex_pattern_itab_stru_name
        IN nested_component_type
        SUBMATCHES DATA(nested_component_name).
      IF nested_component_type CP zcl_abap_helper=>suffix_pattern_itab."We are going through an itab
        DATA(param_get_wa) = abap_false.
      ELSEIF nested_component_type CP zcl_abap_helper=>suffix_pattern_stru."We are going through a WA
        param_get_wa = abap_true.
      ENDIF.

      DATA(suffix_search_pattern) = |{ <unique_nested_component>-suffix }*|.
      "Get all components belonging to this nested component
      "Assumption: nested_components is already sorted in the order in which elements appear
      LOOP AT nested_components INTO DATA(nested_component)
                                WHERE
                                  suffix CP suffix_search_pattern.

        IF nested_component-suffix EQ <unique_nested_component>-suffix. "We are in the direct component (i.e., a field in the structure/itab)
          nested_comps_for_ref = VALUE cl_abap_structdescr=>component_table( BASE nested_comps_for_ref
            (
              name = nested_component-name
              type = nested_component-element_descriptor
            )
          ).
        ELSE."We are in a sub component (i.e., a structure or itab inside itab)
          "Deep component details
          DATA(deep_component) = unique_nested_components[ suffix = nested_component-suffix ].
          FIND REGEX zcl_abap_helper=>regex_pattern_itab_stru_name
            IN deep_component-suffix_hier[ lines( deep_component-suffix_hier ) ]
            SUBMATCHES DATA(deep_component_name).
          "The component is probably part of a sub structure/component
          "It would have been resolved already
          "Get the corresponding element descriptor
          IF line_exists( nested_comps_for_ref[ name = deep_component_name type = deep_component-element_descriptor ] ).
          ELSE.
            nested_comps_for_ref = VALUE cl_abap_structdescr=>component_table( BASE nested_comps_for_ref
              (
                name = deep_component_name
                type = deep_component-element_descriptor
              )
            ).
          ENDIF.
        ENDIF.

      ENDLOOP.

      DATA(structure_descriptor) = cl_abap_structdescr=>create( nested_comps_for_ref ).
      IF param_get_wa = abap_true."The element is a work area
        <unique_nested_component>-element_descriptor = structure_descriptor.
      ELSE."The element is a structure
        <unique_nested_component>-element_descriptor = cl_abap_tabledescr=>create( p_line_type = structure_descriptor ).
      ENDIF.
      <unique_nested_component>-name = nested_component_name.
    ENDLOOP.

    nested_component_descriptors = unique_nested_components.

*<<<End of Changes-5000008297-Jonahs-XNSHDYK-28 Jul 2026

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>SEC_TO_DHMS
* +-------------------------------------------------------------------------------------------------+
* | [--->] SECONDS                        TYPE        TZNTSTMPL
* | [<---] DURATION                       TYPE        CALENDAR_DURATION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SEC_TO_DHMS.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Split Seconds into Days-Hours-Minutes-Seconds           *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
    "Number of Whole days
    duration-days = seconds DIV seconds_in_a_day.

    "Seconds in the remaining day
    DATA(remaining_seconds)     = seconds MOD seconds_in_a_day.

    "Number of whole hours
    duration-hours   = remaining_seconds DIV seconds_in_an_hour.

    "Seconds in the remaining hours
    remaining_seconds            = remaining_seconds MOD seconds_in_an_hour.

    "Number of whole minutes
    duration-minutes = remaining_seconds DIV seconds_in_a_minute.

    "Seconds remaining
    duration-seconds = remaining_seconds MOD seconds_in_a_minute.
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-13 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>SPLIT_FILE_AND_PATH
* +-------------------------------------------------------------------------------------------------+
* | [--->] FULL_PATH                      TYPE        STRING
* | [--->] ON_APPL_SERVER                 TYPE        BOOLE_D
* | [<---] FOLDER_PATH                    TYPE        STRING
* | [<---] FILE_NAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SPLIT_FILE_AND_PATH.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Split the full path into file name and file path        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-07 Sep 2026
    DATA(separator) = get_file_separator( on_appl_server ).

    " 1. Extract the file name (Finds the last segment after the last '/')
    file_name = segment( val = full_path index = -1 sep = separator ).

    " 2. Extract the directory path (Removes the file name from the end)
    folder_path = substring( val = full_path
                             len = strlen( full_path ) - strlen( file_name ) ).

*<<<End of Changes-5000008399-Jonahs-XNSHDYK-07 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>SPLIT_STRING_INTO_N
* +-------------------------------------------------------------------------------------------------+
* | [--->] STRING                         TYPE        STRING
* | [--->] LENGTH                         TYPE        INT4
* | [<-()] SPLIT_STRINGS                  TYPE        STRINGTAB
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD split_string_into_n.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Oct 2026                                               *
* Reference Change/Incident:  6000115929                               *
* Change Indicator: 6000115929-Jonahs-XNSHDYK                         *
* Description: Split a string into N strings                           *
*----------------------------------------------------------------------*

*>>>Start of Changes-6000115929-Jonahs-XNSHDYK-21 Oct 2026
    CHECK string IS NOT INITIAL.

    DATA(string_to_parse) = string.

    DO.
      IF string_to_parse IS INITIAL.
        EXIT.
      ENDIF.

      IF strlen( string_to_parse ) le length.
        APPEND string_to_parse TO split_strings.
        EXIT.
      ELSE.
        DATA(substring) = substring( val = string_to_parse
                                     len = length ).
        string_to_parse = substring( val = string_to_parse
                                     off = length + 1
                                   ).
        APPEND substring TO split_strings.
      ENDIF.

    ENDDO.
*<<<End of Changes-6000115929-Jonahs-XNSHDYK-21 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_006=>TNAPR_PRINT_GET_OTF
* +-------------------------------------------------------------------------------------------------+
* | [--->] NAST                           TYPE        NAST
* | [--->] MEMID                          TYPE        CHAR30
* | [<---] OTF                            TYPE        TT_ITCOO
* | [<---] MESSAGE                        TYPE        WZRE_MESSAGE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD tnapr_print_get_otf.
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  5000008399                               *
* Change Indicator: 5000008399-Jonahs-XNSHDYK                         *
* Description: Print some document pointed by TNAPR and Get the OTF out*
*              Dependency:
*               The print program triggered must return the OTF in     *
*               memory ID OTF_DATA
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: Ange Jonahs jab marijuana (XNSHDYK)                       *
* Date:      21 Oct 2026                                               *
* Reference Change/Incident:  6000115929                               *
* Change Indicator: 6000115929-Jonahs-XNSHDYK                         *
* Description: Altering dependent constant memory ID and using input   *
*              parameter instead                                       *
*----------------------------------------------------------------------*

*>>>Start of Changes-5000008399-Jonahs-XNSHDYK-18 Aug 2026

    DATA(otf_data) = VALUE tt_itcoo( ).

    CALL FUNCTION 'WFMC_MESSAGE_SINGLE'
      EXPORTING
        pi_nast = nast
* IMPORTING
*       PE_RCODE       =
      .

    IMPORT otf_data = otf[]
           FROM MEMORY ID memid."6000115929-Jonahs-XNSHDYK-21 Oct 2026
    IMPORT message = message
           FROM MEMORY ID memid."6000115929-Jonahs-XNSHDYK-21 Oct 2026
*<<<End of Changes-5000008399-Jonahs-XNSHDYK-18 Aug 2026
  ENDMETHOD.
ENDCLASS.
