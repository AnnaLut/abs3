

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TRANS_ARC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TRANS_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TRANS_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_TRANS_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TRANS_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TRANS_ARC 
   (	NPP NUMBER(38,0), 
	REF NUMBER(38,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	SV NUMBER, 
	SZ NUMBER, 
	D_PLAN DATE, 
	D_FAKT DATE, 
	DAPP DATE, 
	REFP NUMBER(38,0), 
	COMM VARCHAR2(100), 
	ID0 NUMBER, 
	MDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TRANS_ARC ***
 exec bpa.alter_policies('CC_TRANS_ARC');


COMMENT ON TABLE BARS.CC_TRANS_ARC IS '������ ������ �������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.NPP IS '� �� - ��������� ����';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.REF IS '���.�������� ������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.ACC IS 'ACC ����� SS';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.FDAT IS '���� ������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.SV IS '����� ����.������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.SZ IS '����� ����.���������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.D_PLAN IS '����-���� ���������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.D_FAKT IS '����-���� ���������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.DAPP IS '���� ���������� �������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.REFP IS '���.���������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.COMM IS '�����������';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.ID0 IS 'I�.���.������(��.)';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.MDAT IS '���� �����.';




PROMPT *** Create  constraint PK_CCTRANSARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_ARC ADD CONSTRAINT PK_CCTRANSARC PRIMARY KEY (MDAT, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCTRANSARC_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CCTRANSARC_IDX ON BARS.CC_TRANS_ARC (MDAT, ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTRANSARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTRANSARC ON BARS.CC_TRANS_ARC (MDAT, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TRANS_ARC ***
grant SELECT                                                                 on CC_TRANS_ARC    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TRANS_ARC.sql =========*** End *** 
PROMPT ===================================================================================== 
