class ZCL_ABAP_HELPER definition
  public
  create public .

public section.

  constants GC_ALV_JUST_R type LVC_JUST value 'R' ##NO_TEXT.
  constants GC_ALV_JUST_L type LVC_JUST value 'L' ##NO_TEXT.
  constants SAP_CLIENT_PRODUCTION type CCCATEGORY value 'P' ##NO_TEXT.
  constants SAP_CLIENT_TEST type CCCATEGORY value 'T' ##NO_TEXT.
  constants SAP_CLIENT_CUSTOMIZING type CCCATEGORY value 'C' ##NO_TEXT.
  constants SAP_CLIENT_DEMO type CCCATEGORY value 'D' ##NO_TEXT.
  constants SAP_CLIENT_TRAINING_EDUCATION type CCCATEGORY value 'E' ##NO_TEXT.
  constants SAP_CLIENT_SAP_REFERENCE type CCCATEGORY value 'S' ##NO_TEXT.

  class-methods FIND_DOM_VALUES
    importing
      !IV_INPUT type ANY
    returning
      value(RT_DOM_VALUES) type DDFIXVALUES .
  class-methods GET_SAP_USER_NAMES
    importing
      !USER_ID type XUBNAME optional
      !USER_IDS type USMD_T_USER optional
    returning
      value(USER_NAMES) type FDM_T_USER_NAME .
  class-methods GENERATE_HASH
    importing
      !TABLE_DATA type ANY TABLE optional
      !DATA type ANY optional
    returning
      value(HASH) type XSTRING .
  class-methods CONSTRUCT_COMPONENT_LIST
    importing
      !IT_ITAB type ANY TABLE optional
      !IS_STRU type ANY optional
      !IR_DESC_ITAB type ref to CL_ABAP_TABLEDESCR optional
      !IR_DESC_STRU type ref to CL_ABAP_STRUCTDESCR optional
      !RESOLVE_NESTED_TABLES type BOOLE_D default ABAP_TRUE
      !RESOLVE_NESTED_STRUCTURES type BOOLE_D default ABAP_TRUE
    returning
      value(RT_STRU_COMPONENTS) type CL_ABAP_STRUCTDESCR=>COMPONENT_TABLE .
  class-methods GET_SAP_USER_EMAILS
    importing
      !IV_USER_ID type XUBNAME optional
      !IT_USER_IDS type USMD_T_USER optional
    returning
      value(RT_USER_EMAILS) type USMD_T_USER_PROFILE .
  class-methods GET_CLIENT_CATEGORY
    returning
      value(CLIENT_CATEGORY) type CCCATEGORY .
  class-methods IS_PRODUCTION_CLIENT
    returning
      value(IS_PRD_CLIENT) type BOOLE_D .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ABAP_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>CONSTRUCT_COMPONENT_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_ITAB                        TYPE        ANY TABLE(optional)
* | [--->] IS_STRU                        TYPE        ANY(optional)
* | [--->] IR_DESC_ITAB                   TYPE REF TO CL_ABAP_TABLEDESCR(optional)
* | [--->] IR_DESC_STRU                   TYPE REF TO CL_ABAP_STRUCTDESCR(optional)
* | [--->] RESOLVE_NESTED_TABLES          TYPE        BOOLE_D (default =ABAP_TRUE)
* | [--->] RESOLVE_NESTED_STRUCTURES      TYPE        BOOLE_D (default =ABAP_TRUE)
* | [<-()] RT_STRU_COMPONENTS             TYPE        CL_ABAP_STRUCTDESCR=>COMPONENT_TABLE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD construct_component_list.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      3rd Feb 2026                                              *
* Reference Change/Incident:  NNNN                                     *
* Change Indicator: NNNN-MASDIO-MLASD                               *
* Description: Get the list of fields in an internal table             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date: 23 Apr 2026                                                    *
* Reference Change/Incident: BNASDI                                *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Get the list of fields in a structure                   *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Find a way to communicate nested tables                 *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-NNNN-MASDIO-MLASD-4th Feb 2026
    DATA: lt_stru_comp     TYPE cl_abap_structdescr=>component_table,
          lt_stru_comp_001 TYPE cl_abap_structdescr=>component_table,

          lr_desc_itab     TYPE REF TO cl_abap_tabledescr,
          lr_desc_stru     TYPE REF TO cl_abap_structdescr.

    IF it_itab IS SUPPLIED.
      "Get descriptor of the table
      lr_desc_itab ?= cl_abap_typedescr=>describe_by_data( it_itab ).
      "Get the structure descriptor of the table
      lr_desc_stru ?= lr_desc_itab->get_table_line_type( ).
