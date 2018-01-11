

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPE_LOT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPE_LOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPE_LOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OPE_LOT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OPE_LOT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPE_LOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPE_LOT 
   (	OB22 CHAR(2), 
	NAME VARCHAR2(25), 
	PR1 NUMBER(6,4), 
	BS1 CHAR(4), 
	OB1 CHAR(2), 
	PR2 NUMBER(6,4), 
	BS2 CHAR(4), 
	OB2 CHAR(2), 
	PR3 NUMBER(6,4), 
	BS3 CHAR(4), 
	OB3 CHAR(2), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(8), 
	NAZN1 VARCHAR2(160), 
	NAZN2 VARCHAR2(160), 
	DATP DATE, 
	ID NUMBER(*,0), 
	DK NUMBER(*,0), 
	ALG NUMBER(*,0), 
	GRP NUMBER(*,0), 
	KV NUMBER(*,0), 
	REZ_OB22 CHAR(2), 
	REZ_SUM NUMBER(10,2), 
	SKP NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'', ''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPE_LOT ***
 exec bpa.alter_policies('OPE_LOT');


COMMENT ON TABLE BARS.OPE_LOT IS '���������� � ����������� �������';
COMMENT ON COLUMN BARS.OPE_LOT.KF IS '';
COMMENT ON COLUMN BARS.OPE_LOT.OB22 IS '��� ���������~��22';
COMMENT ON COLUMN BARS.OPE_LOT.NAME IS '�����~���������';
COMMENT ON COLUMN BARS.OPE_LOT.PR1 IS '���� 1~%';
COMMENT ON COLUMN BARS.OPE_LOT.BS1 IS '���� 1~���.���';
COMMENT ON COLUMN BARS.OPE_LOT.OB1 IS '���� 1~��22';
COMMENT ON COLUMN BARS.OPE_LOT.PR2 IS '���� 2~%';
COMMENT ON COLUMN BARS.OPE_LOT.BS2 IS '���� 2~���.���';
COMMENT ON COLUMN BARS.OPE_LOT.OB2 IS '���� 2~��22';
COMMENT ON COLUMN BARS.OPE_LOT.PR3 IS '���� 3~%';
COMMENT ON COLUMN BARS.OPE_LOT.BS3 IS '���� 3~���.���';
COMMENT ON COLUMN BARS.OPE_LOT.OB3 IS '���� 3~��22';
COMMENT ON COLUMN BARS.OPE_LOT.MFO IS '��� �����~���������';
COMMENT ON COLUMN BARS.OPE_LOT.NLS IS '�������~���������';
COMMENT ON COLUMN BARS.OPE_LOT.OKPO IS '';
COMMENT ON COLUMN BARS.OPE_LOT.NAZN1 IS '���� ������������ ����������';
COMMENT ON COLUMN BARS.OPE_LOT.NAZN2 IS '����������� ��. ��� ���-2(������������� ����_�)';
COMMENT ON COLUMN BARS.OPE_LOT.DATP IS '';
COMMENT ON COLUMN BARS.OPE_LOT.ID IS '';
COMMENT ON COLUMN BARS.OPE_LOT.DK IS '';
COMMENT ON COLUMN BARS.OPE_LOT.ALG IS '';
COMMENT ON COLUMN BARS.OPE_LOT.GRP IS '';
COMMENT ON COLUMN BARS.OPE_LOT.KV IS '';
COMMENT ON COLUMN BARS.OPE_LOT.REZ_OB22 IS '��22 ��� 2905 �� ������.�������';
COMMENT ON COLUMN BARS.OPE_LOT.REZ_SUM IS '����� ������.������a';
COMMENT ON COLUMN BARS.OPE_LOT.SKP IS '������ ��� ��';




PROMPT *** Create  constraint PK_OPELOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPE_LOT ADD CONSTRAINT PK_OPELOT PRIMARY KEY (OB22, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPELOT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPELOT ON BARS.OPE_LOT (OB22, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPE_LOT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPE_LOT         to ABS_ADMIN;
grant SELECT                                                                 on OPE_LOT         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPE_LOT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPE_LOT         to BARS_DM;
grant SELECT,UPDATE                                                          on OPE_LOT         to PYOD001;
grant SELECT                                                                 on OPE_LOT         to UPLD;
grant FLASHBACK,SELECT                                                       on OPE_LOT         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPE_LOT.sql =========*** End *** =====
PROMPT ===================================================================================== 
