* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_004=>CREATE_ITAB_DYNAMIC
* +-------------------------------------------------------------------------------------------------+
* | [--->] TYPE_NAME                      TYPE        ABAP_ABSTYPENAME(optional)
* | [--->] STRUCTURES                     TYPE        FAGL_TABNAME_RANGE(optional)
* | [--->] COMPONENTS                     TYPE        CL_ABAP_STRUCTDESCR=>COMPONENT_TABLE(optional)
* | [--->] ELEMENTARY_COMPONENTS          TYPE        ELEMENTARY_FLD_DESC(optional)
* | [<-()] TABREF                         TYPE REF TO DATA
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD create_itab_dynamic.
    DATA: lt_components         TYPE cl_abap_structdescr=>component_table,

          lo_struct_nested      TYPE REF TO cl_abap_structdescr,
          lo_struct_out         TYPE REF TO cl_abap_structdescr,
          lo_struct_out_dataref TYPE REF TO data.

    FIELD-SYMBOLS: <lfs_struct_out> TYPE any.

    IF components IS SUPPLIED AND
       components IS NOT INITIAL. "If field list is provided, use it
      lt_components = components.
    ELSEIF structures IS SUPPLIED AND
           structures IS NOT INITIAL.
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
    ELSEIF type_name IS NOT INITIAL.
      lo_struct_out ?= cl_abap_typedescr=>describe_by_name( type_name ).
      lt_components = lo_struct_out->get_components( ).
    ELSEIF elementary_components IS NOT INITIAL."If elementary component list is provided
      "Get a RTTS reference of each component
      lt_components = VALUE #(
        FOR element IN elementary_components
        (
          name = element-name
          type = get_element_descriptor( element )
        )
      ).
    ENDIF.
    "Construct the structure type which includes the individual structures
    lo_struct_out = cl_abap_structdescr=>create( lt_components ).
    CREATE DATA lo_struct_out_dataref TYPE HANDLE lo_struct_out.
    ASSIGN lo_struct_out_dataref->* TO <lfs_struct_out>.
    "Construct the table type
    CREATE DATA tabref LIKE TABLE OF <lfs_struct_out>.


  ENDMETHOD.
