class ZCL_DMS_HELPER_001 definition
  public
  create public .

public section.

  types:
    BEGIN OF raw_document_content,
        length           TYPE sapb-length,
        document_content TYPE /ixos/bf_tt_docs,
      END OF raw_document_content .
  types:
    BEGIN OF binary_document_content,
        length           TYPE sapb-length,
        document_content TYPE /ixos/bf_tt_docs_bin,
      END OF binary_document_content .
  types:
    BEGIN OF document_type_id_map_line,
        type            TYPE char03, "BIN/ARC
        bin_doc_id      TYPE sibfboriid,
        archive_id      TYPE saearchivi,
        archive_doc_id  TYPE saeardoid,
        archive_doc_cls TYPE saedoktyp,
      END OF document_type_id_map_line .
  types:
    document_type_id_map TYPE STANDARD TABLE OF document_type_id_map_line WITH EMPTY KEY .
  types:
    archive_file_attributes TYPE STANDARD TABLE OF toaat WITH EMPTY KEY .

  constants DOC_TYPE_ARCHIVE type CHAR03 value 'ARC' ##NO_TEXT.
  constants DOC_TYPE_BINARY type CHAR03 value 'BIN' ##NO_TEXT.
  constants MSGID type SYMSGID value 'ZDMS' ##NO_TEXT.
  constants MSGNO_GET_ERROR type SYMSGNO value '051' ##NO_TEXT.
  constants MSGNO_PUT_ERROR type SYMSGNO value '052' ##NO_TEXT.

  methods READ_LINKS
    importing
      !OBJECT_TYPE_IDENTIFIER type SIBFLPORB
      !RELATIONS_TO_READ type OBL_T_RELT
    returning
      value(LINKS) type DOCUMENT_TYPE_ID_MAP .
  methods DISPLAY_DOCUMENT
    importing
      !DOCUMENT_DETAIL type DOCUMENT_TYPE_ID_MAP_LINE
    exporting
      !RAW_DOCUMENT_CONTENT type RAW_DOCUMENT_CONTENT
      !BINARY_DOCUMENT_CONTENT type BINARY_DOCUMENT_CONTENT .
  methods GET_DOCUMENT
    importing
      !DOCUMENT_DETAIL type DOCUMENT_TYPE_ID_MAP_LINE
    exporting
      !RAW_DOCUMENT_CONTENT type RAW_DOCUMENT_CONTENT
      !BINARY_DOCUMENT_CONTENT type BINARY_DOCUMENT_CONTENT
      !MESSAGE type WZRE_MESSAGE .
  methods PUT_DOCUMENT
    importing
      !RAW_DOCUMENT_CONTENT type RAW_DOCUMENT_CONTENT optional
      !BINARY_DOCUMENT_CONTENT type BINARY_DOCUMENT_CONTENT optional
    exporting
      !MESSAGE type WZRE_MESSAGE
    changing
      !DOCUMENT_DETAIL type DOCUMENT_TYPE_ID_MAP_LINE .
  methods UPLOAD_DOCUMENT
    exporting
      !MESSAGE type WZRE_MESSAGE
    changing
      !DOCUMENT_DETAIL type DOCUMENT_TYPE_ID_MAP_LINE .
protected section.
private section.

  methods READ_LINKS_BINARY
    importing
      !OBJECT_TYPE_IDENTIFIER type SIBFLPORB
      !RELATIONS_TO_READ type OBL_T_RELT
    returning
      value(LINKS) type OBL_T_LINK .
  methods READ_LINKS_ARCHIV
    importing
      !OBJECT_TYPE type SAEANWDID
      !OBJECT_ID type SAEOBJID
    exporting
      !LINKS type TOAV0_T
      !ATTRIBUTES type ARCHIVE_FILE_ATTRIBUTES .
ENDCLASS.



CLASS ZCL_DMS_HELPER_001 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DMS_HELPER_001->DISPLAY_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] DOCUMENT_DETAIL                TYPE        DOCUMENT_TYPE_ID_MAP_LINE
* | [<---] RAW_DOCUMENT_CONTENT           TYPE        RAW_DOCUMENT_CONTENT
* | [<---] BINARY_DOCUMENT_CONTENT        TYPE        BINARY_DOCUMENT_CONTENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD display_document.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      26 Jun 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
* Description: Display a document                                      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026

    DATA: archive_display_rc TYPE int4.

    IF document_detail-type = doc_type_archive.
      CALL FUNCTION 'ARCHIVOBJECT_DISPLAY'
        EXPORTING
          archiv_doc_id            = document_detail-archive_doc_id
          archiv_id                = document_detail-archive_id
        IMPORTING
          returncode               = archive_display_rc
        EXCEPTIONS
          error_archiv             = 1
          error_communicationtable = 2
          error_kernel             = 3
          OTHERS                   = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ELSE.
        IF raw_document_content IS REQUESTED OR
           binary_document_content IS  REQUESTED."If caller requested document content, return it
          get_document(
          EXPORTING
            document_detail = document_detail
          IMPORTING
            raw_document_content = raw_document_content
            binary_document_content = binary_document_content
          ).
        ENDIF.
      ENDIF.
    ELSEIF document_detail-type = doc_type_binary.
      "<TBD>FM SO_DOCUMENT_READ_API1 can be used
    ENDIF.
