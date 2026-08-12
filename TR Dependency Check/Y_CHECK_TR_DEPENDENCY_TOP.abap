*&---------------------------------------------------------------------*
*&  Include           Y_CHECK_TR_DEPENDENCY_TOP
*&---------------------------------------------------------------------*

TABLES: e071.

DATA: gv_obj_rep_first         TYPE boole_d,

      gt_obj_stat              TYPE ytt_obj_stat,
      gt_tr_stat               TYPE ytt_tr_stat,

      git_fieldcat_obj         TYPE lvc_t_fcat,
      gwa_layout_obj           TYPE lvc_s_layo,
      gwa_variant_obj          TYPE disvariant,
      git_fieldcat_tr          TYPE lvc_t_fcat,
      gwa_layout_tr            TYPE lvc_s_layo,
      gwa_variant_tr           TYPE disvariant,

      gro_grid_obj             TYPE REF TO cl_gui_alv_grid,
      gro_custom_container_obj TYPE REF TO cl_gui_custom_container,
      gro_doc_container_obj    TYPE REF TO cl_gui_docking_container,

      gro_grid_tr              TYPE REF TO cl_gui_alv_grid,
      gro_custom_container_tr  TYPE REF TO cl_gui_custom_container,
      gro_doc_container_tr     TYPE REF TO cl_gui_docking_container.

DATA: gv_c_override_dt    TYPE dats VALUE '99991231',
      gv_c_override_tm    TYPE tims VALUE '235959',

      gv_c_container_main TYPE scrfname VALUE 'ALV_CONTAINER'.
