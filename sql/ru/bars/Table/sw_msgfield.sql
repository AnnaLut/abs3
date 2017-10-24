

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MSGFIELD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MSGFIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MSGFIELD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_MSGFIELD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MSGFIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MSGFIELD 
   (	SWREF NUMBER(38,0), 
	RECNUM NUMBER(38,0), 
	MSGBLK VARCHAR2(1), 
	MSGTAG VARCHAR2(3), 
	VALUE VARCHAR2(200), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MSGFIELD ***
 exec bpa.alter_policies('SW_MSGFIELD');


COMMENT ON TABLE BARS.SW_MSGFIELD IS 'SWT. �������������� ���� ���������';
COMMENT ON COLUMN BARS.SW_MSGFIELD.KF IS '';
COMMENT ON COLUMN BARS.SW_MSGFIELD.SWREF IS '�������� ���������';
COMMENT ON COLUMN BARS.SW_MSGFIELD.RECNUM IS '����� ����';
COMMENT ON COLUMN BARS.SW_MSGFIELD.MSGBLK IS '��� ����� ���������';
COMMENT ON COLUMN BARS.SW_MSGFIELD.MSGTAG IS '��� ���� ���������';
COMMENT ON COLUMN BARS.SW_MSGFIELD.VALUE IS '��������';




PROMPT *** Create  constraint FK_SWMSGFIELD_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_SWJOURNAL2 FOREIGN KEY (KF, SWREF)
	  REFERENCES BARS.SW_JOURNAL (KF, SWREF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMSGFIELD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMSGFIELD_SWMSGTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT FK_SWMSGFIELD_SWMSGTAG FOREIGN KEY (MSGBLK, MSGTAG)
	  REFERENCES BARS.SW_MSGTAG (MSGBLK, MSGTAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWMSGFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD ADD CONSTRAINT PK_SWMSGFIELD PRIMARY KEY (SWREF, RECNUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGFIELD_MSGTAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD MODIFY (MSGTAG CONSTRAINT CC_SWMSGFIELD_MSGTAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGFIELD_MSGBLK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD MODIFY (MSGBLK CONSTRAINT CC_SWMSGFIELD_MSGBLK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGFIELD_RECNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD MODIFY (RECNUM CONSTRAINT CC_SWMSGFIELD_RECNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGFIELD_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD MODIFY (SWREF CONSTRAINT CC_SWMSGFIELD_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGFIELD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGFIELD MODIFY (KF CONSTRAINT CC_SWMSGFIELD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMSGFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMSGFIELD ON BARS.SW_MSGFIELD (SWREF, RECNUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MSGFIELD ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MSGFIELD     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MSGFIELD.sql =========*** End *** =
PROMPT ===================================================================================== 
