*&---------------------------------------------------------------------*
*&  Include           Y_CHECK_TR_DEPENDENCY_SUB
*&---------------------------------------------------------------------*

FORM plain_tr_stats USING iv_tr TYPE trkorr
                          iv_dev TYPE tstrfcofil-tarsystem
                          iv_qa  TYPE tstrfcofil-tarsystem
                          iv_prd TYPE tstrfcofil-tarsystem.

  DATA: lt_e071 TYPE e071_t,
        lt_e070 TYPE e070_t.

  SELECT * FROM e071
         INTO TABLE @lt_e071
         WHERE
          trkorr = @iv_tr.
  IF lt_e071[] IS INITIAL. "It is possible the input TR is not released yet
    SELECT * FROM e070
             INTO TABLE @DATA(lt_e070_tr)
             WHERE
              strkorr = @iv_tr.

    IF lt_e070_tr[] IS NOT INITIAL.
      SELECT * FROM e071
               INTO TABLE lt_e071
               FOR ALL ENTRIES IN lt_e070_tr[]
               WHERE
                trkorr = lt_e070_tr-trkorr.
    ENDIF.
  ENDIF.


  DATA(lt_uniq_obj) = lt_e071[].

  SORT lt_uniq_obj BY pgmid object obj_name.
  DELETE ADJACENT DUPLICATES FROM lt_uniq_obj COMPARING pgmid object obj_name.
  DELETE lt_uniq_obj WHERE pgmid IS INITIAL AND
                           object IS INITIAL AND
                           obj_name IS INITIAL.

  "Header details of each TR
  SELECT * FROM e070
           INTO TABLE @lt_e070
           WHERE
            trkorr = @iv_tr.
  IF lt_e070[] IS NOT INITIAL.
    DATA(lt_e070_univ_tmp) = lt_e070[].
    IF lt_e070_univ_tmp[ 1 ]-strkorr IS NOT INITIAL.
      SELECT * FROM e070
               APPENDING TABLE @lt_e070
               FOR ALL ENTRIES IN @lt_e070_univ_tmp
               WHERE
                trkorr = @lt_e070_univ_tmp-strkorr.
    ENDIF.
  ENDIF.

  PERFORM fill_tr_stat USING iv_dev
                          iv_qa
                          iv_prd
                          lt_e070[]
                          lt_e071[]
                    CHANGING gt_tr_stat.

  "Loop through each unique object
  LOOP AT lt_uniq_obj INTO DATA(ls_uniq_obj).
    PERFORM get_obj_stat USING gt_tr_stat
                            ls_uniq_obj
                            lt_e071
                      CHANGING gt_obj_stat.


    "---If the latest In Dev TR = Dev Export TR = latest QA TR = latest PRD TR - Object is Safe
    "---If Not, find and list the TRs between In Dev TR/Dev Export TR - Latest PRD TR
    "---Add the object detail to the list
  ENDLOOP.

ENDFORM.

