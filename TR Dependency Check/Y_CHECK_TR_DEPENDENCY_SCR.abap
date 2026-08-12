*----------------------------------------------------------------------*
***INCLUDE Y_CHECK_TR_DEPENDENCY_SCR.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_1001  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_1001 OUTPUT.
  SET PF-STATUS 'STATUS_OBJ_DETAILS'.
  SET TITLEBAR 'TITLE_OBJ_DETAILS'.

  DATA: lv_first_time_1001 TYPE boole_d.


*****  PERFORM clear_alv_obj CHANGING gro_grid_tr
*****                                 gro_custom_container_tr.

  IF cl_gui_alv_grid=>offline( ) IS INITIAL."Foreground
    IF gro_custom_container_obj IS INITIAL.
      CREATE OBJECT gro_custom_container_obj
        EXPORTING
          container_name = gv_c_container_main.

      CREATE OBJECT gro_grid_obj
        EXPORTING
          i_parent = gro_custom_container_obj.
      lv_first_time_1001 = abap_true.
    ENDIF.
  ELSE."If it is in background:
    IF gro_doc_container_obj IS INITIAL.
      CREATE OBJECT gro_grid_obj
        EXPORTING
          i_parent = gro_doc_container_obj.
      lv_first_time_1001 = abap_true.
    ENDIF.
  ENDIF.

  IF lv_first_time_1001 = abap_true.

    PERFORM create_field_cat.
    PERFORM update_layout.

    CALL METHOD gro_grid_obj->set_table_for_first_display
      EXPORTING
*****        i_structure_name = 'GIT_ALVOUTTAB'
        is_layout       = gwa_layout_obj
        is_variant      = gwa_variant_obj
        i_save          = 'A'
      CHANGING
        it_outtab       = gt_obj_stat
        it_fieldcatalog = git_fieldcat_obj.

  ELSE.
    CALL METHOD gro_grid_obj->refresh_table_display
      EXPORTING
        i_soft_refresh = abap_true.
  ENDIF.

ENDMODULE.


MODULE status_1002 OUTPUT.
  SET PF-STATUS 'STATUS_TR_DETAILS'.
  SET TITLEBAR 'TITLE_TR_DETAILS'.

  DATA: lv_first_time_1002 TYPE boole_d.

*****  PERFORM clear_alv_obj CHANGING gro_grid_obj
*****                                 gro_custom_container_obj.

  IF cl_gui_alv_grid=>offline( ) IS INITIAL."Foreground
    IF gro_custom_container_tr IS INITIAL.
      CREATE OBJECT gro_custom_container_tr
        EXPORTING
          container_name = gv_c_container_main.

      CREATE OBJECT gro_grid_tr
        EXPORTING
          i_parent = gro_custom_container_tr.
      lv_first_time_1002 = abap_true.
    ENDIF.
  ELSE."If it is in background:
    IF gro_doc_container_tr IS INITIAL.
      CREATE OBJECT gro_grid_tr
        EXPORTING
          i_parent = gro_doc_container_tr.
      lv_first_time_1002 = abap_true.
    ENDIF.
  ENDIF.

  IF lv_first_time_1002 = abap_true.

    PERFORM create_field_cat.
    PERFORM update_layout.

    CALL METHOD gro_grid_tr->set_table_for_first_display
      EXPORTING
*****        i_structure_name = 'GIT_ALVOUTTAB'
        is_layout       = gwa_layout_tr
        is_variant      = gwa_variant_tr
        i_save          = 'A'
      CHANGING
        it_outtab       = gt_tr_stat
        it_fieldcatalog = git_fieldcat_tr.

  ELSE.
    CALL METHOD gro_grid_tr->refresh_table_display
      EXPORTING
        i_soft_refresh = abap_true.
  ENDIF.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1001 INPUT.
  IF sy-ucomm = 'BACK' OR
     sy-ucomm = 'PREV'.
    IF sy-dynnr = '1001'.
      PERFORM clear_alv_obj CHANGING gro_grid_obj
                                     gro_custom_container_obj.
    ELSEIF sy-dynnr = '1002'.
      PERFORM clear_alv_obj CHANGING gro_grid_tr
                                     gro_custom_container_tr.
    ENDIF.
    LEAVE TO SCREEN 0.
  ELSEIF sy-ucomm = 'EXIT'.
    PERFORM clear_alv_obj CHANGING gro_grid_obj
                                   gro_custom_container_obj.
    PERFORM clear_alv_obj CHANGING gro_grid_tr
                                   gro_custom_container_tr.
    LEAVE PROGRAM.
  ELSEIF sy-ucomm = 'TRDET'.
    PERFORM clear_alv_obj CHANGING gro_grid_obj
                                   gro_custom_container_obj.
    PERFORM clear_alv_obj CHANGING gro_grid_tr
                                   gro_custom_container_tr.
    IF gv_obj_rep_first = abap_true.
      CALL SCREEN 1002.
    ELSE.
      LEAVE TO SCREEN 0.
    ENDIF.
  ELSEIF sy-ucomm = 'OBDET'.
    PERFORM clear_alv_obj CHANGING gro_grid_obj
                                   gro_custom_container_obj.
    PERFORM clear_alv_obj CHANGING gro_grid_tr
                                   gro_custom_container_tr.
    IF gv_obj_rep_first = abap_false.
      CALL SCREEN 1001.
    ELSE.
      LEAVE TO SCREEN 0.
    ENDIF.
  ENDIF.
ENDMODULE.
