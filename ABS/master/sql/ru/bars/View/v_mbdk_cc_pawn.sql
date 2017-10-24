CREATE OR REPLACE VIEW v_mbdk_cc_pawn as
SELECT pawn,
       name,
       pr_rez,
       nbsz,
       nbsz1,
       nbsz2,
       nbsz3,
       s031,
       kat,
       d_close,
       code,
       s031_279,
       name_279,
       pawn_23,
       grp23,
       ob22_fo,
       ob22_uo,
       ob22_u0
FROM cc_pawn;

GRANT SELECT ON V_MBDK_CC_PAWN TO bars_access_defrole;

COMMENT ON TABLE BARS.V_MBDK_CC_PAWN IS '����: ���� �����������';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.PAWN IS '��� ���� ������������ (�������� ���� ���������� �� ���� ���)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NAME IS '������������ ���� ������������';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.PR_REZ IS '�� ������������';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ IS '���������� ������� ������� 1 (��� ���� �������� ������� ������� � ���������� �������)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ1 IS '���������� ���� ������ 2 (��� ����������� ������ ������ � ��������� ��������)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ2 IS '���������� ������� ������� 2 (��� ������������ ������� ������� � ���������� �������)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ3 IS '���������� ������� ������� 4 (��� ���� �������� ������� ������� � ���������� �������)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.S031 IS '��� ���� ������� �� ������������� ���';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.CODE IS 'C��������� ���';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.OB22_FO IS '�������� ��22 ��� ��';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.OB22_UO IS '�������� ��22 ��� ��';