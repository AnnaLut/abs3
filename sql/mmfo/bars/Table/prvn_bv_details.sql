

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_BV_DETAILS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_BV_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_BV_DETAILS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRVN_BV_DETAILS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_BV_DETAILS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_BV_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_BV_DETAILS 
   (	ND NUMBER, 
	MDAT DATE, 
	CDAT DATE, 
	SS NUMBER, 
	SP NUMBER, 
	SN NUMBER, 
	SPI NUMBER, 
	SPN NUMBER, 
	SDI NUMBER, 
	SNO NUMBER, 
	SNA NUMBER, 
	REZ NUMBER, 
	BV NUMBER, 
	IR NUMBER, 
	EPS1 NUMBER, 
	NR NUMBER, 
	NOM1 NUMBER, 
	AR NUMBER, 
	KV NUMBER, 
	VIDD NUMBER(*,0), 
	SE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_BV_DETAILS ***
 exec bpa.alter_policies('PRVN_BV_DETAILS');


COMMENT ON TABLE BARS.PRVN_BV_DETAILS IS '�������� ���������� ���� �� ��.������';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.ND IS '��� ~��';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.MDAT IS '�����~����';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.CDAT IS '����������~����';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SS IS 'SS~����.���';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SP IS 'SP~������.���';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SN IS 'SN~����� %%';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SPI IS 'SPI~�����';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SPN IS 'SPN~������. %%';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SDI IS 'SDI~�������';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SNO IS 'SNO~³�����. %%';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SNA IS 'SNA~������. %%';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.REZ IS 'REZ~������';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.BV IS '����';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.IR IS '������ %% 1 ���';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.EPS1 IS '���~1 ���';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.NR IS '`�����. %%';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.NOM1 IS '���~1 ���';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.AR IS '`�����.�����=';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.KV IS '���~���';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.VIDD IS '';
COMMENT ON COLUMN BARS.PRVN_BV_DETAILS.SE IS '������,�������';




PROMPT *** Create  constraint CC_PRVNBVDETAILS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_BV_DETAILS MODIFY (KF CONSTRAINT CC_PRVNBVDETAILS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_BV_DETAILS ***
grant SELECT                                                                 on PRVN_BV_DETAILS to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_BV_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_BV_DETAILS to START1;
grant SELECT                                                                 on PRVN_BV_DETAILS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_BV_DETAILS.sql =========*** End *
PROMPT ===================================================================================== 
