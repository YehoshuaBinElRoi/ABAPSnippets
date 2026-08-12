REPORT y_check_tr_dependency.

INCLUDE y_check_tr_dependency_top.
INCLUDE y_check_tr_dependency_sel.
INCLUDE y_check_tr_dependency_sub.
INCLUDE y_check_tr_dependency_scr.

START-OF-SELECTION.
  IF p_rip = abap_true.
*****    PERFORM build_dependency_list USING p_pgmid
*****                                     p_otype
*****                                     p_oname
*****                                     p_tr
*****                                     p_dev
*****                                     p_qa
*****                                     p_prd.
    LOOP AT s_tr INTO DATA(lsr_tr).
      PERFORM tr_parser USING lsr_tr-low
                              p_dev
                              p_qa
                              p_prd
                     CHANGING gt_tr_stat
                              gt_obj_stat.
    ENDLOOP.
  ELSE.
    LOOP AT s_tr INTO lsr_tr.
      PERFORM plain_tr_stats USING lsr_tr-low
                                   p_dev
                                   p_qa
                                   p_prd.
    ENDLOOP.

  ENDIF.

  gv_obj_rep_first = p_obj.
  PERFORM display_alv.