FORM build_dependency_list USING iv_pgmid TYPE pgmid
                                 iv_otype TYPE trobjtype
                                 iv_oname TYPE trobj_name
                                 iv_tr TYPE trkorr
                                 iv_dev TYPE tstrfcofil-tarsystem
                                 iv_qa  TYPE tstrfcofil-tarsystem
                                 iv_prd TYPE tstrfcofil-tarsystem.

  DATA: lv_user         TYPE e070-as4user,

        ls_tr_log       TYPE ctslg_cofile,
        ls_tr_stat      TYPE yst_tr_stat,
        ls_obj_stat     TYPE yst_obj_stat,

        lt_obj_stat     TYPE ytt_obj_stat,
        lt_e070_univ    TYPE e070_t,
        lt_uniq_univ_tr TYPE e071_t,
        lt_e071_univ    TYPE e071_t.


  "Retrieve all TRs containing the given object
  "Or Retrive the given TR
  IF iv_tr IS NOT INITIAL.
    SELECT * FROM e071
             INTO TABLE @DATA(lt_e071_tr)
             WHERE
              trkorr = @iv_tr.
    IF lt_e071_tr[] IS INITIAL. "It is possible the input TR is not released yet
      SELECT * FROM e070
               INTO TABLE @DATA(lt_e070_tr)
               WHERE
                strkorr = @iv_tr.

      IF lt_e070_tr[] IS NOT INITIAL.
        SELECT * FROM e071
                 INTO TABLE lt_e071_tr
                 FOR ALL ENTRIES IN lt_e070_tr[]
                 WHERE
                  trkorr = lt_e070_tr-trkorr.
      ENDIF.
    ENDIF.

    "All TRs containing the objects in the root TR
    IF lt_e071_tr[] IS NOT INITIAL.
      DATA(lt_e071_tr_tmp) = lt_e071_tr[].

      SORT lt_e071_tr_tmp BY pgmid object obj_name.
      DELETE ADJACENT DUPLICATES FROM lt_e071_tr_tmp COMPARING  pgmid object obj_name.
      DELETE lt_e071_tr_tmp WHERE pgmid IS INITIAL AND
                                  object IS INITIAL AND
                                  obj_name IS INITIAL.
      IF lt_e071_tr_tmp[] IS NOT INITIAL.
        SELECT * FROM e071
                 INTO TABLE @DATA(lt_e071)
                 FOR ALL ENTRIES IN @lt_e071_tr_tmp
                 WHERE
                  pgmid = @lt_e071_tr_tmp-pgmid AND
                  object = @lt_e071_tr_tmp-object AND
                  obj_name = @lt_e071_tr_tmp-obj_name.
      ENDIF.


    ENDIF.
  ELSE.
    SELECT * FROM e071
             INTO TABLE lt_e071
             WHERE
              pgmid = iv_pgmid AND
              object = iv_otype AND
              obj_name = iv_oname.
  ENDIF.

  "Retrieve all objects, in each of the TR
  DATA(lt_uniq_tr) = lt_e071[].

  SORT lt_uniq_tr BY trkorr ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_uniq_tr COMPARING trkorr.
  DELETE lt_uniq_tr WHERE trkorr IS INITIAL.

  IF lt_uniq_tr[] IS NOT INITIAL.
    SELECT * FROM e071
             INTO TABLE @DATA(lt_e071_obj)
             FOR ALL ENTRIES IN @lt_uniq_tr
             WHERE
              trkorr = @lt_uniq_tr-trkorr.
  ENDIF.

  "Retrieve all TRs containing all objects from above step
  DATA(lt_uniq_obj) = lt_e071_obj[].

  SORT lt_uniq_obj BY pgmid object obj_name.
  DELETE ADJACENT DUPLICATES FROM lt_uniq_obj COMPARING pgmid object obj_name.
  DELETE lt_uniq_obj WHERE pgmid IS INITIAL AND
                           object IS INITIAL AND
                           obj_name IS INITIAL.

  "Delete objects which cannot really be checked for Dependency, like table entries
  DELETE lt_uniq_obj WHERE pgmid = 'R3TR' AND
                           object = 'TABU'.

  DELETE lt_uniq_obj WHERE pgmid = 'R3TR' AND
                           object = 'CDAT'.

  IF lt_uniq_obj[] IS NOT INITIAL.
    SELECT * FROM e071
             INTO TABLE @lt_e071_univ
             FOR ALL ENTRIES IN @lt_uniq_obj
             WHERE
                pgmid = @lt_uniq_obj-pgmid AND
                object = @lt_uniq_obj-object AND
                obj_name = @lt_uniq_obj-obj_name.

  ENDIF.

  lt_uniq_univ_tr = lt_e071_univ[].

  SORT lt_uniq_univ_tr BY trkorr ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_uniq_univ_tr COMPARING trkorr.
  DELETE lt_uniq_univ_tr WHERE trkorr IS INITIAL.

  IF lt_uniq_univ_tr[] IS NOT INITIAL.
    "Header details of each TR
    SELECT * FROM e070
             INTO TABLE @lt_e070_univ
             FOR ALL ENTRIES IN @lt_uniq_univ_tr
             WHERE
              trkorr = @lt_uniq_univ_tr-trkorr.
    IF lt_e070_univ[] IS NOT INITIAL.
      DATA(lt_e070_univ_tmp) = lt_e070_univ[].

      DELETE lt_e070_univ_tmp WHERE strkorr IS INITIAL.
      IF lt_e070_univ_tmp[] IS NOT INITIAL.
        SORT lt_e070_univ_tmp BY strkorr ASCENDING.
        DELETE ADJACENT DUPLICATES FROM lt_e070_univ_tmp COMPARING strkorr.

        SELECT * FROM e070
                 APPENDING TABLE @lt_e070_univ
                 FOR ALL ENTRIES IN @lt_e070_univ_tmp
                 WHERE
                  trkorr = @lt_e070_univ_tmp-strkorr.

      ENDIF.

    ENDIF.

    PERFORM fill_tr_stat USING iv_dev
                            iv_qa
                            iv_prd
                            lt_e070_univ[]
                            lt_uniq_univ_tr[]
                      CHANGING gt_tr_stat.

*****    "Retrieve the log for each TR using FM TR_READ_GLOBAL_INFO_OF_REQUEST
*****    LOOP AT lt_uniq_univ_tr INTO DATA(ls_tr).