*>>>Start of Changes-BNASDI-MASDIO-MLASD-23 Apr 2026
    ELSEIF is_stru IS SUPPLIED.
      lr_desc_stru ?= cl_abap_typedescr=>describe_by_data( is_stru ).
*<<<End of Changes-BNASDI-MASDIO-MLASD-23 Apr 2026
    ELSEIF ir_desc_itab IS SUPPLIED.
      lr_desc_itab = ir_desc_itab.
      "Get the structure descriptor of the table
      lr_desc_stru ?= lr_desc_itab->get_table_line_type( ).
    ELSEIF ir_desc_stru IS SUPPLIED.
      lr_desc_stru ?= ir_desc_stru.
    ENDIF.

    "Get the list of fields in the structure
    lt_stru_comp = lr_desc_stru->get_components( ).

    "For every field in the structure
    LOOP AT lt_stru_comp INTO DATA(ls_stru_comp).
*****      DATA(lv_component_type) = ls_stru_comp-type->get_relative_name( ).
      DATA(lo_obj_desc) = cl_abap_classdescr=>describe_by_object_ref( ls_stru_comp-type ).
      DATA(lv_component_type) = lo_obj_desc->get_relative_name( ).
      IF lv_component_type EQ 'CL_ABAP_STRUCTDESCR'. "If it is a structure descriptor
        lr_desc_stru  ?= ls_stru_comp-type.
        lt_stru_comp_001 = construct_component_list(
        EXPORTING
        ir_desc_stru = lr_desc_stru
        resolve_nested_tables = resolve_nested_tables
        resolve_nested_structures = resolve_nested_structures
        )."Get the related fields
*>>>Start of Changes-BNASDI-MASDIO-MLASD-27 Jul 2026
        IF resolve_nested_structures = abap_true.
          "Add table fields as is to the output component list
        ELSE.
          IF ls_stru_comp-as_include = abap_true.
            ls_stru_comp-name = ls_stru_comp-type->absolute_name.
            APPEND ls_stru_comp TO rt_stru_components.
          ENDIF.
          "Add a suffix identifying that the field is part of nested table
          LOOP AT lt_stru_comp_001 ASSIGNING FIELD-SYMBOL(<stru_component>).
            <stru_component>-suffix = |<STRU[{ ls_stru_comp-name }]>{ <stru_component>-suffix }|.
          ENDLOOP.
        ENDIF.
*<<<End of Changes-BNASDI-MASDIO-MLASD-27 Jul 2026
        APPEND LINES OF lt_stru_comp_001 TO rt_stru_components.
      ELSEIF lv_component_type EQ 'CL_ABAP_TABLEDESCR'."If it is a table descriptor

        lr_desc_itab  ?= ls_stru_comp-type.
        lt_stru_comp_001 = construct_component_list(
        EXPORTING
        ir_desc_itab = lr_desc_itab
        resolve_nested_tables = resolve_nested_tables
        resolve_nested_structures = resolve_nested_structures )."Get the related fields
*>>>Start of Changes-BNASDI-MASDIO-MLASD-27 Jul 2026
        IF resolve_nested_tables = abap_true.
          "Add table fields as is to the output component list
        ELSE.
          "Add a suffix identifying that the field is part of nested table
          LOOP AT lt_stru_comp_001 ASSIGNING FIELD-SYMBOL(<itab_component>).
            <itab_component>-suffix = |<ITAB[{ ls_stru_comp-name }]>{ <itab_component>-suffix }|.
          ENDLOOP.
        ENDIF.
