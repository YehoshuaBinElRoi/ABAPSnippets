class ZCL_ALV_HELPER_004 definition
  public
  create public .

public section.

  types:
    BEGIN OF dd_doc_fmt_paramters,
             sap_style     TYPE sdydo_attribute,
             sap_color     TYPE sdydo_attribute,
             sap_fontsize  TYPE sdydo_attribute,
             sap_fontstyle TYPE sdydo_attribute,
             sap_emphasis  TYPE sdydo_attribute,
             style_class   TYPE sdydo_attribute,
           END OF dd_doc_fmt_paramters .
  types:
    BEGIN OF row_col_pair,
        row TYPE int4,
        col TYPE int4,
      END OF row_col_pair .
  types:
    row_col_pairs TYPE STANDARD TABLE OF row_col_pair
                           WITH DEFAULT KEY .
  types:
    BEGIN OF line_header_fmt_information.
            INCLUDE TYPE row_col_pair.
            INCLUDE TYPE dd_doc_fmt_paramters.
    TYPES: END OF line_header_fmt_information .
  types:
    header_fmt_information TYPE STANDARD TABLE OF line_header_fmt_information
                                  WITH DEFAULT KEY .
  types:
    BEGIN OF alv_tree_tb_button_parameters,
        fcode       TYPE ui_func,
        icon        TYPE iconname,
        is_disabled TYPE boole_d,
        butn_type   TYPE tb_btype,
        text        TYPE text40,
        quickinfo   TYPE iconquick,
        is_checked  TYPE boole_d,
      END OF alv_tree_tb_button_parameters .
  types:
    BEGIN OF alv_tree_set_select_parameters,
        tree_node           TYPE  lvc_nkey,
        tree_node_checked   TYPE  boole_d,
        tree_line_reference TYPE  REF TO data,
        fieldname_selected  TYPE  lvc_fname,
        recursive_set       TYPE boole_d,
      END OF alv_tree_set_select_parameters .
  types:
    BEGIN OF alv_tree_node_upd_parameters.
            INCLUDE TYPE alv_tree_set_select_parameters.
    TYPES: node_layout TYPE lvc_s_lacn,
           END OF  alv_tree_node_upd_parameters .
  types:
    BEGIN OF alv_tree_disp_parameters,
        layout             TYPE lvc_s_layo,
        hierarchy_header   TYPE treev_hhdr,
        excluded_functions TYPE ui_functions,
      END OF alv_tree_disp_parameters .
  types:
    BEGIN OF alv_tree_init_parameters,
        lifetime            TYPE  i,
        container           TYPE char255,
        shellstyle          TYPE  i,
        node_selection_mode TYPE  i,
        hide_selection      TYPE  as4flag,
        item_selection      TYPE  as4flag,
        no_toolbar          TYPE  as4flag,
        no_html_header      TYPE  as4flag,
        i_print             TYPE  as4flag,
        i_fcat_complete     TYPE  abap_bool,
        i_model_mode        TYPE  abap_bool,
      END OF alv_tree_init_parameters .
  types:
    BEGIN OF tree_node_configuration,
        node_layout     TYPE lvc_s_layn,
        item_layout     TYPE lvc_t_layi,
        fieldname       TYPE lvc_fname,
        condition_range TYPE REF TO data,
      END OF tree_node_configuration .
  types:
    tree_node_configurations TYPE STANDARD TABLE OF tree_node_configuration WITH EMPTY KEY .

  class-data GC_GRID_TYPE_TREE type CHAR02 value '06' ##NO_TEXT.
  class-data GRID_TYPE_SPLITTER_HTML_ALV type CHAR02 value '07' ##NO_TEXT.
  data GS_ALV_TRACKER type ZXX_ST_ALV_TRACKER_DATA .
  constants GC_GRID_TYPE_REGULAR type CHAR02 value '00' ##NO_TEXT.
  constants GC_GRID_TYPE_SPLITTER type CHAR02 value '01' ##NO_TEXT.
  constants GC_GRID_TYPE_SPLITTER_ALV type CHAR02 value '02' ##NO_TEXT.
  constants GC_GRID_TYPE_SALV_FULLSCREEN type CHAR02 value '03' ##NO_TEXT.
  constants GC_GRID_TYPE_SALV_CONTAINER type CHAR02 value '04' ##NO_TEXT.
  constants GC_GRID_TYPE_SPLITTER_SALV type CHAR02 value '05' ##NO_TEXT.
  constants GRID_TYPE_SPLITTER_FGBG type CHAR02 value '08' ##NO_TEXT.

  methods INIT_ALV
    importing
      !IV_TYPE type CHAR02 default '00'
      !IV_SASH_POSITION type INT4 optional
      !IV_CONTAINER_NAME type C optional
      !ALV_TREE_INIT_PARAMETERS type ALV_TREE_INIT_PARAMETERS optional
      !AUTO_HANDLE_BATCH type BOOLE_D optional
    changing
      !CT_DATA type ANY TABLE optional .
  methods DISP_ALV
    importing
      !IV_STRUCTURE_NAME type TABNAME optional
      !IV_STRUCTURE_NAME_SUB type TABNAME optional
      !IS_LAYOUT type LVC_S_LAYO optional
      !IS_SUB_LAYOUT type LVC_S_LAYO optional
      !ALV_TREE_DISP_PARAMETERS type ALV_TREE_DISP_PARAMETERS optional
      !HEADER_INFO type ANY TABLE optional
      !HEADER_FMT_INFO type HEADER_FMT_INFORMATION optional
      !HEADER_BORDER_THICKNESS type INT4 default 0
    changing
      !CT_FCAT type LVC_T_FCAT optional
      !CT_DATA type ANY TABLE
      !CT_FCAT_SUB type LVC_T_FCAT optional
      !CT_DATA_SUB type ANY TABLE optional .
  methods REFRESH_ALV
    importing
      !IV_SUB_ALV type BOOLE_D optional
      !IS_LAYO type LVC_S_LAYO optional
      !STABLE type LVC_S_STBL optional
      !SOFT_REFRESH type BOOLE_D optional
      !RETAIN_SELECTION type BOOLE_D optional
      !HEADER_INFO type ANY TABLE optional
      !HEADER_FMT_INFO type HEADER_FMT_INFORMATION optional
      !HEADER_BORDER_THICKNESS type INT4 default 0
    changing
      !CT_FCAT type LVC_T_FCAT optional .
  methods ADD_BUTTON
    importing
      !IV_NAME type SALV_DE_FUNCTION optional
      !IV_ICON type STRING optional
      !IV_TEXT type STRING optional
      !IV_TOOLTIP type STRING optional
      !IV_POSITION type SALV_DE_FUNCTION_POS optional
      !ALV_TREE_TB_BUTTON_PARAMETERS type ALV_TREE_TB_BUTTON_PARAMETERS optional .
  methods PRINT_ALV
    importing
      !PRINT_PARAMETERS type PRI_PARAMS optional
    exporting
      !SPOOL_NUMBER type RSPOID
    changing
      !OUTTAB type ANY TABLE optional .
  methods GET_SELECTED_LINES
    importing
      !SELECTION_FIELD_NAME type LVC_FNAME optional
    exporting
      value(SELECTIONS) type LVC_T_ROID .
  methods SET_SELECTED_LINES
    importing
      !SELECTION_INDICES type LVC_T_ROID optional
      !KEEP_EXISTING_SELECTIONS type BOOLE_D optional
      !SKIP_REFRESH type BOOLE_D default ABAP_FALSE
    changing
      !ALV_TREE_SET_SELECT_PARAMETERS type ALV_TREE_SET_SELECT_PARAMETERS optional .
  methods ADD_TREE_NODES
    importing
      !FIELDNAME_LABEL type LVC_FNAME
      !FIELDNAME_ALV_KEY type LVC_FNAME default 'ALV_KEY'
      !FIELDNAME_PARENT_ID type LVC_FNAME optional
      !FIELDNAME_NODE_ID type LVC_FNAME optional
      !FIELDNAME_SELECTED type LVC_FNAME optional
      !NODE_LAYOUT type LVC_S_LAYN optional
      !ITEM_LAYOUT type LVC_T_LAYI optional
      !TREE_NODE_CONFIGURATIONS type TREE_NODE_CONFIGURATIONS optional
      !SKIP_EMPTY_PARENTS type BOOLE_D default ABAP_FALSE
      !NODE_ADD_CONDITION type STRING optional
      !PARENT_TREE_LINE type ANY optional
    changing
      !TREE_DATA type ANY TABLE optional .
  methods ADD_TREE_NODES_RECURSIVE
    importing
      !FIELDNAME_LABEL type LVC_FNAME
      !FIELDNAME_ALV_KEY type LVC_FNAME default 'ALV_KEY'
      !FIELDNAME_PARENT_ID type LVC_FNAME optional
      !FIELDNAME_NODE_ID type LVC_FNAME optional
      !FIELDNAME_SELECTED type LVC_FNAME optional
      !NODE_LAYOUT type LVC_S_LAYN optional
      !ITEM_LAYOUT type LVC_T_LAYI optional
      !TREE_NODE_CONFIGURATIONS type TREE_NODE_CONFIGURATIONS optional
      !SKIP_EMPTY_PARENTS type BOOLE_D default ABAP_FALSE
      !PARENT_TREE_LINE type ANY optional
    changing
      !FULL_TREE_DATA type ANY TABLE .
  methods REGISTER_EVENTS
    importing
      !EVENT_LIST type CNTL_SIMPLE_EVENTS .
  methods UPDATE_TREE_NODE
    changing
      !ALV_TREE_NODE_UPD_PARAMETERS type ALV_TREE_NODE_UPD_PARAMETERS .
  methods UPDATE_SALV_FCAT
    importing
      !FIELDCAT type LVC_T_FCAT .
