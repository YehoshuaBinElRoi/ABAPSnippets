* | Static Public Method ZCL_MM_INV_REPORTS=>PERIOD_RANGE_TO_DATE_RANGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] PERIOD_RANGES                  TYPE        RANGE_POSTING_MONTH
* | [<-()] DATE_RANGES                    TYPE        RANGE_DATE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD period_range_to_date_range.
    LOOP AT period_ranges INTO DATA(period_range).
      IF period_range-low IS NOT INITIAL.
        DATA(start_period_dates) = get_first_and_last_dates( period = period_range-low ).
        IF period_range-high IS NOT INITIAL."Start and end months are provided
          DATA(end_period_dates) = get_first_and_last_dates( period = period_range-high ).
          DATA(start_date) = start_period_dates[ 1 ]-low.
          DATA(end_date) = end_period_dates[ 1 ]-high.
        ELSE."Just start month
          start_date = start_period_dates[ 1 ]-low.
          end_date = start_period_dates[ 1 ]-high.
        ENDIF.
      ELSE.
        IF period_range-high IS NOT INITIAL."Just end month is provided
          end_period_dates = get_first_and_last_dates( period = period_range-high ).
          end_date = start_period_dates[ 1 ]-low.
          end_date = start_period_dates[ 1 ]-high.
        ELSE."No Start or end month provided
        ENDIF.
      ENDIF.
      date_ranges = VALUE #( BASE date_ranges
        ( sign = 'I' option = 'BT' low = start_date high = end_date )
      ).
      CLEAR: start_period_dates,
             end_period_dates,
             start_date,
             end_date.
    ENDLOOP.
  ENDMETHOD.
