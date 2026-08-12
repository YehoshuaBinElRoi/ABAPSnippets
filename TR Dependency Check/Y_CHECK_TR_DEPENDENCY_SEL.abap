*&---------------------------------------------------------------------*
*&  Include           Y_CHECK_TR_DEPENDENCY_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK chklvl WITH FRAME TITLE text-001.
PARAMETERS: p_rip RADIOBUTTON GROUP grp1 DEFAULT 'X',
            p_one RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK chklvl.

SELECTION-SCREEN BEGIN OF BLOCK fstrep WITH FRAME TITLE text-002.
PARAMETERS: p_obj RADIOBUTTON GROUP grp2 DEFAULT 'X',
            p_trs RADIOBUTTON GROUP grp2.
SELECTION-SCREEN END OF BLOCK fstrep.

SELECTION-SCREEN BEGIN OF BLOCK inpt WITH FRAME TITLE text-003.
SELECT-OPTIONS: "p_pgmid TYPE pgmid,
            "p_otype TYPE trobjtype,
            "p_oname TYPE trobj_name,

            s_tr FOR e071-trkorr NO INTERVALS.

PARAMETERS: p_dev TYPE tstrfcofil-tarsystem DEFAULT 'UD1',
            p_qa  TYPE tstrfcofil-tarsystem DEFAULT 'UQ1',
            p_prd TYPE tstrfcofil-tarsystem DEFAULT 'ECP'.
SELECTION-SCREEN END OF BLOCK inpt.
