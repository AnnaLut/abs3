CREATE OR REPLACE VIEW BARS.V_OB_CORPORATION_SESSION
(
   ID,
   MFO,
   MFO_NAME,
   FILE_DATE,
   CORPORATION,
   STATE,
   SYNCTIME
)
AS
     SELECT T1.ID AS id,
            TO_CHAR (T1.KF) AS mfo,
            b.nb AS mfo_name,
            TO_CHAR (T1.FILE_DATE, 'DD.MM.YYYY') AS file_date,
            DECODE (T1.FILE_CORPORATION_ID,
                    NULL, '��',
                    T1.FILE_CORPORATION_ID)
               AS corporation,
            DECODE (T1.STATE_ID,
                    NULL, '�����',
                    0, '�����',
                    1, '���������',
                    2, '��������� � ���������',
                    3, '������� �����')
               AS state,
            to_char(SYS_TIME,'dd.mm.yyyy hh24:mi:ss') AS synctime
       FROM BARS.ob_corporation_session t1
            LEFT JOIN bars.banks b ON t1.KF = b.mfo
   ORDER BY 1 DESC;

COMMENT ON TABLE BARS.V_OB_CORPORATION_SESSION IS '���� ������������ ��� �-�����';



GRANT SELECT ON BARS.V_OB_CORPORATION_SESSION TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_OB_CORPORATION_SESSION TO CORP_CLIENT;
