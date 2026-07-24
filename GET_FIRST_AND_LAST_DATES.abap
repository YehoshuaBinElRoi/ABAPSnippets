 class-methods GET_FIRST_AND_LAST_DATES
    importing
      !CALENDAR_VARIANT type PERIV default 'K4'
      !PERIOD type SPMON optional
      !MONTH type CHAR02 optional
      !YEAR type CHAR04 optional
    returning
      value(DATES) type RANGE_DATE .

 METHOD get_first_and_last_dates.
    IF period IS NOT INITIAL.
      DATA(month_lcl) = period+4(2).
      DATA(year_lcl) = period+0(4).
    ELSE.
      month_lcl = month.
      year_lcl = year.
    ENDIF.

    IF month_lcl IS INITIAL."If no month is provided, we assumed we need to return first and last dates of whole year
      DATA(first_month) = '01'. "Get first date of first month
      DATA(last_month) = '12'. "Get last date of 12th month
    ELSE.
      first_month = last_month = month_lcl."Get first and last date of given month
    ENDIF.

    INSERT INITIAL LINE INTO dates ASSIGNING FIELD-SYMBOL(<dates>).
    <dates>-sign = 'I'.
    <dates>-option = 'BT'.

    CALL FUNCTION 'FIRST_DAY_IN_PERIOD_GET'
      EXPORTING
        i_gjahr = year_lcl
*       I_MONMIT             = 00
        i_periv = calandar_variant
        i_poper = first_month
      IMPORTING
        e_date  = <dates>-low
* EXCEPTIONS
*       INPUT_FALSE          = 1
*       T009_NOTFOUND        = 2
*       T009B_NOTFOUND       = 3
*       OTHERS  = 4
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    CALL FUNCTION 'LAST_DAY_IN_PERIOD_GET'
      EXPORTING
        i_gjahr = year
*       I_MONMIT             = 00
        i_periv = calandar_variant
        i_poper = last_month
      IMPORTING
        e_date  = <dates>-high
* EXCEPTIONS
*       INPUT_FALSE          = 1
*       T009_NOTFOUND        = 2
*       T009B_NOTFOUND       = 3
*       OTHERS  = 4
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.
