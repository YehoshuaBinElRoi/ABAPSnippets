class ZCL_FILE_STORE_HELPER definition
  public
  final
  create public .

public section.

  class-methods GET_FILE_DATA
    importing
      !FILE_ID type ZXX_FILE_DATA-FILE_ID
    returning
      value(FILE_DATA) type ZXX_FILE_DATA-XSTRING_DATA .
  class-methods PUT_FILE_DATA
    importing
      !FILE_ID type ZXX_FILE_DATA-FILE_ID
      !FILE_DATA type ZXX_FILE_DATA-XSTRING_DATA
    exporting
      !RETURN_CODE type SUBRC .
  class-methods UPLOAD_FILE
    importing
      !FILE_ID type ZXX_FILE_DATA-FILE_ID
    exporting
      !FILE_DATA type ZXX_FILE_DATA-XSTRING_DATA
      !MESSAGE type WZRE_MESSAGE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FILE_STORE_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_FILE_STORE_HELPER=>GET_FILE_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] FILE_ID                        TYPE        ZXX_FILE_DATA-FILE_ID
* | [<-()] FILE_DATA                      TYPE        ZXX_FILE_DATA-XSTRING_DATA
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_FILE_DATA.
*----------------------------------------------------------------------*
* Developer: AAAAAAA (KLPASDJO)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  MJAISDL                               *
* Change Indicator: MJAISDL-PJASDNO-KLPASDJO                         *
* Description: Retrieve file content from DB                           *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-MJAISDL-PJASDNO-KLPASDJO-15 Oct 2026
    "Get the content of a file
    SELECT SINGLE xstring_data
           FROM   zxx_file_data
           INTO   @file_data
           WHERE
            file_id = @file_id.
*<<<End of Changes-MJAISDL-PJASDNO-KLPASDJO-15 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_FILE_STORE_HELPER=>PUT_FILE_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] FILE_ID                        TYPE        ZXX_FILE_DATA-FILE_ID
* | [--->] FILE_DATA                      TYPE        ZXX_FILE_DATA-XSTRING_DATA
* | [<---] RETURN_CODE                    TYPE        SUBRC
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD PUT_FILE_DATA.
*----------------------------------------------------------------------*
* Developer: AAAAAAA (KLPASDJO)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  MJAISDL                               *
* Change Indicator: MJAISDL-PJASDNO-KLPASDJO                         *
* Description: Update file content to DB                               *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-MJAISDL-PJASDNO-KLPASDJO-15 Oct 2026
    DATA(db_file_data) = VALUE zxx_file_data(
      file_id = file_id
      xstring_data = file_data
    ).
    "Update the content of a file
    MODIFY zxx_file_data
           FROM   db_file_data.

    return_code = sy-subrc.
*<<<End of Changes-MJAISDL-PJASDNO-KLPASDJO-15 Oct 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_FILE_STORE_HELPER=>UPLOAD_FILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] FILE_ID                        TYPE        ZXX_FILE_DATA-FILE_ID
* | [<---] FILE_DATA                      TYPE        ZXX_FILE_DATA-XSTRING_DATA
* | [<---] MESSAGE                        TYPE        WZRE_MESSAGE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD upload_file.
*----------------------------------------------------------------------*
* Developer: AAAAAAA (KLPASDJO)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  MJAISDL                               *
* Change Indicator: MJAISDL-PJASDNO-KLPASDJO                         *
* Description: Get a file path from user and upload to DMS             *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-MJAISDL-PJASDNO-KLPASDJO-15 Oct 2026
    DATA: bin255  TYPE solix_tab,
          bin1024 TYPE fkk_tbl1024_t.
    DATA(file_path) = zcl_abap_helper_005=>f4_help_file_path( open_mode = abap_true ).

    CHECK file_path IS NOT INITIAL.

    "Get the file in binary format
    cl_gui_frontend_services=>gui_upload(
    EXPORTING
      filename   = |{ file_path }|
      filetype   = 'BIN'
    IMPORTING
      filelength = DATA(file_length)
    CHANGING
      data_tab   = bin255
    ).

    file_data = cl_bcs_convert=>solix_to_xstring( bin255 ).

    "Upload the document to archive
    put_file_data(
    EXPORTING
      file_id = file_id
      file_data = file_data
    IMPORTING
      return_code = DATA(return_code)
    ).

*<<<End of Changes-MJAISDL-PJASDNO-KLPASDJO-15 Oct 2026
  ENDMETHOD.
ENDCLASS.
