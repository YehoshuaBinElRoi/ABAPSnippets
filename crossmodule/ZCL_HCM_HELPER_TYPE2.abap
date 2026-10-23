class ZCL_HCM_HELPER definition
  public
  final
  create public .

public section.

  constants FACTORY_CALENDAR type TFACD-IDENT value 'ZA' ##NO_TEXT.

  class-methods GET_NTH_DAY
    importing
      !DATE type SY-DATUM optional
      !DAYS type I optional
      !CALENDAR1 type TFACD-IDENT optional
      !CALENDAR2 type TFACD-IDENT optional
    exporting
      !NTH_DATE type SY-DATUM
      !RETURN_CODE type SY-SUBRC .
  class-methods COUNT_WORKING_DAYS
    importing
      !START_DATE type SY-DATUM
      !END_DATE type SY-DATUM
      !CALENDAR type TFACD-IDENT
      !WEEKENDS_ARE_HOLIDAYS type BOOLE_D default ABAP_TRUE
    returning
      value(WORKING_DAYS) type INT4 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HCM_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>COUNT_WORKING_DAYS
* +-------------------------------------------------------------------------------------------------+
* | [--->] START_DATE                     TYPE        SY-DATUM
* | [--->] END_DATE                       TYPE        SY-DATUM
* | [--->] CALENDAR                       TYPE        TFACD-IDENT
* | [--->] WEEKENDS_ARE_HOLIDAYS          TYPE        BOOLE_D (default =ABAP_TRUE)
* | [<-()] WORKING_DAYS                   TYPE        INT4
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD count_working_days.
*----------------------------------------------------------------------*
* Developer: HGIOOPA (VVAOAS)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BVOPPJ                               *
* Change Indicator: BVOPPJ-MPBASDFU-VVAOAS                         *
* Description: Count number of working days, using calendar in HCM     *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BVOPPJ-MPBASDFU-VVAOAS-23 Oct 2026
    "Get the RFC destination of the HR system
    DATA(rfc_dest) = zcl_erec_helper=>get_hr_rfc_destination( ).

    CALL FUNCTION 'ZHCM_RFC_COUNT_WORKDAYS'
      DESTINATION rfc_dest
      EXPORTING
        start_date            = start_date
        end_date              = end_date
        calendar              = calendar
        weekends_are_holidays = weekends_are_holidays
      IMPORTING
        working_days          = working_days.

*<<<End of Changes-BVOPPJ-MPBASDFU-VVAOAS-23 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_HCM_HELPER=>GET_NTH_DAY
* +-------------------------------------------------------------------------------------------------+
* | [--->] DATE                           TYPE        SY-DATUM(optional)
* | [--->] DAYS                           TYPE        I(optional)
* | [--->] CALENDAR1                      TYPE        TFACD-IDENT(optional)
* | [--->] CALENDAR2                      TYPE        TFACD-IDENT(optional)
* | [<---] NTH_DATE                       TYPE        SY-DATUM
* | [<---] RETURN_CODE                    TYPE        SY-SUBRC
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_nth_day.
*----------------------------------------------------------------------*
* Developer: HGIOOPA (VVAOAS)                       *
* Date:      27 Aug 2026                                               *
* Reference Change/Incident:  BVOPPJ                               *
* Change Indicator: BVOPPJ-MPBASDFU-VVAOAS                         *
* Description: Get the Nth day as per HR System                        *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-BVOPPJ-MPBASDFU-VVAOAS-15 Oct 2026
    "Get the RFC destination of the HR system
    DATA(rfc_dest) = zcl_erec_helper=>get_hr_rfc_destination( ).

    CALL FUNCTION 'ZHCM_RFC_BKK_ADD_WORKINGDAY'
      DESTINATION rfc_dest
      EXPORTING
        date        = date
        days        = days
        calendar1   = calendar1
        calendar2   = calendar2
      IMPORTING
        nth_date    = nth_date
        return_code = return_code.

*<<<End of Changes-BVOPPJ-MPBASDFU-VVAOAS-15 Oct 2026
  ENDMETHOD.
ENDCLASS.