*****      CLEAR: ls_tr_stat,
*****
*****             ls_tr_log.
*****
*****      ls_tr_stat-tr = ls_tr-trkorr.
*****
*****      "If TR status is NOT Released, do not do the below, add a line with empty date/times
*****      IF line_exists( lt_e070_univ[ trkorr = ls_tr-trkorr ] ).
*****        DATA(ls_e070) = lt_e070_univ[ trkorr = ls_tr-trkorr ].
*****
*****        IF ls_e070-strkorr IS NOT INITIAL."This is a task
*****
*****          DATA(ls_e070_up) = lt_e070_univ[ trkorr = ls_e070-strkorr ].
*****
*****          IF ls_e070_up-trstatus = 'D' OR
*****             ls_e070_up-trstatus = 'L'.
*****            ls_tr_stat-dev_exp_dt = gv_c_override_dt.
*****            ls_tr_stat-dev_exp_ti = gv_c_override_tm.
*****            ls_tr_stat-qas_imp_dt = gv_c_override_dt.
*****            ls_tr_stat-qas_imp_ti = gv_c_override_tm.
*****            ls_tr_stat-prd_imp_dt = gv_c_override_dt.
*****            ls_tr_stat-prd_imp_ti = gv_c_override_tm.
*****            APPEND ls_tr_stat TO gt_tr_stat."Adding an empty line with just the task number
*****            CONTINUE.
*****          ELSE.
*****            CONTINUE. "This will be handled in the higher level TR
*****          ENDIF.
*****
*****        ENDIF.
*****      ENDIF.
*****
*****      CALL FUNCTION 'TR_READ_GLOBAL_INFO_OF_REQUEST'
*****        EXPORTING
*****          iv_trkorr = ls_tr-trkorr
******         IV_DIR_TYPE                     = 'T'
******         IS_SETTINGS                     =
******         IV_SUPPRESS_DELETED_STEPS       = ' '
******         IT_COMM_SYSTEMS                 =
*****        IMPORTING
*****          es_cofile = ls_tr_log
*****          ev_user   = lv_user
******         EV_PROJECT                      =
*****        .
*****      IF sy-subrc = 0.
*****        LOOP AT ls_tr_log-systems INTO DATA(ls_system).
*****          IF ls_system-systemid = iv_dev. "Development
*****            PERFORM find_latest_activity_dt_tm USING 'E' "Find latest export date/time
*****                                                  ls_system-steps "Steps in the system specific log
*****                                            CHANGING ls_tr_stat-dev_exp_dt
*****                                                     ls_tr_stat-dev_exp_ti.
*****          ELSEIF ls_system-systemid = iv_qa. "QAS
*****            PERFORM find_latest_activity_dt_tm USING '!' "Find latest export date/time
*****                                                  ls_system-steps "Steps in the system specific log
*****                                            CHANGING ls_tr_stat-qas_imp_dt
*****                                                     ls_tr_stat-qas_imp_ti.
*****          ELSEIF ls_system-systemid = iv_prd. "PRD
*****            PERFORM find_latest_activity_dt_tm USING '!' "Find latest export date/time
*****                                                  ls_system-steps "Steps in the system specific log
*****                                            CHANGING ls_tr_stat-prd_imp_dt
*****                                                     ls_tr_stat-prd_imp_ti.
*****          ENDIF.
*****        ENDLOOP.
*****      ENDIF.
*****
*****      IF ls_tr_stat-dev_exp_dt IS INITIAL.
*****        ls_tr_stat-dev_exp_dt = gv_c_override_dt.
*****        ls_tr_stat-dev_exp_ti = gv_c_override_tm.
*****      ENDIF.
*****
*****      IF ls_tr_stat-qas_imp_dt IS INITIAL.
*****        ls_tr_stat-qas_imp_dt = gv_c_override_dt.
*****        ls_tr_stat-qas_imp_ti = gv_c_override_tm.
*****      ENDIF.
*****
*****      IF ls_tr_stat-prd_imp_dt IS INITIAL.
*****        ls_tr_stat-prd_imp_dt = gv_c_override_dt.
*****        ls_tr_stat-prd_imp_ti = gv_c_override_tm.
*****      ENDIF.
*****      APPEND ls_tr_stat TO gt_tr_stat.
*****    ENDLOOP.

    "Loop through each unique object
    LOOP AT lt_uniq_obj INTO DATA(ls_uniq_obj).
      PERFORM get_obj_stat USING gt_tr_stat
                              ls_uniq_obj
                              lt_e071_univ
                        CHANGING gt_obj_stat.


      "---If the latest In Dev TR = Dev Export TR = latest QA TR = latest PRD TR - Object is Safe
      "---If Not, find and list the TRs between In Dev TR/Dev Export TR - Latest PRD TR
      "---Add the object detail to the list
    ENDLOOP.
  ENDIF.
ENDFORM.

FORM find_latest_activity_dt_tm USING iv_step_id TYPE trbatfunc
                                      it_steps TYPE ctslg_steps
                                CHANGING cv_date TYPE dats
                                         cv_time TYPE tims.
  LOOP AT it_steps INTO DATA(ls_steps)
                          WHERE
                            stepid = iv_step_id.
    LOOP AT ls_steps-actions INTO DATA(ls_actions)
                             WHERE
                              ( rc = 0 OR rc = 4 ).

*****      if ls_actions = 4."If this ended with WARNING, consider only if there are no entries with SUCCESS
*****
*****      endif.
      IF cv_time < ls_actions-time.
        IF cv_date <= ls_actions-date.
          cv_time = ls_actions-time.
        ENDIF.
      ENDIF.

      IF cv_date < ls_actions-date.
        cv_date = ls_actions-date.
        cv_time = ls_actions-time.
      ELSEIF cv_date > ls_actions-date.
      ELSEIF cv_date = ls_actions-date. "Two Activities with same date
        IF cv_time < ls_actions-time.
          cv_time = ls_actions-time.
        ENDIF.
      ENDIF.

    ENDLOOP.
  ENDLOOP.


ENDFORM.