protected section.
private section.

  methods PARSE_AND_FILL_HEADER
    importing
      !ALV_TYPE type CHAR02
      !HEADER_INFO type ANY TABLE
      !HEADER_FMT_INFO type HEADER_FMT_INFORMATION
      !REFRESH type BOOLE_D default ABAP_FALSE
      !HEADER_BORDER_THICKNESS type INT4 default 0 .
ENDCLASS.



CLASS ZCL_ALV_HELPER_004 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->ADD_BUTTON
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NAME                        TYPE        SALV_DE_FUNCTION(optional)
* | [--->] IV_ICON                        TYPE        STRING(optional)
* | [--->] IV_TEXT                        TYPE        STRING(optional)
* | [--->] IV_TOOLTIP                     TYPE        STRING(optional)
* | [--->] IV_POSITION                    TYPE        SALV_DE_FUNCTION_POS(optional)
* | [--->] ALV_TREE_TB_BUTTON_PARAMETERS  TYPE        ALV_TREE_TB_BUTTON_PARAMETERS(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD ADD_BUTTON.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Add a button to ALV toolbar                             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Add button to ALV tree                                  *
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-15 Apr 2026

  DATA: lr_functions TYPE REF TO cl_salv_functions_list.

  CHECK sy-batch = abap_false.

  DATA(alv_type) = gs_alv_tracker-alv_type.


  IF alv_type = gc_grid_type_salv_container.
    lr_functions = gs_alv_tracker-salv_table->get_functions( ).

    TRY.
        lr_functions->add_function(
        EXPORTING
          name = iv_name
          icon = iv_icon
          text = iv_text
          tooltip = iv_tooltip
          position = iv_position
        ).
      CATCH cx_root INTO DATA(lo_ex_root)."If any error occurred
        DATA(lv_msg_text) = lo_ex_root->get_text( ).
        MESSAGE lv_msg_text TYPE zcx_stat_gen_exception=>gc_msgty_status.
    ENDTRY.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-08 Jun 2026
  ELSEIF alv_type = gc_grid_type_tree.
    DATA(alv_tree) = gs_alv_tracker-alv_tree.
    DATA(alv_tree_toolbar) = gs_alv_tracker-alv_tree_toolbar.

    IF alv_tree_toolbar IS INITIAL.
      alv_tree->get_toolbar_object(
      IMPORTING
        er_toolbar = alv_tree_toolbar ).
      gs_alv_tracker-alv_tree_toolbar = alv_tree_toolbar.
    ENDIF.

    alv_tree_toolbar->add_button(
    EXPORTING
      fcode       = alv_tree_tb_button_parameters-fcode
      icon        = alv_tree_tb_button_parameters-icon
      is_disabled = alv_tree_tb_button_parameters-is_disabled
      butn_type   = alv_tree_tb_button_parameters-butn_type
      text        = alv_tree_tb_button_parameters-text
      quickinfo   = alv_tree_tb_button_parameters-quickinfo
      is_checked  = alv_tree_tb_button_parameters-is_checked
    ).

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-08 Jun 2026
  ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-15 Apr 2026
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->ADD_TREE_NODES
* +-------------------------------------------------------------------------------------------------+
* | [--->] FIELDNAME_LABEL                TYPE        LVC_FNAME
* | [--->] FIELDNAME_ALV_KEY              TYPE        LVC_FNAME (default ='ALV_KEY')
* | [--->] FIELDNAME_PARENT_ID            TYPE        LVC_FNAME(optional)
* | [--->] FIELDNAME_NODE_ID              TYPE        LVC_FNAME(optional)
* | [--->] FIELDNAME_SELECTED             TYPE        LVC_FNAME(optional)
* | [--->] NODE_LAYOUT                    TYPE        LVC_S_LAYN(optional)
* | [--->] ITEM_LAYOUT                    TYPE        LVC_T_LAYI(optional)
* | [--->] TREE_NODE_CONFIGURATIONS       TYPE        TREE_NODE_CONFIGURATIONS(optional)
* | [--->] SKIP_EMPTY_PARENTS             TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] NODE_ADD_CONDITION             TYPE        STRING(optional)
* | [--->] PARENT_TREE_LINE               TYPE        ANY(optional)
* | [<-->] TREE_DATA                      TYPE        ANY TABLE(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ADD_TREE_NODES.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Add nodes to ALV tree                                   *
*              This works fine if                                      *
*              1. There are no parent-children                         *
*              2. All parents appear before children in sequence       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jun 2026

    DATA: parent_key     TYPE lvc_nkey,
          children_exist TYPE boole_d.
    DATA: determined_node_layout TYPE lvc_s_layn,
          determined_item_layout TYPE lvc_t_layi.


    FIELD-SYMBOLS: <layout_check_range> TYPE STANDARD TABLE.


*****    IF tree_node IS NOT INITIAL.
*****      INSERT tree_node INTO TABLE tree_data.
*****    ENDIF.

    IF node_add_condition IS NOT INITIAL.
      DATA(node_loop_condition) = node_add_condition.
    ELSE.
      node_loop_condition = |{ fieldname_alv_key } CP '*'|.
    ENDIF.

    LOOP AT tree_data ASSIGNING FIELD-SYMBOL(<tree_line>)
                      WHERE (node_loop_condition).
      ASSIGN COMPONENT fieldname_label OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_label>).
      ASSIGN COMPONENT fieldname_alv_key OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_key>).

      "Retrieve parent details if required
      CLEAR: parent_key.
      IF fieldname_parent_id IS NOT INITIAL.
        ASSIGN COMPONENT fieldname_node_id OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_id>).
        ASSIGN COMPONENT fieldname_parent_id OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<parent_id>).
        IF parent_tree_line IS NOT INITIAL.
          ASSIGN COMPONENT fieldname_alv_key OF STRUCTURE parent_tree_line TO FIELD-SYMBOL(<parent_key>).
          IF <parent_key> IS NOT INITIAL.
            parent_key = <parent_key>.
          ENDIF.
        ELSE.
          IF <parent_id> IS NOT INITIAL.
            READ TABLE tree_data ASSIGNING FIELD-SYMBOL(<parent_node>)
                                 WITH KEY
                                  (fieldname_node_id) = <parent_id>.
            IF sy-subrc = 0.
              ASSIGN COMPONENT fieldname_alv_key OF STRUCTURE <parent_node> TO <parent_key>.
              IF <parent_key> IS NOT INITIAL.
                parent_key = <parent_key>.
              ELSE."The parent node is not part of the passed in data
                "<TBD>Add the parent node to the tree FIRST
                "<TBD>Take precautions not to add it again in the loop
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

      "Determine the layout to be used
      CLEAR: determined_node_layout,
             determined_item_layout.
      IF tree_node_configurations IS NOT INITIAL.
        LOOP AT tree_node_configurations ASSIGNING FIELD-SYMBOL(<tree_node_configuration>)."Loop through the checks provided
          ASSIGN COMPONENT <tree_node_configuration>-fieldname OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<check_field>).
          ASSIGN <tree_node_configuration>-condition_range->* TO <layout_check_range> .
          IF <check_field> IN <layout_check_range>."If any checks meet the criteria
            determined_node_layout = <tree_node_configuration>-node_layout.
            determined_item_layout = <tree_node_configuration>-item_layout.

            EXIT.
          ENDIF.
        ENDLOOP.

        IF determined_node_layout IS INITIAL.
          determined_node_layout = node_layout.
          determined_item_layout = item_layout.
        ENDIF.

      ELSE."Use the layout provided in the input
        determined_node_layout = node_layout.
      ENDIF.

      CLEAR: children_exist.
      "DATA(condition_find_children) = |{ fieldname_parent_id } EQ { <node_id> }|.
      IF determined_node_layout-isfolder = abap_true AND "This is a folder
         skip_empty_parents = abap_true. "Do not add parents without children
        READ TABLE tree_data WITH KEY (fieldname_parent_id) = <node_id> TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.
      ENDIF.

      "If the data line is marked as SELECTED, mark the item line as selected
      "If the data line is marked as SELECTED, mark the item line as selected
      IF fieldname_selected IS NOT INITIAL.
        ASSIGN COMPONENT fieldname_selected OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_selected>).
        ASSIGN determined_item_layout[ fieldname = gs_alv_tracker-alv_tree->c_hierarchy_column_name ] TO FIELD-SYMBOL(<item_layout_line>).
        <item_layout_line>-chosen = <node_selected>.
      ENDIF.

      gs_alv_tracker-alv_tree->add_node(
      EXPORTING
        i_relat_node_key = parent_key
        i_relationship   = cl_gui_column_tree=>relat_last_child
        is_outtab_line   = <tree_line>
        is_node_layout   = determined_node_layout
        it_item_layout   = determined_item_layout
        i_node_text      = CONV lvc_value( <node_label> )
      IMPORTING
        e_new_node_key = <node_key>
      ).

      "Set the node key to the actual item on ALV
      gs_alv_tracker-alv_tree->change_item(
        i_node_key = <node_key>
        i_fieldname = 'ALV_KEY'
        i_data = <node_key>
      ).
    ENDLOOP.



    CALL METHOD gs_alv_tracker-alv_tree->frontend_update.

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jun 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->ADD_TREE_NODES_RECURSIVE
* +-------------------------------------------------------------------------------------------------+
* | [--->] FIELDNAME_LABEL                TYPE        LVC_FNAME
* | [--->] FIELDNAME_ALV_KEY              TYPE        LVC_FNAME (default ='ALV_KEY')
* | [--->] FIELDNAME_PARENT_ID            TYPE        LVC_FNAME(optional)
* | [--->] FIELDNAME_NODE_ID              TYPE        LVC_FNAME(optional)
* | [--->] FIELDNAME_SELECTED             TYPE        LVC_FNAME(optional)
* | [--->] NODE_LAYOUT                    TYPE        LVC_S_LAYN(optional)
* | [--->] ITEM_LAYOUT                    TYPE        LVC_T_LAYI(optional)
* | [--->] TREE_NODE_CONFIGURATIONS       TYPE        TREE_NODE_CONFIGURATIONS(optional)
* | [--->] SKIP_EMPTY_PARENTS             TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] PARENT_TREE_LINE               TYPE        ANY(optional)
* | [<-->] FULL_TREE_DATA                 TYPE        ANY TABLE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ADD_TREE_NODES_RECURSIVE.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Add nodes to ALV tree                                   *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jun 2026

    "DATA: parent_key TYPE lvc_nkey.
    DATA: determined_node_layout TYPE lvc_s_layn,
          determined_item_layout TYPE lvc_t_layi,
          parent_key             TYPE lvc_nkey,
          children_exist         TYPE boole_d.


    FIELD-SYMBOLS: <layout_check_range> TYPE STANDARD TABLE,
                   <full_tree_data>     TYPE STANDARD TABLE.

    IF fieldname_parent_id IS NOT INITIAL."There is a parent child relation here
      IF parent_tree_line IS INITIAL."Top-most nodes
        "First Extract just the top-most parents
        "Rest will be filled recursively
        ASSIGN full_tree_data TO <full_tree_data>.

        DATA(loop_condition) = |{ fieldname_parent_id } IS INITIAL|.
      ELSE."Child nodes
        "Extract just the direct children
        ASSIGN COMPONENT fieldname_alv_key OF STRUCTURE parent_tree_line TO FIELD-SYMBOL(<parent_key>).
        IF sy-subrc = 0.
          parent_key = <parent_key>.
        ENDIF.
        ASSIGN full_tree_data TO <full_tree_data>.

        ASSIGN COMPONENT fieldname_node_id OF STRUCTURE parent_tree_line TO FIELD-SYMBOL(<parent_id>).
        loop_condition = |{ fieldname_parent_id } EQ '{ <parent_id> }'|.
      ENDIF.
    ELSE.
      ASSIGN full_tree_data TO <full_tree_data>.
      loop_condition = |{ fieldname_alv_key } CP '*'|.
    ENDIF.

    "~~~FIRST PASS: Add all nodes to the tree~~~
    LOOP AT <full_tree_data> ASSIGNING FIELD-SYMBOL(<tree_line>)
                             WHERE (loop_condition).
      ASSIGN COMPONENT fieldname_label OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_label>).
      ASSIGN COMPONENT fieldname_alv_key OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_key>).
      ASSIGN COMPONENT fieldname_node_id OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_id>).

      "Determine the layout to be used
      CLEAR: determined_node_layout,
             determined_item_layout.
      IF tree_node_configurations IS NOT INITIAL.
        LOOP AT tree_node_configurations ASSIGNING FIELD-SYMBOL(<tree_node_configuration>)."Loop through the checks provided
          ASSIGN COMPONENT <tree_node_configuration>-fieldname OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<check_field>).
          ASSIGN <tree_node_configuration>-condition_range->* TO <layout_check_range> .
          IF <check_field> IN <layout_check_range>."If any checks meet the criteria
            determined_node_layout = <tree_node_configuration>-node_layout.
            determined_item_layout = <tree_node_configuration>-item_layout.
            EXIT.
          ENDIF.
        ENDLOOP.

        IF determined_node_layout IS INITIAL.
          determined_node_layout = node_layout.
          determined_item_layout = item_layout.
        ENDIF.
      ELSE."Use the layout provided in the input
        determined_node_layout = node_layout.
      ENDIF.

      "If the data line is marked as SELECTED, mark the item line as selected
      IF fieldname_selected IS NOT INITIAL.
        ASSIGN COMPONENT fieldname_selected OF STRUCTURE <tree_line> TO FIELD-SYMBOL(<node_selected>).
        ASSIGN determined_item_layout[ fieldname = gs_alv_tracker-alv_tree->c_hierarchy_column_name ] TO FIELD-SYMBOL(<item_layout_line>).
        <item_layout_line>-chosen = <node_selected>.
      ENDIF.

      IF fieldname_parent_id IS INITIAL."There is no parent-child relation here
        "Just Do It
        gs_alv_tracker-alv_tree->add_node(
        EXPORTING
          i_relat_node_key = parent_key
          i_relationship   = cl_gui_column_tree=>relat_last_child
          is_outtab_line   = <tree_line>
          is_node_layout   = determined_node_layout
          it_item_layout   = determined_item_layout
          i_node_text      = CONV lvc_value( <node_label> )
        IMPORTING
          e_new_node_key = <node_key>
        ).
      ELSE.

        CLEAR: children_exist.
        "DATA(condition_find_children) = |{ fieldname_parent_id } EQ { <node_id> }|.
        READ TABLE full_tree_data WITH KEY (fieldname_parent_id) = <node_id> TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          children_exist = abap_true.
        ENDIF.
        IF determined_node_layout-isfolder = abap_true AND "This is a folder
           skip_empty_parents = abap_true AND "Do not add parents without children
           children_exist = abap_false. "There are no children
          CONTINUE.
        ENDIF.


        "Add the node
        gs_alv_tracker-alv_tree->add_node(
        EXPORTING
          i_relat_node_key = parent_key
          i_relationship   = cl_gui_column_tree=>relat_last_child
          is_outtab_line   = <tree_line>
          is_node_layout   = determined_node_layout
          it_item_layout   = determined_item_layout
          i_node_text      = CONV lvc_value( <node_label> )
        IMPORTING
          e_new_node_key = <node_key>
        ).

        "Call method to recursively add immediate children, IF ANY
        IF children_exist = abap_true.
          add_tree_nodes_recursive(
          EXPORTING
            fieldname_label = fieldname_label
            fieldname_alv_key = fieldname_alv_key
            fieldname_parent_id = fieldname_parent_id
            fieldname_node_id = fieldname_node_id
            node_layout = node_layout
            item_layout = item_layout
            tree_node_configurations = tree_node_configurations
            parent_tree_line = <tree_line>
          CHANGING
            full_tree_data = full_tree_data
          ).
        ENDIF.

      ENDIF.

      "Set the node key to the actual item on ALV
      gs_alv_tracker-alv_tree->change_item(
        i_node_key = <node_key>
        i_fieldname = 'ALV_KEY'
        i_data = <node_key>
      ).

    ENDLOOP.

    CALL METHOD gs_alv_tracker-alv_tree->frontend_update.

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jun 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->DISP_ALV
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_STRUCTURE_NAME              TYPE        TABNAME(optional)
* | [--->] IV_STRUCTURE_NAME_SUB          TYPE        TABNAME(optional)
* | [--->] IS_LAYOUT                      TYPE        LVC_S_LAYO(optional)
* | [--->] IS_SUB_LAYOUT                  TYPE        LVC_S_LAYO(optional)
* | [--->] ALV_TREE_DISP_PARAMETERS       TYPE        ALV_TREE_DISP_PARAMETERS(optional)
* | [--->] HEADER_INFO                    TYPE        ANY TABLE(optional)
* | [--->] HEADER_FMT_INFO                TYPE        HEADER_FMT_INFORMATION(optional)
* | [--->] HEADER_BORDER_THICKNESS        TYPE        INT4 (default =0)
* | [<-->] CT_FCAT                        TYPE        LVC_T_FCAT(optional)
* | [<-->] CT_DATA                        TYPE        ANY TABLE
* | [<-->] CT_FCAT_SUB                    TYPE        LVC_T_FCAT(optional)
* | [<-->] CT_DATA_SUB                    TYPE        ANY TABLE(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD disp_alv.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Display the ALV initialized Nth                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Handling of Split ALV in FG & BG mode                   *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-31st Mar 2026
    DATA: "ls_layout      TYPE lvc_s_layo,
      ls_layout_sub  TYPE lvc_s_layo,

      lr_grid        TYPE REF TO cl_gui_alv_grid,
      lr_grid_sub    TYPE REF TO cl_gui_alv_grid,
      lr_grid_salv   TYPE REF TO cl_salv_table,

      lr_dataref     TYPE REF TO data,
      lr_dataref_sub TYPE REF TO data.

    FIELD-SYMBOLS: <lfs_t_data>     TYPE ANY TABLE,
                   <lfs_t_data_sub> TYPE ANY TABLE.



    "ls_layout = is_layout.
    DATA(lv_alv_type) = gs_alv_tracker-alv_type.

    GET REFERENCE OF ct_data INTO lr_dataref.
    gs_alv_tracker-data = lr_dataref.
    ASSIGN lr_dataref->* TO <lfs_t_data>.

    gs_alv_tracker-layout = is_layout.
    gs_alv_tracker-layout_secondary = is_sub_layout.

    IF lv_alv_type = gc_grid_type_regular.
      lr_grid = gs_alv_tracker-alv_grid.
    ELSEIF lv_alv_type = gc_grid_type_salv_fullscreen OR
           lv_alv_type = gc_grid_type_salv_container  OR
           lv_alv_type = gc_grid_type_splitter_salv OR
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
           (
              lv_alv_type = grid_type_splitter_fgbg AND
              sy-batch = abap_true
           ). "Auto handle split ALV in BG mode
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      lr_grid_salv = gs_alv_tracker-salv_table.
    ELSEIF lv_alv_type = gc_grid_type_splitter OR
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
           (
              lv_alv_type = grid_type_splitter_fgbg AND
              sy-batch = abap_false
           ). "Auto handle split ALV in FG mode
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      lr_grid = gs_alv_tracker-alv_grid.
      DATA(lr_dd_document) = gs_alv_tracker-secondary_dd_document.
      DATA(lr_header_container) = gs_alv_tracker-gui_container_top_left.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      IF lv_alv_type = grid_type_splitter_fgbg.
        parse_and_fill_header(
          alv_type = gc_grid_type_splitter
          header_info = header_info
          header_fmt_info = header_fmt_info
          header_border_thickness = header_border_thickness
          ).
      ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      lr_dd_document->display_document(
      EXPORTING
        parent = lr_header_container ).
    ELSEIF lv_alv_type = gc_grid_type_splitter_alv.

      lr_grid = gs_alv_tracker-alv_grid.
      GET REFERENCE OF ct_data_sub INTO lr_dataref_sub.
      gs_alv_tracker-data_secondary = lr_dataref.

      ASSIGN lr_dataref_sub->* TO <lfs_t_data_sub>.

      lr_grid_sub = gs_alv_tracker-alv_grid_secondary.

      lr_grid_sub->set_table_for_first_display(
      EXPORTING
        i_save = 'A'
        i_structure_name = iv_structure_name_sub
        is_layout = is_sub_layout
      CHANGING
        it_fieldcatalog = ct_fcat_sub
        it_outtab = <lfs_t_data_sub>[]
      ).
    ELSEIF lv_alv_type = gc_grid_type_tree.
      DATA(lr_tree) = gs_alv_tracker-alv_tree.
    ENDIF.

    IF lr_grid IS NOT INITIAL.

      lr_grid->set_table_for_first_display(
      EXPORTING
        i_save = 'A'
        i_structure_name = iv_structure_name
        is_layout = is_layout
      CHANGING
        it_fieldcatalog = ct_fcat
        it_outtab = <lfs_t_data>[]
      ).
    ELSEIF lr_grid_salv IS NOT INITIAL.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      IF lv_alv_type = grid_type_splitter_fgbg.
        parse_and_fill_header(
          alv_type = gc_grid_type_splitter_salv
          header_info = header_info
          header_fmt_info = header_fmt_info
          header_border_thickness = header_border_thickness
          ).
      ENDIF.
      IF ct_fcat IS NOT INITIAL.
        update_salv_fcat( ct_fcat ).
      ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      lr_grid_salv->display( ).
    ELSEIF lr_tree IS NOT INITIAL.
      CALL METHOD lr_tree->set_table_for_first_display
        EXPORTING
          is_hierarchy_header  = alv_tree_disp_parameters-hierarchy_header
          it_toolbar_excluding = alv_tree_disp_parameters-excluded_functions
        CHANGING
          it_fieldcatalog      = ct_fcat
          it_outtab            = ct_data. "table must be empty !
    ENDIF.


*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-31st Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->GET_SELECTED_LINES
* +-------------------------------------------------------------------------------------------------+
* | [--->] SELECTION_FIELD_NAME           TYPE        LVC_FNAME(optional)
* | [<---] SELECTIONS                     TYPE        LVC_T_ROID
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_SELECTED_LINES.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Get the lines selected in the ALV                       *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-28 May 2026
    FIELD-SYMBOLS: <alv_data> TYPE ANY TABLE.

    IF selection_field_name IS NOT INITIAL.
      ASSIGN gs_alv_tracker-data->* TO <alv_data>.
      DATA(condition) = |{ selection_field_name } EQ 'X'|.

      LOOP AT <alv_data> TRANSPORTING NO FIELDS WHERE (condition).
        selections = VALUE #( BASE selections
          ( row_id = sy-tabix )
        ).
      ENDLOOP.

    ELSE.
      gs_alv_tracker-alv_grid->get_selected_rows( IMPORTING et_row_no = selections ).
    ENDIF.

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-28 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->INIT_ALV
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_TYPE                        TYPE        CHAR02 (default ='00')
* | [--->] IV_SASH_POSITION               TYPE        INT4(optional)
* | [--->] IV_CONTAINER_NAME              TYPE        C(optional)
* | [--->] ALV_TREE_INIT_PARAMETERS       TYPE        ALV_TREE_INIT_PARAMETERS(optional)
* | [--->] AUTO_HANDLE_BATCH              TYPE        BOOLE_D(optional)
* | [<-->] CT_DATA                        TYPE        ANY TABLE(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD init_alv.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Preparatory steps for displaying an ALV                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: ALV Hierechy TREE generation                            *
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      21 Jul 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Use docking container for BG processing                 *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Auto handle Split ALV in dual mode (BG+FG)              *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-31st Mar 2026
    DATA: lr_dataref           TYPE REF TO data.


    gs_alv_tracker-alv_type = iv_type.


    IF iv_type = gc_grid_type_regular.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-29 Jul 2026
      IF sy-batch = abap_true.
        gs_alv_tracker-alv_grid = NEW cl_gui_alv_grid( i_parent = gs_alv_tracker-docking_container ).
      ELSE.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-29 Jul 2026
        gs_alv_tracker-custom_container = NEW cl_gui_custom_container( container_name = iv_container_name ).
        gs_alv_tracker-alv_grid = NEW cl_gui_alv_grid( i_parent = gs_alv_tracker-custom_container ).
      ENDIF.
    ELSEIF iv_type = gc_grid_type_salv_fullscreen OR
       iv_type = gc_grid_type_salv_container OR
       iv_type = gc_grid_type_splitter_salv OR
       iv_type = grid_type_splitter_html_alv OR
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
       (
         iv_type = grid_type_splitter_fgbg AND
         sy-batch = abap_true
       ). "Split ALV in BG mode will use SALV
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026

      IF iv_type = gc_grid_type_salv_container.
        gs_alv_tracker-custom_container = NEW cl_gui_custom_container( container_name = iv_container_name ).
      ENDIF.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
      IF iv_container_name IS NOT INITIAL AND
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
         iv_type NE grid_type_splitter_fgbg."INSERTED-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
        cl_salv_table=>factory(
        EXPORTING
          r_container = gs_alv_tracker-custom_container
          container_name = |{ iv_container_name }|
        IMPORTING
          r_salv_table = DATA(lr_salv_table)
        CHANGING
          t_table = ct_data
        ).
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
      ELSE.
        cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lr_salv_table
        CHANGING
          t_table = ct_data
        ).
      ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
      gs_alv_tracker-salv_table = lr_salv_table.

      IF iv_type = gc_grid_type_splitter_salv OR
         iv_type = grid_type_splitter_fgbg. "INSERTED-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
        gs_alv_tracker-secondary_salv_form = NEW cl_salv_form_layout_grid( ).
        IF sy-batch = abap_false.
          lr_salv_table->set_top_of_list( gs_alv_tracker-secondary_salv_form ).
        ELSE.
          lr_salv_table->set_top_of_list_print( gs_alv_tracker-secondary_salv_form ).
        ENDIF.
      ENDIF.

    ELSEIF iv_type = gc_grid_type_splitter OR
       iv_type = gc_grid_type_splitter_alv OR
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
       (
        iv_type = grid_type_splitter_fgbg AND
        sy-batch = abap_false
       ). "Split ALV in FG mode should use ALV + DD Document
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      "~~~~Base Structures Preparation~~~~
      "~~~~To hold the individual sub-reports~~~~
      IF sy-batch = abap_false.
        gs_alv_tracker-custom_container = NEW cl_gui_custom_container( container_name = iv_container_name ).
        gs_alv_tracker-easy_splitter_container = NEW cl_gui_easy_splitter_container( parent = gs_alv_tracker-custom_container sash_position = iv_sash_position ).

        gs_alv_tracker-gui_container_top_left = gs_alv_tracker-easy_splitter_container->top_left_container.
        gs_alv_tracker-gui_container_bot_right = gs_alv_tracker-easy_splitter_container->bottom_right_container.

        gs_alv_tracker-alv_grid = NEW cl_gui_alv_grid( i_parent = gs_alv_tracker-gui_container_bot_right ).
        "Preparations related to the sub report/sub ALV/header...
        IF iv_type = gc_grid_type_splitter or
           iv_type = grid_type_splitter_fgbg.
          "Initialize the header of the ALV
          gs_alv_tracker-secondary_dd_document = NEW cl_dd_document( style = 'ALV_GRID' ).
        ELSEIF iv_type = gc_grid_type_splitter_alv.
          gs_alv_tracker-alv_grid_secondary = NEW cl_gui_alv_grid( i_parent = gs_alv_tracker-gui_container_top_left ).
        ENDIF.
      ENDIF.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jun 2026
    ELSEIF iv_type = gc_grid_type_tree.
      gs_alv_tracker-custom_container = NEW cl_gui_custom_container( container_name = alv_tree_init_parameters-container ).
      gs_alv_tracker-alv_tree = NEW #(
      parent = gs_alv_tracker-custom_container
      no_html_header = alv_tree_init_parameters-no_html_header
      item_selection = alv_tree_init_parameters-item_selection ).
    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jun 2026

    gs_alv_tracker-data = lr_dataref."Add an empty reference to the output table
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-31st Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_ALV_HELPER_004->PARSE_AND_FILL_HEADER
* +-------------------------------------------------------------------------------------------------+
* | [--->] ALV_TYPE                       TYPE        CHAR02
* | [--->] HEADER_INFO                    TYPE        ANY TABLE
* | [--->] HEADER_FMT_INFO                TYPE        HEADER_FMT_INFORMATION
* | [--->] REFRESH                        TYPE        BOOLE_D (default =ABAP_FALSE)
* | [--->] HEADER_BORDER_THICKNESS        TYPE        INT4 (default =0)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD parse_and_fill_header.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Populate SALV/DD Doc header                             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
    DATA: rows_to_check TYPE RANGE OF int4,
          cols_to_check TYPE RANGE OF int4.

    "CReate place holder row and col numbers
    "We will later update the correct row and col numbers to cross check in BOLD/FORMAT information
    rows_to_check = VALUE #(
      ( sign = 'I' option = 'EQ' low = 0 )
      ( sign = 'I' option = 'EQ' low = 0 )
    ).

    cols_to_check = VALUE #(
      ( sign = 'I' option = 'EQ' low = 0 )
      ( sign = 'I' option = 'EQ' low = 0 )
    ).

    ASSIGN rows_to_check[ 2 ] TO FIELD-SYMBOL(<row_to_check>).
    ASSIGN cols_to_check[ 2 ] TO FIELD-SYMBOL(<col_to_check>).

    " 1. Get the type description of the generic table
    DATA(table_descr) = CAST cl_abap_tabledescr( cl_abap_typedescr=>describe_by_data( header_info ) ).

    " 2. Get the line type (structure) of the table
    DATA(struct_descr) = CAST cl_abap_structdescr( table_descr->get_table_line_type( ) ).

    " 3. Retrieve the components (columns)
    DATA(columns) = struct_descr->get_components( ).

    IF alv_type = gc_grid_type_splitter_salv.
      DATA(salv_header) = gs_alv_tracker-secondary_salv_form.
      salv_header->set_column_count( lines( columns ) + 2 ).
    ELSEIF alv_type = gc_grid_type_splitter.
      DATA(split_alv_header) = gs_alv_tracker-secondary_dd_document.
      IF refresh = abap_true.
        split_alv_header->initialize_document( ).
      ENDIF.
      split_alv_header->add_table(
      EXPORTING
        no_of_columns = lines( columns )
        border        = CONV sdydo_value( |{ header_border_thickness }| )
      IMPORTING
        table     = DATA(split_alv_hdr_tbl)
        tablearea = DATA(split_alv_hdr_area)
      ).
    ENDIF.

    " 4. Loop through to read the column details
    LOOP AT header_info ASSIGNING FIELD-SYMBOL(<header_line>).
      <row_to_check>-low = sy-tabix."Position of Row

      IF alv_type = gc_grid_type_splitter.
        split_alv_hdr_area->new_row( ).
      ENDIF.

      LOOP AT columns INTO DATA(column).
        <col_to_check>-low = sy-tabix."Position of Column

        ASSIGN COMPONENT column-name OF STRUCTURE <header_line> TO FIELD-SYMBOL(<col_value>).

        "Check if the given Line and Column needs to be formatted
        "If there is formatting info, specific to the cell
        ASSIGN header_fmt_info[ row = <row_to_check>-low col = <col_to_check>-low ]
               TO FIELD-SYMBOL(<fmt_info>).
        IF sy-subrc NE 0.
          "If there is formatting info, specific to the row
          ASSIGN header_fmt_info[ row = <row_to_check>-low col = 0 ]
                 TO <fmt_info>.
          IF sy-subrc NE 0.
            "If there is formatting info, specific to the column
            ASSIGN header_fmt_info[ row = 0 col = <col_to_check>-low ]
                   TO <fmt_info>.
            IF sy-subrc NE 0.
              LOOP AT header_fmt_info ASSIGNING <fmt_info>
                                         WHERE
                                         row IN rows_to_check AND
                                         col IN cols_to_check.
                EXIT.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDIF.
        IF <fmt_info> IS ASSIGNED."This needs to be formatted specifically
          IF alv_type = gc_grid_type_splitter_salv.
            IF <row_to_check>-low = 1.
              salv_header->create_header_information(
              row     = <row_to_check>-low
              column  = <col_to_check>-low
              colspan = 1
              text    = |{ <col_value> ALPHA = OUT }|
              ).
            ELSE.
              salv_header->create_label(
              row = <row_to_check>-low
              column = <col_to_check>-low
              colspan = 1 )->set_text( |{ <col_value> ALPHA = OUT }| ).
            ENDIF.
          ELSEIF alv_type = gc_grid_type_splitter.
            split_alv_hdr_area->add_text(
              text = |{ <col_value> }|
              sap_style     = <fmt_info>-sap_style
              sap_color     = <fmt_info>-sap_color
              sap_fontsize  = <fmt_info>-sap_fontsize
              sap_fontstyle = <fmt_info>-sap_fontstyle
              sap_emphasis  = <fmt_info>-sap_emphasis
              style_class  = <fmt_info>-style_class
            ).
          ENDIF.
          UNASSIGN <fmt_info>.
        ELSE."This need not be in bold
          IF alv_type = gc_grid_type_splitter_salv.
            salv_header->create_text(
            row     = <row_to_check>-low
            column  = <col_to_check>-low
            colspan = 1
            text    = |{ <col_value> ALPHA = OUT }|
            ).

          ELSEIF alv_type = gc_grid_type_splitter.
            split_alv_hdr_area->add_text(
              text = |{ <col_value> }|
            ).
          ENDIF.
        ENDIF.

      ENDLOOP.
    ENDLOOP.
    IF alv_type = gc_grid_type_splitter_salv.
      IF header_border_thickness IS NOT INITIAL.
        "Add two lines and two columns after the bounds
        "So the border is extended
        salv_header->create_text(
        row     = <row_to_check>-low + 2
        column  = lines( columns ) + 2
        colspan = 1
        text    = space
        ).
        salv_header->set_grid_lines( if_salv_form_c_grid_lines=>grid_lines ).
      ENDIF.
    ELSEIF alv_type = gc_grid_type_splitter.
      split_alv_hdr_area->new_row( ). "To ensure the last row is ADDED. huh!?
      split_alv_header->merge_document( ).
    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->PRINT_ALV
