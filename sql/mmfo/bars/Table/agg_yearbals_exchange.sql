

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AGG_YEARBALS_EXCHANGE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AGG_YEARBALS_EXCHANGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AGG_YEARBALS_EXCHANGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''AGG_YEARBALS_EXCHANGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AGG_YEARBALS_EXCHANGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.AGG_YEARBALS_EXCHANGE 
   (	KF CHAR(6), 
	FDAT DATE, 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CRDOS NUMBER(24,0), 
	CRDOSQ NUMBER(24,0), 
	CRKOS NUMBER(24,0), 
	CRKOSQ NUMBER(24,0), 
	CUDOS NUMBER(24,0), 
	CUDOSQ NUMBER(24,0), 
	CUKOS NUMBER(24,0), 
	CUKOSQ NUMBER(24,0), 
	WSDOS NUMBER(24,0), 
	WSKOS NUMBER(24,0), 
	WCDOS NUMBER(24,0), 
	WCKOS NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING
  TABLESPACE BRSACCM ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AGG_YEARBALS_EXCHANGE ***
 exec bpa.alter_policies('AGG_YEARBALS_EXCHANGE');


COMMENT ON TABLE BARS.AGG_YEARBALS_EXCHANGE IS '������������� ������� �� ��� � ���������� ����������';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.FDAT IS '���� �������';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.ACC IS '��. �������';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.RNK IS '��. �볺���';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.OST IS '�������� ������� �� ������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.OSTQ IS '�������� ������� �� ������� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.DOS IS '���� ��������� ������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.DOSQ IS '���� ��������� ������� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.KOS IS '���� ���������� ������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.KOSQ IS '���� ���������� ������� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CRDOS IS '���� ���������� ���������  ������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CRDOSQ IS '���� ���������� ���������  ������� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CRKOS IS '���� ���������� ���������� ������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CRKOSQ IS '���� ���������� ���������� ������� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CUDOS IS '���� ���������� ���������  ������� �������� ���� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CUDOSQ IS '���� ���������� ���������  ������� �������� ���� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CUKOS IS '���� ���������� ���������� ������� �������� ���� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.CUKOSQ IS '���� ���������� ���������� ������� �������� ���� (���������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.WSDOS IS '���� ���������  ������� ���������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.WSKOS IS '���� ���������� ������� ���������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.WCDOS IS '���� ���������� ���������  ������� ���������� (������)';
COMMENT ON COLUMN BARS.AGG_YEARBALS_EXCHANGE.WCKOS IS '���� ���������� ���������� ������� ���������� (������)';




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (KF CONSTRAINT CC_YEARBALSEXCHANGE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (FDAT CONSTRAINT CC_YEARBALSEXCHANGE_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (ACC CONSTRAINT CC_YEARBALSEXCHANGE_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (RNK CONSTRAINT CC_YEARBALSEXCHANGE_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (OST CONSTRAINT CC_YEARBALSEXCHANGE_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (OSTQ CONSTRAINT CC_YEARBALSEXCHANGE_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (DOS CONSTRAINT CC_YEARBALSEXCHANGE_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (DOSQ CONSTRAINT CC_YEARBALSEXCHANGE_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (KOS CONSTRAINT CC_YEARBALSEXCHANGE_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (KOSQ CONSTRAINT CC_YEARBALSEXCHANGE_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CRDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CRDOS CONSTRAINT CC_YEARBALSEXCHANGE_CRDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CRDOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CRDOSQ CONSTRAINT CC_YEARBALSEXCHANGE_CRDOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CRKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CRKOS CONSTRAINT CC_YEARBALSEXCHANGE_CRKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CRKOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CRKOSQ CONSTRAINT CC_YEARBALSEXCHANGE_CRKOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CUDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CUDOS CONSTRAINT CC_YEARBALSEXCHANGE_CUDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CUDOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CUDOSQ CONSTRAINT CC_YEARBALSEXCHANGE_CUDOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CUKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CUKOS CONSTRAINT CC_YEARBALSEXCHANGE_CUKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_CUKOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (CUKOSQ CONSTRAINT CC_YEARBALSEXCHANGE_CUKOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_WSDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (WSDOS CONSTRAINT CC_YEARBALSEXCHANGE_WSDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_WSKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (WSKOS CONSTRAINT CC_YEARBALSEXCHANGE_WSKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_WCDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (WCDOS CONSTRAINT CC_YEARBALSEXCHANGE_WCDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALSEXCHANGE_WCKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS_EXCHANGE MODIFY (WCKOS CONSTRAINT CC_YEARBALSEXCHANGE_WCKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_YEARBALSEXCHANGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_YEARBALSEXCHANGE ON BARS.AGG_YEARBALS_EXCHANGE (FDAT, KF, ACC) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 2 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AGG_YEARBALS_EXCHANGE ***
grant SELECT                                                                 on AGG_YEARBALS_EXCHANGE to BARSREADER_ROLE;
grant ALTER,SELECT                                                           on AGG_YEARBALS_EXCHANGE to DM;
grant SELECT                                                                 on AGG_YEARBALS_EXCHANGE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AGG_YEARBALS_EXCHANGE.sql =========***
PROMPT ===================================================================================== 