*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DMS_HELPER_001->GET_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] DOCUMENT_DETAIL                TYPE        DOCUMENT_TYPE_ID_MAP_LINE
* | [<---] RAW_DOCUMENT_CONTENT           TYPE        RAW_DOCUMENT_CONTENT
* | [<---] BINARY_DOCUMENT_CONTENT        TYPE        BINARY_DOCUMENT_CONTENT
* | [<---] MESSAGE                        TYPE        WZRE_MESSAGE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_document.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      26 Jun 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
* Description: Display a document                                      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026

    DATA: archive_display_rc TYPE int4.

    IF document_detail-type = doc_type_archive.

      CALL FUNCTION 'ARCHIVOBJECT_GET_TABLE'
        EXPORTING
          archiv_id                = document_detail-archive_id
          document_type            = document_detail-archive_doc_cls
          archiv_doc_id            = document_detail-archive_doc_id
*         ALL_COMPONENTS           =
*         SIGNATURE                = 'X'
*         COMPID                   = 'data'
        IMPORTING
          length                   = raw_document_content-length
          binlength                = binary_document_content-length
        TABLES
          archivobject             = raw_document_content-document_content
          binarchivobject          = binary_document_content-document_content
        EXCEPTIONS
          error_archiv             = 1
          error_communicationtable = 2
          error_kernel             = 3
          OTHERS                   = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
        IF sy-msgid IS NOT INITIAL.
          message = CORRESPONDING #( sy ).
        ELSE.
          message = VALUE #(
            msgid = msgid
            msgty = 'E'
            msgno = msgno_get_error
          ).
        ENDIF.
      ELSE.

      ENDIF.
    ELSEIF document_detail-type = doc_type_binary.
      "<TBD>FM SO_DOCUMENT_READ_API1 can be used
    ENDIF.
*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DMS_HELPER_001->PUT_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] RAW_DOCUMENT_CONTENT           TYPE        RAW_DOCUMENT_CONTENT(optional)
* | [--->] BINARY_DOCUMENT_CONTENT        TYPE        BINARY_DOCUMENT_CONTENT(optional)
* | [<---] MESSAGE                        TYPE        WZRE_MESSAGE
* | [<-->] DOCUMENT_DETAIL                TYPE        DOCUMENT_TYPE_ID_MAP_LINE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD put_document.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
* Description: Upload a document to DMS                                *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-15 Oct 2026
    CALL FUNCTION 'ARCHIVOBJECT_CREATE_TABLE'
      EXPORTING
        archiv_id                = document_detail-archive_id
        arc_doc_id               = document_detail-archive_doc_id
        document_type            = document_detail-archive_doc_cls
*       LENGTH                   =
*       COMPID                   = 'data'
*       SIGNATURE                = 'X'
*       VSCAN_PROFILE            = '/SCMS/KPRO_CREATE'
      IMPORTING
        archiv_doc_id            = document_detail-archive_doc_id
      TABLES
*       archivobject             = raw_document_content-document_content
*       COMPONENTS               =
        binarchivobject          = binary_document_content-document_content
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        blocked_by_policy        = 4
        OTHERS                   = 5.
    IF sy-subrc <> 0.
* Implement suitable error handling here
      IF sy-msgid IS NOT INITIAL.
        message = CORRESPONDING #( sy ).
      ELSE.
        message = VALUE #(
          msgid = msgid
          msgty = 'E'
          msgno = msgno_put_error
        ).
      ENDIF.
    ENDIF.
*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-15 Oct 2026


  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DMS_HELPER_001->READ_LINKS
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT_TYPE_IDENTIFIER         TYPE        SIBFLPORB
* | [--->] RELATIONS_TO_READ              TYPE        OBL_T_RELT
* | [<-()] LINKS                          TYPE        DOCUMENT_TYPE_ID_MAP
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD READ_LINKS.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      26 Jun 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
* Description: Read items linked to the given document                 *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
    "COMMENTING - Use case not in current development
