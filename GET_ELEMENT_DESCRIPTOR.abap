* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ABAP_HELPER_004=>GET_ELEMENT_DESCRIPTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] ELEMENTARY_COMPONENT           TYPE        ELEMENTARY_FLD_DESC_LINE
* | [<-()] ELEMENT_DESCRIPTOR             TYPE REF TO CL_ABAP_ELEMDESCR
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_element_descriptor.

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
  ENDMETHOD.