FORM fill_tr_stat USING iv_dev TYPE tstrfcofil-tarsystem
                        iv_qa  TYPE tstrfcofil-tarsystem
                        iv_prd TYPE tstrfcofil-tarsystem
                        it_e070 TYPE e070_t
                        it_tr_list TYPE e071_t
                  CHANGING ct_tr_stat TYPE ytt_tr_stat.

  DATA: ls_tr_stat TYPE yst_tr_stat.

  "Retrieve the log for each TR using FM TR_READ_GLOBAL_INFO_OF_REQUEST
  LOOP AT it_tr_list INTO DATA(ls_tr).

    CLEAR: ls_tr_stat.

    PERFORM get_tr_stat USING ls_tr-trkorr
                           iv_dev
                           iv_qa
                           iv_prd
                           it_e070
                     CHANGING ls_tr_stat .
    IF ls_tr_stat-trkorr IS NOT INITIAL.
      APPEND ls_tr_stat TO ct_tr_stat.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM get_tr_stat USING iv_tr TYPE trkorr
                       iv_dev TYPE tstrfcofil-tarsystem
                       iv_qa  TYPE tstrfcofil-tarsystem
                       iv_prd TYPE tstrfcofil-tarsystem
                       it_e070 TYPE e070_t
                 CHANGING cs_tr_stat TYPE yst_tr_stat .
  DATA: lv_user   TYPE e070-as4user,

        ls_tr_log TYPE ctslg_cofile.

  CLEAR: cs_tr_stat,

         ls_tr_log.

  cs_tr_stat-trkorr = iv_tr.

  "If TR status is NOT Released, do not do the below, add a line with empty date/times
  IF line_exists( it_e070[ trkorr = iv_tr ] ).
    DATA(ls_e070) = it_e070[ trkorr = iv_tr ].

    IF ls_e070-strkorr IS NOT INITIAL."This is a task

      DATA(ls_e070_up) = it_e070[ trkorr = ls_e070-strkorr ].

      IF ls_e070_up-trstatus = 'D' OR
         ls_e070_up-trstatus = 'L'.
        "For tasks part of un-released TR
        "An entry must be made for the task
        cs_tr_stat-dev_exp_dt = gv_c_override_dt.
        cs_tr_stat-dev_exp_ti = gv_c_override_tm.
        cs_tr_stat-qas_imp_dt = gv_c_override_dt.
        cs_tr_stat-qas_imp_ti = gv_c_override_tm.
        cs_tr_stat-prd_imp_dt = gv_c_override_dt.
        cs_tr_stat-prd_imp_ti = gv_c_override_tm.
*****          APPEND is_tr_Stat TO ct_tr_stat."Adding an empty line with just the task number
        RETURN.
      ELSE.
        "For tasks part of a released TR
        "This will be handled in the higher level TR
        CLEAR: cs_tr_stat.
        RETURN.
      ENDIF.

    ENDIF.
  ENDIF.

  CALL FUNCTION 'TR_READ_GLOBAL_INFO_OF_REQUEST'
    EXPORTING
      iv_trkorr = iv_tr
*     IV_DIR_TYPE                     = 'T'
*     IS_SETTINGS                     =
*     IV_SUPPRESS_DELETED_STEPS       = ' '
*     IT_COMM_SYSTEMS                 =
    IMPORTING
      es_cofile = ls_tr_log
      ev_user   = lv_user
*     EV_PROJECT                      =
    .
  IF sy-subrc = 0.
    LOOP AT ls_tr_log-systems INTO DATA(ls_system).
      IF ls_system-systemid = iv_dev. "Development
        PERFORM find_latest_activity_dt_tm USING 'E' "Find latest export date/time
                                              ls_system-steps "Steps in the system specific log
                                        CHANGING cs_tr_stat-dev_exp_dt
                                                 cs_tr_stat-dev_exp_ti.
      ELSEIF ls_system-systemid = iv_qa. "QAS
        PERFORM find_latest_activity_dt_tm USING '!' "Find latest export date/time
                                              ls_system-steps "Steps in the system specific log
                                        CHANGING cs_tr_stat-qas_imp_dt
                                                 cs_tr_stat-qas_imp_ti.
        IF cs_tr_stat-qas_imp_dt IS INITIAL AND
           cs_tr_stat-qas_imp_ti IS INITIAL.
          PERFORM find_latest_activity_dt_tm USING 'I' "Find latest export date/time
                                                ls_system-steps "Steps in the system specific log
                                          CHANGING cs_tr_stat-qas_imp_dt
                                                   cs_tr_stat-qas_imp_ti.
        ENDIF.
      ELSEIF ls_system-systemid = iv_prd. "PRD
        PERFORM find_latest_activity_dt_tm USING '!' "Find latest export date/time
                                              ls_system-steps "Steps in the system specific log
                                        CHANGING cs_tr_stat-prd_imp_dt
                                                 cs_tr_stat-prd_imp_ti.

        IF cs_tr_stat-prd_imp_dt IS INITIAL AND
           cs_tr_stat-prd_imp_ti IS INITIAL.
          PERFORM find_latest_activity_dt_tm USING 'I' "Find latest export date/time
                                              ls_system-steps "Steps in the system specific log
                                        CHANGING cs_tr_stat-prd_imp_dt
                                                 cs_tr_stat-prd_imp_ti.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF cs_tr_stat-dev_exp_dt IS INITIAL.
    cs_tr_stat-dev_exp_dt = gv_c_override_dt.
    cs_tr_stat-dev_exp_ti = gv_c_override_tm.
  ENDIF.

  IF cs_tr_stat-qas_imp_dt IS INITIAL.
    cs_tr_stat-qas_imp_dt = gv_c_override_dt.
    cs_tr_stat-qas_imp_ti = gv_c_override_tm.
  ENDIF.

  IF cs_tr_stat-prd_imp_dt IS INITIAL.
    cs_tr_stat-prd_imp_dt = gv_c_override_dt.
    cs_tr_stat-prd_imp_ti = gv_c_override_tm.
  ENDIF.