* +-------------------------------------------------------------------------------------------------+
* | [--->] PRINT_PARAMETERS               TYPE        PRI_PARAMS(optional)
* | [<---] SPOOL_NUMBER                   TYPE        RSPOID
* | [<-->] OUTTAB                         TYPE        ANY TABLE(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD PRINT_ALV.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Print out an ALV                                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      26 Jun 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Print the ALV displayed                                 *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-15 Apr 2026
    DATA: lv_valid        TYPE boole_d,

          ls_print_params TYPE pri_params,

          alv_grid        TYPE REF TO cl_gui_alv_grid,
          dataref         TYPE REF TO data.

    "lt_pdf          TYPE tabtype_tline.

    FIELD-SYMBOLS:  <lfs_t_data>    TYPE ANY TABLE.
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026

    IF gs_alv_tracker IS NOT INITIAL. "Entire process was done using this same class
      DATA(alv_type) = gs_alv_tracker-alv_type.
*****      IF outtab IS NOT INITIAL.
*****        GET REFERENCE OF outtab INTO dataref.
*****        gs_alv_tracker-data = dataref.
*****        ASSIGN dataref->* TO <lfs_t_data>.
*****      ELSE.
*****        ASSIGN gs_alv_tracker-data->* TO <lfs_t_data>.
*****      ENDIF.
*****
*****      DATA(salv_table) = gs_alv_tracker-salv_table.
*****      cl_salv_table=>factory(
*****      IMPORTING
*****        r_salv_table = DATA(lr_salv_table)
*****      CHANGING
*****        t_table = <lfs_t_data>[]
*****      ).
*****      DATA(lv_color_colm_src) = gs_alv_tracker-salv_table->get_columns( )->get_color_column( )."COMMENTING-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
*****      lr_salv_table->get_columns( )->set_color_column( lv_color_colm_src ).
      IF alv_type = gc_grid_type_salv_fullscreen OR
             alv_type = gc_grid_type_salv_container OR
             alv_type = gc_grid_type_splitter_salv.
        DATA(lr_salv_table) = gs_alv_tracker-salv_table.

      ENDIF.
    ELSE. "User just wants to Print some ALV displayed using some other means
      IF outtab IS NOT INITIAL.
        CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
          IMPORTING
            e_grid = alv_grid.
        ASSIGN outtab TO <lfs_t_data>.

        cl_salv_table=>factory(
        EXPORTING
          r_container = alv_grid->parent
          container_name = 'REUSE_CONTAINER'
        IMPORTING
          r_salv_table = lr_salv_table
        CHANGING
          t_table = <lfs_t_data>[]
        ).
      ELSE.
        RETURN.
      ENDIF.
    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026


*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
*****      ls_print_params-prtxt = |Payroll Variance Report_{ sy-datum }_{ sy-uzeit }|.
*****
*****      ls_print_params-pdest = 'ZPDF'.".'LOCAL'. " Use a valid printer name from SPAD
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-01 Jul 2026
    IF print_parameters IS NOT INITIAL."User overrides, if specified
      "ls_print_params-prtxt = print_parameters-prtxt.
      "ls_print_params-pdest = print_parameters-pdest.
      ls_print_params = print_parameters.
    ELSE.
      CALL FUNCTION 'GET_PRINT_PARAMETERS'
        EXPORTING
          no_dialog              = abap_true
        IMPORTING
          out_parameters         = ls_print_params
          valid                  = lv_valid
        EXCEPTIONS
          archive_info_not_found = 1
          invalid_print_params   = 2
          invalid_archive_params = 3
          OTHERS                 = 4.
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.
    ENDIF.
    ls_print_params-primm = abap_false.

    DATA(ref_print) = lr_salv_table->get_print( ).
    DATA(ls_print_control) = ref_print->get_print_control( ).
    ls_print_control-pri_params = ls_print_params.

    ref_print->set_print_control( ls_print_control ).
    ref_print->set_print_only( abap_true ).

    lr_salv_table->display( ).

    spool_number = sy-spono."Spool generated directly from the ALV
*****      cl_salv_bs_runtime_info=>clear_all( ).

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-15 Apr 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->REFRESH_ALV
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_SUB_ALV                     TYPE        BOOLE_D(optional)
* | [--->] IS_LAYO                        TYPE        LVC_S_LAYO(optional)
* | [--->] STABLE                         TYPE        LVC_S_STBL(optional)
* | [--->] SOFT_REFRESH                   TYPE        BOOLE_D(optional)
* | [--->] RETAIN_SELECTION               TYPE        BOOLE_D(optional)
* | [--->] HEADER_INFO                    TYPE        ANY TABLE(optional)
* | [--->] HEADER_FMT_INFO                TYPE        HEADER_FMT_INFORMATION(optional)
* | [--->] HEADER_BORDER_THICKNESS        TYPE        INT4 (default =0)
* | [<-->] CT_FCAT                        TYPE        LVC_T_FCAT(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD refresh_alv.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      18th Mar 2026                                             *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Display the ALV initialized Nth                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Allow Stable refresh of ALV grid                        *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Refresh header DD content                               *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-31st Mar 2026
    DATA(alv_type) = gs_alv_tracker-alv_type.

    IF alv_type = gc_grid_type_tree.
      DATA(alv_tree) = gs_alv_tracker-alv_tree.
      alv_tree->frontend_update( ).
    ELSE.
      IF iv_sub_alv IS INITIAL.
        DATA(lr_grid) = gs_alv_tracker-alv_grid.
      ELSE.
        lr_grid = gs_alv_tracker-alv_grid_secondary.
      ENDIF.

      CHECK lr_grid IS NOT INITIAL.

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026
      IF alv_type = grid_type_splitter_fgbg AND
         sy-batch = abap_false AND
         header_info IS NOT INITIAL.
        DATA(dd_document) = gs_alv_tracker-secondary_dd_document.
        DATA(header_container) = gs_alv_tracker-gui_container_top_left.
        parse_and_fill_header(
          alv_type           = gc_grid_type_splitter
          header_info        = header_info
          header_fmt_info = header_fmt_info
          header_border_thickness = header_border_thickness
          refresh = abap_true
          ).
        dd_document->display_document(
        EXPORTING
          reuse_control = abap_true
          parent = header_container ).
      ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-12 Oct 2026

      IF ct_fcat IS SUPPLIED.
        lr_grid->set_frontend_fieldcatalog(
        EXPORTING
          it_fieldcatalog = ct_fcat ).
      ENDIF.

      IF is_layo IS SUPPLIED.
        lr_grid->set_frontend_layout(
        EXPORTING
          is_layout = is_layo
        ).
      ENDIF.

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-07 Sep 2026
      IF retain_selection = abap_true.
        lr_grid->get_selected_rows( IMPORTING et_row_no = DATA(selections) ).
      ENDIF.

      IF stable-row = abap_true OR
         stable-col = abap_true.
        lr_grid->get_scroll_info_via_id(
        IMPORTING
          es_row_no = DATA(row_no)
          es_row_info = DATA(row_info)
          es_col_info = DATA(col_info)
          ).
      ENDIF.

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-07 Sep 2026

      lr_grid->refresh_table_display(
        i_soft_refresh = soft_refresh "JASDUONAS-AAAAA-AJSIDMG-07 Sep 2026
      ).

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-07 Sep 2026
      IF retain_selection = abap_true.
        lr_grid->set_selected_rows( EXPORTING it_row_no = selections ).
      ENDIF.

      IF stable-row = abap_true OR
         stable-col = abap_true.
        lr_grid->set_scroll_info_via_id(
        EXPORTING
          is_row_no   = row_no
          is_row_info = row_info
          is_col_info = col_info
        ).
      ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-07 Sep 2026
    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-31st Mar 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->REGISTER_EVENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] EVENT_LIST                     TYPE        CNTL_SIMPLE_EVENTS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD REGISTER_EVENTS.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Register ALV related events                             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-04 Jun 2026
    DATA(lv_alv_type) = gs_alv_tracker-alv_type.

    IF lv_alv_type = gc_grid_type_tree.
      DATA(alv_tree) = gs_alv_tracker-alv_tree.
      alv_tree->get_registered_events(
      IMPORTING
        events = DATA(event_list_lcl)
        ).
      APPEND LINES OF event_list TO event_list_lcl.

      alv_tree->set_registered_events( event_list_lcl ).
    ELSE.
    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-04 Jun 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->SET_SELECTED_LINES
* +-------------------------------------------------------------------------------------------------+
* | [--->] SELECTION_INDICES              TYPE        LVC_T_ROID(optional)
* | [--->] KEEP_EXISTING_SELECTIONS       TYPE        BOOLE_D(optional)
* | [--->] SKIP_REFRESH                   TYPE        BOOLE_D (default =ABAP_FALSE)
* | [<-->] ALV_TREE_SET_SELECT_PARAMETERS TYPE        ALV_TREE_SET_SELECT_PARAMETERS(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_SELECTED_LINES.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: HUB Method: Usage Statistics Report                     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Set selected lines of trees                             *
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-29 May 2026

    FIELD-SYMBOLS: <outtab_line> TYPE any.
    DATA(lv_alv_type) = gs_alv_tracker-alv_type.

    IF lv_alv_type = gc_grid_type_tree.
      DATA(alv_tree) = gs_alv_tracker-alv_tree.
      IF alv_tree_set_select_parameters-tree_node IS NOT INITIAL.

        DATA(selection_configurations) = VALUE lvc_t_laci(
          (
          fieldname = cl_alv_tree_base=>c_hierarchy_column_name
          chosen = alv_tree_set_select_parameters-tree_node_checked
          u_chosen = abap_true "Means - Update the Chosen flag
          )
        ).


        ASSIGN alv_tree_set_select_parameters-tree_line_reference->* TO <outtab_line>.

        alv_tree->get_outtab_line(
        EXPORTING
          i_node_key = alv_tree_set_select_parameters-tree_node
        IMPORTING
          e_outtab_line = <outtab_line>
        ).

        alv_tree->change_node(
          i_node_key = alv_tree_set_select_parameters-tree_node
          i_outtab_line = <outtab_line>
          it_item_layout =  selection_configurations
        ).

        IF alv_tree_set_select_parameters-recursive_set = abap_true."If we are requested to set this recursively

          alv_tree->get_children(
          EXPORTING
            i_node_key = alv_tree_set_select_parameters-tree_node
          IMPORTING
            et_children = DATA(children)
          ).

          LOOP AT children INTO DATA(child_node_key)."For each available child
            DATA(child_tree_set_parameters) = alv_tree_set_select_parameters.
            child_tree_set_parameters-tree_node = child_node_key.
            set_selected_lines(
            CHANGING
              alv_tree_set_select_parameters = child_tree_set_parameters
            )."Call the method to recursively set/unset child lines
          ENDLOOP.
        ENDIF.

      ENDIF.
      IF skip_refresh = abap_false.
        CALL METHOD alv_tree->frontend_update.
      ENDIF.

    ELSE.
      gs_alv_tracker-alv_grid->set_selected_rows( it_row_no = selection_indices is_keep_other_selections = keep_existing_selections ).
    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-29 May 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->UPDATE_SALV_FCAT
* +-------------------------------------------------------------------------------------------------+
* | [--->] FIELDCAT                       TYPE        LVC_T_FCAT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD update_salv_fcat.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Update SALV field catalog                               *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-14 Oct 2026
    IF gs_alv_tracker-salv_table IS NOT INITIAL.
      DATA(columns_table) = gs_alv_tracker-salv_table->get_columns( ).
      DATA(columns) = columns_table->get( ).

      DATA(fieldcat_lcl) = fieldcat.
      LOOP AT fieldcat_lcl TRANSPORTING NO FIELDS
                           WHERE col_pos NE 0.
        EXIT.
      ENDLOOP.
      IF sy-subrc = 0. "There is atleast one row where row position is mentioned
        SORT fieldcat_lcl BY row_pos DESCENDING.
        DATA(next_index) = fieldcat_lcl[ 1 ]-col_pos + 1. "Get the latest assigned Row Position, and start after that
        fieldcat_lcl = fieldcat.
      ELSE.
        next_index = 1. "Start from the beginning, Retain order passed in
      ENDIF.

      "For field catalog entries where Row position is not assigned
      "Increment, starting with the next available position
      LOOP AT fieldcat_lcl ASSIGNING FIELD-SYMBOL(<fcat_line>)
                           WHERE col_pos EQ 0.
        <fcat_line>-col_pos = next_index.
        ADD 1 TO next_index.
      ENDLOOP.

      SORT fieldcat_lcl BY col_pos.

      LOOP AT fieldcat_lcl ASSIGNING FIELD-SYMBOL(<fieldcat>).
        ASSIGN columns[ columnname = <fieldcat>-fieldname ] TO FIELD-SYMBOL(<column>).
        IF sy-subrc = 0.
          DATA(column_ref) = <column>-r_column.

          column_ref->set_long_text( <fieldcat>-scrtext_l ).
          column_ref->set_medium_text( <fieldcat>-scrtext_m ).
          column_ref->set_short_text( <fieldcat>-scrtext_s ).

          IF <fieldcat>-no_out = abap_true.
            column_ref->set_visible( abap_false ).
            columns_table->set_column_position( columnname = <column>-columnname position = lines( columns  ) + 1 ).
          ELSE.
            columns_table->set_column_position( columnname = <column>-columnname position = <fieldcat>-col_pos ).
          ENDIF.

        ENDIF.
      ENDLOOP.
      LOOP AT columns INTO DATA(column)."For every column displayed
        column_ref = column-r_column.
        ASSIGN fieldcat_lcl[ fieldname = column-columnname ]
               TO <fieldcat>.
        IF sy-subrc NE 0."If there is no entry in FCAT for the column
          column_ref->set_visible( abap_false ).
          columns_table->set_column_position( columnname = column-columnname position = lines( columns  ) + 1 ).
        ENDIF.
      ENDLOOP.

    ENDIF.
*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-14 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_ALV_HELPER_004->UPDATE_TREE_NODE
* +-------------------------------------------------------------------------------------------------+
* | [<-->] ALV_TREE_NODE_UPD_PARAMETERS   TYPE        ALV_TREE_NODE_UPD_PARAMETERS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD UPDATE_TREE_NODE.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAA (AJSIDMG)                       *
* Date:      9th Jan 2026                                              *
* Reference Change/Incident:  JASDUONAS                               *
* Change Indicator: JASDUONAS-AAAAA-AJSIDMG                         *
* Description: Update ICON of the tree node                            *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JASDUONAS-AAAAA-AJSIDMG-05 Jun 2026
    FIELD-SYMBOLS: <outtab_line> TYPE any.
    DATA(alv_type) = gs_alv_tracker-alv_type.

    IF alv_type = gc_grid_type_tree.
      DATA(alv_tree) = gs_alv_tracker-alv_tree.

      ASSIGN alv_tree_node_upd_parameters-tree_line_reference->* TO <outtab_line>.

      DATA(node_layout) = alv_tree_node_upd_parameters-node_layout.

      "Return back existing values
      alv_tree->get_outtab_line(
      EXPORTING
        i_node_key = alv_tree_node_upd_parameters-tree_node
      IMPORTING
        e_outtab_line = <outtab_line>
        es_node_layout = DATA(existing_layout)
      ).

      MOVE-CORRESPONDING existing_layout TO alv_tree_node_upd_parameters-node_layout.

      alv_tree->change_node(
        i_node_key = alv_tree_node_upd_parameters-tree_node
        i_outtab_line = <outtab_line>
        is_node_layout = node_layout
      ).

      CALL METHOD alv_tree->frontend_update.

    ELSE.
    ENDIF.

*<<<End of Changes-JASDUONAS-AAAAA-AJSIDMG-05 Jun 2026
  ENDMETHOD.
ENDCLASS.
