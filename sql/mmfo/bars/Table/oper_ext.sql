

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPER_EXT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPER_EXT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPER_EXT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OPER_EXT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OPER_EXT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPER_EXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPER_EXT 
   (	REF NUMBER(38,0), 
	KF VARCHAR2(30), 
	PAY_BANKDATE DATE, 
	PAY_CALDATE DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD 
  PARTITION BY RANGE (PAY_BANKDATE) 
 (PARTITION OPEREXT_Y2009_Q1  VALUES LESS THAN (TO_DATE('' 2009-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2009_Q2  VALUES LESS THAN (TO_DATE('' 2009-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2009_Q3  VALUES LESS THAN (TO_DATE('' 2009-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2009_Q4  VALUES LESS THAN (TO_DATE('' 2010-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2010_Q1  VALUES LESS THAN (TO_DATE('' 2010-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2010_Q2  VALUES LESS THAN (TO_DATE('' 2010-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2010_Q3  VALUES LESS THAN (TO_DATE('' 2010-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2010_Q4  VALUES LESS THAN (TO_DATE('' 2011-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2011_Q1  VALUES LESS THAN (TO_DATE('' 2011-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2011_Q2  VALUES LESS THAN (TO_DATE('' 2011-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2011_Q3  VALUES LESS THAN (TO_DATE('' 2011-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2011_Q4  VALUES LESS THAN (TO_DATE('' 2012-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2012_Q1  VALUES LESS THAN (TO_DATE('' 2012-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2012_Q2  VALUES LESS THAN (TO_DATE('' 2012-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2012_Q3  VALUES LESS THAN (TO_DATE('' 2012-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2012_Q4  VALUES LESS THAN (TO_DATE('' 2013-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2013_Q1  VALUES LESS THAN (TO_DATE('' 2013-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2013_Q2  VALUES LESS THAN (TO_DATE('' 2013-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2013_Q3  VALUES LESS THAN (TO_DATE('' 2013-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2013_Q4  VALUES LESS THAN (TO_DATE('' 2014-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2014_Q1  VALUES LESS THAN (TO_DATE('' 2014-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2014_Q2  VALUES LESS THAN (TO_DATE('' 2014-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2014_Q3  VALUES LESS THAN (TO_DATE('' 2014-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2014_Q4  VALUES LESS THAN (TO_DATE('' 2015-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2015_Q1  VALUES LESS THAN (TO_DATE('' 2015-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2015_Q2  VALUES LESS THAN (TO_DATE('' 2015-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2015_Q3  VALUES LESS THAN (TO_DATE('' 2015-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2015_Q4  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2016_Q1  VALUES LESS THAN (TO_DATE('' 2016-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2016_Q2  VALUES LESS THAN (TO_DATE('' 2016-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2016_Q3  VALUES LESS THAN (TO_DATE('' 2016-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2016_Q4  VALUES LESS THAN (TO_DATE('' 2017-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2017_Q1  VALUES LESS THAN (TO_DATE('' 2017-04-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2017_Q2  VALUES LESS THAN (TO_DATE('' 2017-07-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2017_Q3  VALUES LESS THAN (TO_DATE('' 2017-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_Y2017_Q4  VALUES LESS THAN (TO_DATE('' 2018-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION OPEREXT_MAXVALUE  VALUES LESS THAN (MAXVALUE) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD )  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPER_EXT ***
 exec bpa.alter_policies('OPER_EXT');


COMMENT ON TABLE BARS.OPER_EXT IS '��������� �������� � ������� ���';
COMMENT ON COLUMN BARS.OPER_EXT.REF IS '���. ���������';
COMMENT ON COLUMN BARS.OPER_EXT.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARS.OPER_EXT.PAY_BANKDATE IS '��������� ���� ������ ���������';
COMMENT ON COLUMN BARS.OPER_EXT.PAY_CALDATE IS '���������� ���� ������ ���������';




PROMPT *** Create  constraint PK_OPEREXT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_EXT ADD CONSTRAINT PK_OPEREXT PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPEREXT_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_EXT MODIFY (REF CONSTRAINT CC_OPEREXT_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPEREXT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_EXT MODIFY (KF CONSTRAINT CC_OPEREXT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPEREXT_PAYBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_EXT MODIFY (PAY_BANKDATE CONSTRAINT CC_OPEREXT_PAYBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPEREXT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPEREXT ON BARS.OPER_EXT (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_OPEREXT_BANKDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_OPEREXT_BANKDATE ON BARS.OPER_EXT (PAY_BANKDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_OPEREXT_CALDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_OPEREXT_CALDATE ON BARS.OPER_EXT (TRUNC(PAY_CALDATE)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPER_EXT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPER_EXT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPER_EXT.sql =========*** End *** ====
PROMPT ===================================================================================== 