ENDFORM.

FORM get_obj_stat USING it_tr_stat TYPE ytt_tr_stat
                        is_obj_det TYPE e071
                        it_e071 TYPE e071_t
                  CHANGING ct_obj_stat TYPE ytt_obj_stat.

  DATA: ls_obj_stat TYPE yst_obj_stat,

        lt_obj_stat TYPE ytt_obj_stat.


  ls_obj_stat-pgmid = is_obj_det-pgmid.
  ls_obj_stat-object = is_obj_det-object.
  ls_obj_stat-obj_name = is_obj_det-obj_name.

  "--Loop through each TR containing the object
  LOOP AT it_e071 INTO DATA(ls_e071_univ)
                       WHERE
                        pgmid = is_obj_det-pgmid AND
                        object = is_obj_det-object AND
                        obj_name = is_obj_det-obj_name.
    IF line_exists( it_tr_stat[ trkorr = ls_e071_univ-trkorr ] ).
      DATA(ls_tr_stat) = it_tr_stat[ trkorr = ls_e071_univ-trkorr ].

      MOVE-CORRESPONDING ls_tr_stat TO ls_obj_stat.
      APPEND ls_obj_stat TO lt_obj_stat.
    ENDIF.
  ENDLOOP.
  "---Find the latest import date, imported TR for each system from the earlier table

  SORT lt_obj_stat BY prd_imp_dt DESCENDING prd_imp_ti DESCENDING
                      qas_imp_dt DESCENDING qas_imp_ti DESCENDING
                      dev_exp_dt DESCENDING dev_exp_ti DESCENDING.
  LOOP AT lt_obj_stat ASSIGNING FIELD-SYMBOL(<lfs_obj_stat>).
    <lfs_obj_stat>-seq = sy-tabix.
  ENDLOOP.

  APPEND LINES OF lt_obj_stat TO ct_obj_stat.
ENDFORM.

FORM tr_parser USING iv_tr TYPE trkorr
                     iv_dev TYPE tstrfcofil-tarsystem
                     iv_qa  TYPE tstrfcofil-tarsystem
                     iv_prd TYPE tstrfcofil-tarsystem
               CHANGING ct_tr_log TYPE ytt_tr_stat
                        ct_obj_tr_log TYPE ytt_obj_stat.
  DATA: lv_sequence    TYPE i,

        ls_tr_stat     TYPE yst_tr_stat,
        ls_obj_tr_stat TYPE yst_obj_stat,

        lt_root_tr_obj TYPE e071_t,
        lt_rel_tr_list TYPE e071_t,
        lt_tr_header   TYPE e070_t,

        lt_obj_tr_log  TYPE ytt_obj_stat,
        lt_tr_log      TYPE ytt_tr_stat.

