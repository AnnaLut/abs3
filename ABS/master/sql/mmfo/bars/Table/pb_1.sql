

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PB_1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PB_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PB_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PB_1'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PB_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PB_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PB_1 
   (	LN CHAR(1), 
	DEN NUMBER(38,0), 
	MEC NUMBER(38,0), 
	GOD NUMBER(38,0), 
	BAKOD CHAR(4), 
	COUNKOD CHAR(3), 
	PARTN VARCHAR2(47), 
	VALKOD CHAR(3), 
	NLS VARCHAR2(14), 
	KOR CHAR(4), 
	KRE NUMBER(14,0), 
	DEB NUMBER(14,0), 
	COUN CHAR(3), 
	KOD CHAR(4), 
	PODK CHAR(1), 
	OPER VARCHAR2(110), 
	NAL CHAR(2), 
	BANK CHAR(4), 
	TT CHAR(3), 
	REFC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PB_1 ***
 exec bpa.alter_policies('PB_1');


COMMENT ON TABLE BARS.PB_1 IS '��_1';
COMMENT ON COLUMN BARS.PB_1.LN IS '����(L)-������(N)';
COMMENT ON COLUMN BARS.PB_1.DEN IS '����';
COMMENT ON COLUMN BARS.PB_1.MEC IS '';
COMMENT ON COLUMN BARS.PB_1.GOD IS '';
COMMENT ON COLUMN BARS.PB_1.BAKOD IS '';
COMMENT ON COLUMN BARS.PB_1.COUNKOD IS '��� �����';
COMMENT ON COLUMN BARS.PB_1.PARTN IS '������.��������';
COMMENT ON COLUMN BARS.PB_1.VALKOD IS '���';
COMMENT ON COLUMN BARS.PB_1.NLS IS '��';
COMMENT ON COLUMN BARS.PB_1.KOR IS '';
COMMENT ON COLUMN BARS.PB_1.KRE IS '����';
COMMENT ON COLUMN BARS.PB_1.DEB IS '���';
COMMENT ON COLUMN BARS.PB_1.COUN IS '��� �����';
COMMENT ON COLUMN BARS.PB_1.KOD IS '��� ���� ��';
COMMENT ON COLUMN BARS.PB_1.PODK IS '';
COMMENT ON COLUMN BARS.PB_1.OPER IS '����';
COMMENT ON COLUMN BARS.PB_1.NAL IS '';
COMMENT ON COLUMN BARS.PB_1.BANK IS '��� �����';
COMMENT ON COLUMN BARS.PB_1.TT IS '';
COMMENT ON COLUMN BARS.PB_1.REFC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PB_1.sql =========*** End *** ========
PROMPT ===================================================================================== 