*****    "Read if there are binary links
*****    DATA(bin_links) = read_links_binary(
*****    object_type_identifier = object_type_identifier
*****    relations_to_read = relations_to_read
*****    ).
*****
*****    "BIN_LINKS-INSTID_B contains the unique attachmet identifier which can be used in SO_DOCUMENT_READ_API1
*****    links = VALUE #( BASE links
*****      FOR bin_link IN bin_links
*****      (
*****        type = doc_type_binary
*****        bin_doc_id = bin_link-instid_b
*****      )
*****    ).
    "END OF COMMENTING - Use case not in current development

    "Read, if there are archive links
    read_links_archiv(
    EXPORTING
      object_type = CONV #( object_type_identifier-typeid )
      object_id   = CONV #( object_type_identifier-instid )
    IMPORTING
      links = DATA(arc_links)
      attributes = DATA(arc_attribs)
    ).
    links = VALUE #( BASE links
      FOR arc_link IN arc_links
      (
        type            = doc_type_archive
        archive_id      = arc_link-archiv_id
        archive_doc_id  = arc_link-arc_doc_id
      )
    ).
*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_DMS_HELPER_001->READ_LINKS_ARCHIV
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT_TYPE                    TYPE        SAEANWDID
* | [--->] OBJECT_ID                      TYPE        SAEOBJID
* | [<---] LINKS                          TYPE        TOAV0_T
* | [<---] ATTRIBUTES                     TYPE        ARCHIVE_FILE_ATTRIBUTES
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD READ_LINKS_ARCHIV.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      26 Jun 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
* Description: Attempt to read links from Archive                      *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
    CALL FUNCTION 'ARCHIV_GET_CONNECTIONS'
      EXPORTING
        objecttype      = object_type
        object_id       = object_id
      TABLES
        connections     = links
        file_attributes = attributes
      EXCEPTIONS
        nothing_found   = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_DMS_HELPER_001->READ_LINKS_BINARY
* +-------------------------------------------------------------------------------------------------+
* | [--->] OBJECT_TYPE_IDENTIFIER         TYPE        SIBFLPORB
* | [--->] RELATIONS_TO_READ              TYPE        OBL_T_RELT
* | [<-()] LINKS                          TYPE        OBL_T_LINK
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD READ_LINKS_BINARY.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      26 Jun 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
* Description: Reading Binary Links                                    *
*----------------------------------------------------------------------*
*-------------------------CHANGE HISTORY-------------------------------*
*----------------------------------------------------------------------*
* Developer:                                                           *
* Date:                                                                *
* Reference Change/Incident:                                           *
* Change Indicator:                                                    *
* Description:                                                         *
*----------------------------------------------------------------------*

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026


    cl_binary_relation=>read_links(
             EXPORTING
               is_object           = object_type_identifier
               it_relation_options = relations_to_read
             IMPORTING
               et_links            = links ).

*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-02 Jul 2026
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DMS_HELPER_001->UPLOAD_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [<---] MESSAGE                        TYPE        WZRE_MESSAGE
* | [<-->] DOCUMENT_DETAIL                TYPE        DOCUMENT_TYPE_ID_MAP_LINE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD upload_document.
*----------------------------------------------------------------------*
* Developer: AAAAAAAAAAAAAAAAAAA (AJRTHDU)                       *
* Date:      12 Aug 2026                                               *
* Reference Change/Incident:  JAHSDUND                               *
* Change Indicator: JAHSDUND-WERFT-AJRTHDU                         *
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

*>>>Start of Changes-JAHSDUND-WERFT-AJRTHDU-15 Oct 2026
    DATA: bin255  TYPE solix_tab,
          bin1024 TYPE fkk_tbl1024_t.
    DATA(file_path) = zcl_abap_helper_005=>f4_help_file_path( ).

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

    "Convert SOLIX Binary to DMS Compatible Binary
    zcl_abap_helper_005=>conv_bin_255_to_1024(
    EXPORTING
      bin_255 = bin255
      length = file_length
    IMPORTING
      bin_1024 = bin1024
    ).

    "Upload the document to archive
    DATA(binary_document_content) = VALUE binary_document_content( document_content = bin1024 ).
    put_document(
    EXPORTING
"RAW_DOCUMENT_CONTENT
      binary_document_content = binary_document_content
    IMPORTING
      message = message
    CHANGING
      document_detail = document_detail
    ).

*<<<End of Changes-JAHSDUND-WERFT-AJRTHDU-15 Oct 2026
  ENDMETHOD.
ENDCLASS.