*****  LOOP AT it_tr INTO DATA(lsr_tr).

  IF iv_tr IS INITIAL.
    EXIT.
  ENDIF.

  SELECT SINGLE * FROM e070
                  INTO @DATA(ls_e070)
                  WHERE
                    trkorr = @iv_tr.
  IF sy-subrc = 0.
    IF ls_e070-trstatus = 'D' OR "TR is not released yet.
       ls_e070-trstatus = 'L'.
      "We must get objects from TR & Tasks
      SELECT * FROM e070
               INTO TABLE lt_tr_header
               WHERE
               strkorr = iv_tr. "Get related task header
    ENDIF.
    APPEND ls_e070 TO lt_tr_header.

    "Get all objects in the given TR (Including it's tasks if necessary)
    SELECT * FROM e071
             INTO TABLE lt_root_tr_obj
             FOR ALL ENTRIES IN lt_tr_header
             WHERE
              trkorr = lt_tr_header-trkorr.

    "Find the related TR for each object
    LOOP AT lt_root_tr_obj INTO DATA(ls_tr_obj)."For every object in the TR, find all other TRs containing the object
      IF NOT line_exists( lt_obj_tr_log[
                                    pgmid = ls_tr_obj-pgmid
                                    object = ls_tr_obj-object
                                    obj_name = ls_tr_obj-obj_name
                                    ] ) AND"If object is already in the list, no need to parse again
         NOT line_exists( ct_obj_tr_log[
                                    pgmid = ls_tr_obj-pgmid
                                    object = ls_tr_obj-object
                                    obj_name = ls_tr_obj-obj_name
                                    ] ).

        REFRESH: lt_rel_tr_list.
        "Find all TRs containing the object being looped at
        SELECT * FROM e071
                 INTO TABLE lt_rel_tr_list
                 WHERE
                  pgmid = ls_tr_obj-pgmid AND
                  object = ls_tr_obj-object AND
                  obj_name = ls_tr_obj-obj_name.
        IF lt_rel_tr_list[] IS NOT INITIAL.

          LOOP AT lt_rel_tr_list INTO DATA(ls_rel_tr_list)."For each TR cotaining the same object
            IF NOT line_exists( ct_tr_log[ trkorr = ls_rel_tr_list-trkorr ] ) AND"If TR is not already in the log
               NOT line_exists( lt_tr_log[ trkorr = ls_rel_tr_list-trkorr ] ).
              REFRESH: lt_tr_header.
              SELECT SINGLE * FROM e070
                       INTO  ls_e070
                       WHERE
                        trkorr = ls_rel_tr_list-trkorr.
              APPEND ls_e070 TO lt_tr_header.
              IF ls_e070-strkorr IS NOT INITIAL.
                SELECT * FROM e070
                         APPENDING TABLE lt_tr_header
                         WHERE
                          trkorr = ls_e070-strkorr.
              ENDIF.
              CLEAR: ls_tr_stat.
              "Get the history of the TR
              PERFORM get_tr_stat USING ls_rel_tr_list-trkorr
                                     iv_dev
                                     iv_qa
                                     iv_prd
                                     lt_tr_header
                               CHANGING ls_tr_stat .
              IF ls_tr_stat-trkorr IS INITIAL. "This will be empty, if this is a TASK related to a released TR
                CONTINUE. "No action required here, as the Object will be handled when the released TR is processed
              ELSE.
                ls_tr_stat-root_trkorr = iv_tr. "The Original TR which led to this object/TR
                APPEND ls_tr_stat TO lt_tr_log.
              ENDIF.
            ELSEIF line_exists( ct_tr_log[ trkorr = ls_rel_tr_list-trkorr ] ).
              "Pick status from the existing log entry
              ls_tr_stat = ct_tr_log[ trkorr = ls_rel_tr_list-trkorr ].
              ls_tr_stat-root_trkorr = iv_tr. "The Original TR which led to this object/TR
            ELSEIF line_exists( lt_tr_log[ trkorr = ls_rel_tr_list-trkorr ] ).
              "Pick status from the existing log entry
              ls_tr_stat = lt_tr_log[ trkorr = ls_rel_tr_list-trkorr ].
              ls_tr_stat-root_trkorr = iv_tr. "The Original TR which led to this object/TR
            ENDIF.

            IF NOT line_exists( ct_obj_tr_log[
                                              pgmid = ls_tr_obj-pgmid
                                              object = ls_tr_obj-object
                                              obj_name = ls_tr_obj-obj_name
                                              trkorr = ls_tr_stat-trkorr ] ) and
               NOT line_exists( lt_obj_tr_log[
                                              pgmid = ls_tr_obj-pgmid
                                              object = ls_tr_obj-object
                                              obj_name = ls_tr_obj-obj_name
                                              trkorr = ls_tr_stat-trkorr ] ).
              "Add to the object level details/log
              CLEAR: ls_obj_tr_stat.
              ls_obj_tr_stat-pgmid = ls_tr_obj-pgmid.
              ls_obj_tr_stat-object = ls_tr_obj-object.
              ls_obj_tr_stat-obj_name = ls_tr_obj-obj_name.
              MOVE-CORRESPONDING ls_tr_stat TO ls_obj_tr_stat.
              APPEND ls_obj_tr_stat TO lt_obj_tr_log.
            ENDIF.
          ENDLOOP.
        ENDIF.

      ENDIF.
    ENDLOOP.

  ENDIF.


  IF lt_tr_log[] IS INITIAL AND
     lt_obj_tr_log[] IS INITIAL.
    "All TRs & Objects have been parsed to the bottom level
    "Nothing else to do
    EXIT.
  ENDIF.