*<<<End of Changes-BNASDI-MASDIO-MLASD-27 Jul 2026
        APPEND LINES OF lt_stru_comp_001 TO rt_stru_components.
      ELSEIF lv_component_type EQ 'CL_ABAP_ELEMDESCR'."If it is an elementary type
        APPEND ls_stru_comp TO rt_stru_components.
      ENDIF.
    ENDLOOP.

*<<<End of Changes-NNNN-MASDIO-MLASD-4th Feb 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>FIND_DOM_VALUES
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_INPUT                       TYPE        ANY
* | [<-()] RT_DOM_VALUES                  TYPE        DDFIXVALUES
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD FIND_DOM_VALUES.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      18th Sep 2025                                             *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Find Values of Domain linked to a field                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BNASDI-MASDIO-MLASD-5th Nov 2025
    DATA: ls_ddic_field TYPE dfies,

          lo_element    TYPE REF TO cl_abap_elemdescr.

    "Get a type descriptor for the input field
    lo_element ?= cl_abap_typedescr=>describe_by_data( iv_input ).
    "Get the fixed values of related domain
    rt_dom_values = lo_element->get_ddic_fixed_values( sy-langu ).
*<<<End of Changes-BNASDI-MASDIO-MLASD-5th Nov 2025
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>GENERATE_HASH
* +-------------------------------------------------------------------------------------------------+
* | [--->] TABLE_DATA                     TYPE        ANY TABLE(optional)
* | [--->] DATA                           TYPE        ANY(optional)
* | [<-()] HASH                           TYPE        XSTRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD generate_hash.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Generate HASH for given data                            *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BNASDI-MASDIO-MLASD-08 Sep 2026
    DATA: data_xstring TYPE xstring.

    IF table_data IS NOT INITIAL.
      CALL TRANSFORMATION id
      SOURCE table = table_data
      RESULT XML data_xstring.
    ELSEIF data IS NOT INITIAL. "<TBD>
    ENDIF.

    IF data_xstring IS NOT INITIAL.
      cl_abap_message_digest=>calculate_hash_for_raw(
      EXPORTING
        if_algorithm = 'SHA-256'
        if_data      = data_xstring
      IMPORTING
        ef_hashxstring = hash
      ).
    ENDIF.

*<<<End of Changes-BNASDI-MASDIO-MLASD-08 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>GET_CLIENT_CATEGORY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] CLIENT_CATEGORY                TYPE        CCCATEGORY
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_client_category.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Get current SAP client's category                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BNASDI-MASDIO-MLASD-10 Sep 2026
    SELECT SINGLE cccategory
           INTO   client_category
           FROM   t000
           WHERE
            mandt = sy-mandt.
*<<<End of Changes-BNASDI-MASDIO-MLASD-10 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>GET_SAP_USER_EMAILS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_USER_ID                     TYPE        XUBNAME(optional)
* | [--->] IT_USER_IDS                    TYPE        USMD_T_USER(optional)
* | [<-()] RT_USER_EMAILS                 TYPE        USMD_T_USER_PROFILE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_sap_user_emails.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Email IDs related to the specified users                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BNASDI-MASDIO-MLASD-08 Sep 2026
    DATA: lt_user_ids	      TYPE usmd_t_user.

    lt_user_ids = it_user_ids.

    IF iv_user_id IS NOT INITIAL.
      APPEND iv_user_id TO lt_user_ids.
    ENDIF.

    SORT lt_user_ids BY table_line.
    DELETE lt_user_ids WHERE table_line IS INITIAL.
    DELETE ADJACENT DUPLICATES FROM lt_user_ids COMPARING ALL FIELDS.

    IF lt_user_ids[] IS NOT INITIAL.
      SELECT usr21~bname AS user_name, adr6~smtp_addr AS email
             INTO CORRESPONDING FIELDS OF TABLE @rt_user_emails
             FROM usr21 INNER JOIN adr6
                  ON adr6~addrnumber = usr21~addrnumber AND
                     adr6~persnumber = usr21~persnumber
             FOR ALL ENTRIES IN @lt_user_ids
             WHERE
              usr21~bname = @lt_user_ids-table_line.
    ENDIF.

