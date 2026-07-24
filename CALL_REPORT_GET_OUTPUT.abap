* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_004=>CALL_REPORT_GET_OUTPUT
* +-------------------------------------------------------------------------------------------------+
* | [--->] REPORT_NAME                    TYPE        PROGRAMM
* | [--->] PARAMETERS                     TYPE        RSPARAMS_TT
* | [--->] MEMORY_ID_REPORT_OUTPUT        TYPE        CHAR30(optional)
* | [--->] SUBMIT_TYPE                    TYPE        NUMC2 (default =SUBMIT_TYPE_REPORT_ALV)
* | [<---] OUTPUT_DATA                    TYPE REF TO DATA
* | [!CX!] CX_SALV_BS_SC_RUNTIME_INFO
* | [!CX!] ZCX_STAT_GEN_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD call_report_get_output.
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
        "r_data = DATA(output_ref)
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
            msgv1  = sy-msgv1
            msgv2  = sy-msgv2
            msgv3  = sy-msgv3
            msgv4  = sy-msgv4.
      ELSE.
        CALL FUNCTION 'LIST_TO_ASCI'
          TABLES
            listasci           = ascii_list
            listobject         = abap_list
          EXCEPTIONS
            empty_list         = 1
            list_index_invalid = 2
            OTHERS             = 3.
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
              msgv1  = sy-msgv1
              msgv2  = sy-msgv2
              msgv3  = sy-msgv3
              msgv4  = sy-msgv4.
        ELSE.
          output_data = REF #( ascii_list ).
        ENDIF.

      ENDIF.

    ELSEIF submit_type = submit_type_report_import.
      "Call the report
      SUBMIT (report_name)
      WITH SELECTION-TABLE parameters[]
      EXPORTING LIST TO MEMORY
      AND RETURN.                                        "#EC CI_SUBMIT

      "Assumption:
      "The report being called has the below call
      "ZCL_ABAP_HELPER_004=>EXPORT_DATA_AND_TYPE_TO_MEMORY( ... ).


      "Get the type of the data
      DATA: component_list TYPE elementary_fld_desc.
      IMPORT component_list = component_list FROM MEMORY ID memory_id_report_output.

      "Create a sample internal table of same type
      output_data = create_itab_dynamic( elementary_components = component_list ).
      ASSIGN output_data->* TO FIELD-SYMBOL(<output_fs>).

      "Import the data into the created internal table
      IMPORT data = <output_fs> FROM MEMORY ID memory_id_report_output.
    ELSE.
    ENDIF.
  ENDMETHOD.