*****  "We can wipe off the default imp/exp dates
*****  "For TRs which were never impoerted/exported
*****  CLEAR: ls_tr_stat.
*****  MODIFY lt_tr_log FROM ls_tr_stat TRANSPORTING prd_imp_dt WHERE prd_imp_dt = gv_c_override_dt.
*****  MODIFY lt_tr_log FROM ls_tr_stat TRANSPORTING qas_imp_dt WHERE qas_imp_dt = gv_c_override_dt.
*****  MODIFY lt_tr_log FROM ls_tr_stat TRANSPORTING dev_exp_dt WHERE dev_exp_dt = gv_c_override_dt.
*****  MODIFY lt_tr_log FROM ls_tr_stat TRANSPORTING prd_imp_ti WHERE prd_imp_ti = gv_c_override_tm.
*****  MODIFY lt_tr_log FROM ls_tr_stat TRANSPORTING qas_imp_ti WHERE qas_imp_ti = gv_c_override_tm.
*****  MODIFY lt_tr_log FROM ls_tr_stat TRANSPORTING dev_exp_ti WHERE dev_exp_ti = gv_c_override_tm.


  IF lt_tr_log[] IS NOT INITIAL.
    APPEND LINES OF lt_tr_log TO ct_tr_log.
  ENDIF.

  "The TRs for an object should appear in the right sequence
  CLEAR: lv_sequence.
  SORT lt_obj_tr_log BY pgmid ASCENDING object ASCENDING obj_name ASCENDING
                        prd_imp_dt ASCENDING prd_imp_ti ASCENDING
                        qas_imp_dt ASCENDING qas_imp_ti ASCENDING
                        dev_exp_dt ASCENDING dev_exp_ti ASCENDING.
  LOOP AT lt_obj_tr_log ASSIGNING FIELD-SYMBOL(<lfs_obj_stat>).
    ADD 1 TO lv_sequence.
    <lfs_obj_stat>-seq = lv_sequence.
    AT END OF obj_name.
      CLEAR: lv_sequence.
    ENDAT.
  ENDLOOP.

  "Once sequencing is done
  "We can wipe off the default imp/exp dates
  "For TRs which were never impoerted/exported
  CLEAR: ls_obj_tr_stat.
  MODIFY lt_obj_tr_log FROM ls_obj_tr_stat TRANSPORTING prd_imp_dt WHERE prd_imp_dt = gv_c_override_dt.
  MODIFY lt_obj_tr_log FROM ls_obj_tr_stat TRANSPORTING qas_imp_dt WHERE qas_imp_dt = gv_c_override_dt.
  MODIFY lt_obj_tr_log FROM ls_obj_tr_stat TRANSPORTING dev_exp_dt WHERE dev_exp_dt = gv_c_override_dt.
  MODIFY lt_obj_tr_log FROM ls_obj_tr_stat TRANSPORTING prd_imp_ti WHERE prd_imp_ti = gv_c_override_tm.
  MODIFY lt_obj_tr_log FROM ls_obj_tr_stat TRANSPORTING qas_imp_ti WHERE qas_imp_ti = gv_c_override_tm.
  MODIFY lt_obj_tr_log FROM ls_obj_tr_stat TRANSPORTING dev_exp_ti WHERE dev_exp_ti = gv_c_override_tm.

  IF lt_obj_tr_log[] IS NOT INITIAL.
    APPEND LINES OF lt_obj_tr_log TO ct_obj_tr_log.
  ENDIF.

  "Repeat activity for every TR which has not yet reached PRD
  LOOP AT lt_tr_log INTO DATA(ls_tr_log)
                    WHERE
                      trkorr CP 'UD1*' AND
                      prd_imp_dt EQ gv_c_override_dt."IS INITIAL.
    PERFORM tr_parser USING ls_tr_log-trkorr
                         iv_dev
                         iv_qa
                         iv_prd
                   CHANGING ct_tr_log
                            ct_obj_tr_log.
  ENDLOOP.
*****  ENDLOOP.
ENDFORM.

FORM display_alv.

  "We can wipe off the default imp/exp dates
  "For TRs which were never impoerted/exported
  "We do it at this stage, as the table was still being used in earlier stages to avoid DB lookup
  DATA ls_tr_stat TYPE yst_tr_stat.
  MODIFY gt_tr_stat FROM ls_tr_stat TRANSPORTING prd_imp_dt WHERE prd_imp_dt = gv_c_override_dt.
  MODIFY gt_tr_stat FROM ls_tr_stat TRANSPORTING qas_imp_dt WHERE qas_imp_dt = gv_c_override_dt.
  MODIFY gt_tr_stat FROM ls_tr_stat TRANSPORTING dev_exp_dt WHERE dev_exp_dt = gv_c_override_dt.
  MODIFY gt_tr_stat FROM ls_tr_stat TRANSPORTING prd_imp_ti WHERE prd_imp_ti = gv_c_override_tm.
  MODIFY gt_tr_stat FROM ls_tr_stat TRANSPORTING qas_imp_ti WHERE qas_imp_ti = gv_c_override_tm.
  MODIFY gt_tr_stat FROM ls_tr_stat TRANSPORTING dev_exp_ti WHERE dev_exp_ti = gv_c_override_tm.

  IF gv_obj_rep_first = abap_true.
    CALL SCREEN 1001.
  ELSE.
    CALL SCREEN 1002.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CREATE_FIELD_CAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_field_cat .
  git_fieldcat_obj = VALUE #(
                ( fieldname = 'PGMID'       col_pos = 1 ref_field = 'PGMID' ref_table = 'E071' )
                ( fieldname = 'OBJECT'      col_pos = 2 ref_field = 'OBJECT' ref_table = 'E071' )
                ( fieldname = 'OBJ_NAME'    col_pos = 3 ref_field = 'OBJ_NAME' ref_table = 'E071' )
                ( fieldname = 'SEQ'         col_pos = 4 reptext = 'Sequence' scrtext_l = 'Sequence' scrtext_m = 'Sequence' scrtext_s = 'Sequence' )
                ( fieldname = 'TRKORR'      col_pos = 5 ref_field = 'TRKORR' ref_table = 'E071' )
                ( fieldname = 'DEV_EXP_DT'  col_pos = 6 no_zero = abap_true reptext = 'Dev. Exp. Date' scrtext_l = 'Dev. Exp. Date' scrtext_m = 'Dev. Exp. Date' scrtext_s = 'Dev. Date' )
                ( fieldname = 'DEV_EXP_TI'  col_pos = 7 no_zero = abap_true reptext = 'Dev. Exp. Time' scrtext_l = 'Dev. Exp. Time' scrtext_m = 'Dev. Exp. Time' scrtext_s = 'Dev. Time' )
                ( fieldname = 'QAS_IMP_DT'  col_pos = 8 no_zero = abap_true reptext = 'Qas. Imp. Date' scrtext_l = 'Qas. Imp. Date' scrtext_m = 'Qas. Imp. Date' scrtext_s = 'Qas. Date' )
                ( fieldname = 'QAS_IMP_TI'  col_pos = 9 no_zero = abap_true reptext = 'Qas. Imp. Time' scrtext_l = 'Qas. Imp. Time' scrtext_m = 'Qas. Imp. Time' scrtext_s = 'Qas. Time' )
                ( fieldname = 'PRD_IMP_DT'  col_pos = 10 no_zero = abap_true reptext = 'Prd. Imp. Date' scrtext_l = 'Prd. Imp. Date' scrtext_m = 'Prd. Imp. Date' scrtext_s = 'Prd. Date' )
                ( fieldname = 'PRD_IMP_TI'  col_pos = 11 no_zero = abap_true reptext = 'Prd. Imp. Time' scrtext_l = 'Prd. Imp. Time' scrtext_m = 'Prd. Imp. Time' scrtext_s = 'Prd. Time' )
                ( fieldname = 'ROOT_TRKORR' col_pos = 12 reptext = 'Root TR' scrtext_l = 'Higher Level TR' scrtext_m = 'High Lvl TR' scrtext_s = 'Root TR' )

               ).

  git_fieldcat_tr = VALUE #(