*<<<End of Changes-BNASDI-MASDIO-MLASD-08 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>GET_SAP_USER_NAMES
* +-------------------------------------------------------------------------------------------------+
* | [--->] USER_ID                        TYPE        XUBNAME(optional)
* | [--->] USER_IDS                       TYPE        USMD_T_USER(optional)
* | [<-()] USER_NAMES                     TYPE        FDM_T_USER_NAME
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_sap_user_names.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Get user names from user IDs                            *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BNASDI-MASDIO-MLASD-07 Sep 2026

    DATA: use_method_2   TYPE boole_d,

          user_ids_lcl        TYPE usmd_t_user,
          user_ids_meth2 TYPE usmd_t_user.

    user_ids_lcl = USER_IDS.

    IF USER_ID IS NOT INITIAL.
      APPEND USER_ID TO user_ids_lcl.
    ENDIF.

    SORT user_ids_lcl BY table_line.
    DELETE user_ids_lcl WHERE table_line IS INITIAL.
    DELETE ADJACENT DUPLICATES FROM user_ids_lcl COMPARING ALL FIELDS.

    "Method 1, Retrieve from USR21 & ADRP
    IF user_ids_lcl[] IS NOT INITIAL.
      SELECT  usr21~bname AS username,
              adrp~name_first AS firstname,
              adrp~name_last AS lastname,
              adrp~name_text AS fullname
             INTO TABLE @user_names
             FROM
              usr21 INNER JOIN adrp
              ON
                usr21~persnumber = adrp~persnumber
              FOR ALL ENTRIES IN @user_ids_lcl
              WHERE
                usr21~bname = @user_ids_lcl-table_line.
    ENDIF.

    "Method 2: Retrieve from USER_ADDR is data is not present in first table
    LOOP AT user_ids_lcl INTO DATA(user_id_lcl).
      CLEAR: use_method_2.
      IF line_exists( user_names[ username = user_id_lcl ] ).
        DATA(user_name) = user_names[ username = user_id_lcl ].
        "If the name is empty or if the name is same as the employee number
        "Best get the name from an alternate source, if available
        IF user_name-firstname IS INITIAL AND
           user_name-lastname IS INITIAL AND
          user_name-fullname IS INITIAL.
          use_method_2 = abap_true.
        ENDIF.


        IF ( user_name-firstname = user_id_lcl AND
             ( user_name-lastname IS INITIAL OR
               user_name-lastname = user_id_lcl )
           ).
          use_method_2 = abap_true.
        ENDIF.

        IF ( user_name-lastname = user_id_lcl AND
               ( user_name-firstname IS INITIAL OR
                 user_name-firstname = user_id_lcl )
             ).
          use_method_2 = abap_true.
        ENDIF.
      ELSE. "If there is no entry in USR21 x ADRP,
        use_method_2 = abap_true."Get the name from an alternate source, if available
      ENDIF.
      IF use_method_2 = abap_true.
        APPEND user_id_lcl TO user_ids_meth2.
      ENDIF.
    ENDLOOP.

    IF user_ids_meth2[] IS NOT INITIAL.
      SELECT  bname AS username,
              name_first AS firstname,
              name_last AS lastname,
              name_textc AS fullname
             FROM user_addr
             APPENDING TABLE @user_names
             FOR ALL ENTRIES IN @user_ids_meth2
             WHERE
              bname = @user_ids_meth2-table_line.
    ENDIF.

*<<<End of Changes-BNASDI-MASDIO-MLASD-07 Sep 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER=>IS_PRODUCTION_CLIENT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] IS_PRD_CLIENT                  TYPE        BOOLE_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD is_production_client.
*----------------------------------------------------------------------*
* Developer: AAAAAA (MLASD)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BNASDI                               *
* Change Indicator: BNASDI-MASDIO-MLASD                         *
* Description: Returns TRUE when executed in a client marked as prod.  *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BNASDI-MASDIO-MLASD-10 Sep 2026
    IF get_client_category( ) = sap_client_production.
      is_prd_client = abap_true.
    ELSE.
      is_prd_client = abap_false.
    ENDIF.
*<<<End of Changes-BNASDI-MASDIO-MLASD-10 Sep 2026
  ENDMETHOD.
ENDCLASS.
