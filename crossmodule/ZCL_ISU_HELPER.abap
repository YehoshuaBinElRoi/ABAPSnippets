class ZCL_ISU_HELPER definition
  public
  final
  create public .

public section.

  class-methods GET_ZCONTACT_PERSON_DETAILS
    importing
      !IV_VKONT type VKONT_KK optional
      !IT_VKONT type TVKONT optional
    exporting
      !ET_CONT_PERS type ZTT_ISU_FICA_CP_DET .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ISU_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ISU_HELPER=>GET_ZCONTACT_PERSON_DETAILS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VKONT                       TYPE        VKONT_KK(optional)
* | [--->] IT_VKONT                       TYPE        TVKONT(optional)
* | [<---] ET_CONT_PERS                   TYPE        ZTT_ISU_FICA_CP_DET
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_zcontact_person_details.
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer: ASDFBHH (KPASD)                       *
* Date:      24th Mar 2026                                             *
* Reference Change/Incident:  JOASDNO                               *
* Change Indicator: JOASDNO-BPSDFM-KPASD                         *
* Description: Retrieve Contact person details                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JOASDNO-BPSDFM-KPASD-24th Mar 2026
    DATA: lt_vkont  TYPE tvkont.


    "Create a dummy table with OTHER*
    DATA(lt_other_ca) = VALUE tvkont(
      ( 'OTHER' )
      ( 'Other' )
      ( 'OTHERS' )
      ( 'Others' )
    ).

    lt_vkont = it_vkont.

    IF iv_vkont IS NOT INITIAL.
      APPEND iv_vkont TO lt_vkont.
    ENDIF.

    IF lt_vkont[] IS NOT INITIAL.
      SELECT * FROM zisu_fica_cp_det
               INTO TABLE et_cont_pers
               FOR ALL ENTRIES IN lt_vkont
               WHERE
                vkont = lt_vkont-table_line.

      "Backup contact person details
      SELECT * FROM zisu_fica_cp_det
               INTO TABLE @DATA(lt_cont_pers_oth)
               FOR ALL ENTRIES IN @lt_other_ca
               WHERE
                vkont = @lt_other_ca-table_line .
      DATA(ls_cont_pers_oth) = lt_cont_pers_oth[ 1 ].
    ENDIF.

    LOOP AT lt_vkont INTO DATA(lv_vkont).
      IF line_exists( et_cont_pers[ vkont = lv_vkont ] )."Contact maintained for the account
      ELSE."Contact not maintained, use the alternative contact
        ls_cont_pers_oth-vkont = lv_vkont.
        APPEND ls_cont_pers_oth TO et_cont_pers.
      ENDIF.
    ENDLOOP.

*<<<End of Changes-JOASDNO-BPSDFM-KPASD-24th Mar 2026
  ENDMETHOD.
ENDCLASS.