*****                ( fieldname = 'PGMID'       col_pos = 1 ref_field = 'PGMID' ref_table = 'E071' )
*****                ( fieldname = 'OBJECT'      col_pos = 2 ref_field = 'OBJECT' ref_table = 'E071' )
*****                ( fieldname = 'OBJ_NAME'    col_pos = 3 ref_field = 'OBJ_NAME' ref_table = 'E071' )
*****                ( fieldname = 'SEQ'         col_pos = 4 reptext = 'Sequence' scrtext_l = 'Sequence' scrtext_m = 'Sequence' scrtext_s = 'Sequence' )
                ( fieldname = 'TRKORR'      col_pos = 1 ref_field = 'TRKORR' ref_table = 'E071' )
                ( fieldname = 'DEV_EXP_DT'  col_pos = 2 no_zero = abap_true reptext = 'Dev. Exp. Date' scrtext_l = 'Dev. Exp. Date' scrtext_m = 'Dev. Exp. Date' scrtext_s = 'Dev. Date' )
                ( fieldname = 'DEV_EXP_TI'  col_pos = 3 no_zero = abap_true reptext = 'Dev. Exp. Time' scrtext_l = 'Dev. Exp. Time' scrtext_m = 'Dev. Exp. Time' scrtext_s = 'Dev. Time' )
                ( fieldname = 'QAS_IMP_DT'  col_pos = 4 no_zero = abap_true reptext = 'Qas. Imp. Date' scrtext_l = 'Qas. Imp. Date' scrtext_m = 'Qas. Imp. Date' scrtext_s = 'Qas. Date' )
                ( fieldname = 'QAS_IMP_TI'  col_pos = 5 no_zero = abap_true reptext = 'Qas. Imp. Time' scrtext_l = 'Qas. Imp. Time' scrtext_m = 'Qas. Imp. Time' scrtext_s = 'Qas. Time' )
                ( fieldname = 'PRD_IMP_DT'  col_pos = 6 no_zero = abap_true reptext = 'Prd. Imp. Date' scrtext_l = 'Prd. Imp. Date' scrtext_m = 'Prd. Imp. Date' scrtext_s = 'Prd. Date' )
                ( fieldname = 'PRD_IMP_TI'  col_pos = 7 no_zero = abap_true reptext = 'Prd. Imp. Time' scrtext_l = 'Prd. Imp. Time' scrtext_m = 'Prd. Imp. Time' scrtext_s = 'Prd. Time' )
                ( fieldname = 'ROOT_TRKORR' col_pos = 8 reptext = 'Root TR' scrtext_l = 'Higher Level TR' scrtext_m = 'High Lvl TR' scrtext_s = 'Root TR' )
               ).

ENDFORM.

FORM update_layout.
  gwa_layout_obj-cwidth_opt = abap_true.
  gwa_layout_tr-cwidth_opt = abap_true.
ENDFORM.

FORM clear_alv_obj CHANGING cr_grid TYPE REF TO cl_gui_alv_grid
                            cr_cntr TYPE REF TO cl_gui_custom_container.
*****  CALL METHOD cl_gui_cfw=>flush.

  "Ensure existing ALV related references, if any, are cleared
  "We could not get this working with local objects
  "The custom container does not seem to get refreshed
  IF cr_grid IS BOUND.
*****    CALL METHOD cl_gui_cfw=>flush.
    TRY.
        cr_grid->free( EXCEPTIONS OTHERS = 1 ).
        IF sy-subrc <> 0.
          CLEAR: cr_grid.
        ENDIF.
      CATCH cx_root.
        CLEAR: cr_grid.
    ENDTRY.
    CLEAR: cr_grid.
  ENDIF.
  IF cr_cntr IS BOUND.
*****    CALL METHOD cl_gui_cfw=>flush.
    TRY.
        cr_cntr->free( EXCEPTIONS OTHERS = 1 ).
        IF sy-subrc <> 0.
          CLEAR: cr_grid.
        ENDIF.
      CATCH cx_root.
        CLEAR: cr_cntr.
    ENDTRY.
    CLEAR: cr_cntr.
  ENDIF.


ENDFORM.
