

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_GROUP_U.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_GROUP_U ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_GROUP_U'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_GROUP_U ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_GROUP_U 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(40), 
	BIC NUMBER(10,0), 
	REF_GROUP_U NUMBER(10,0), 
	NAM_REF_GROUP_U VARCHAR2(40), 
	ID_FOLDER NUMBER(10,0), 
	VID_OPER NUMBER(5,0), 
	SYM_GROUP_U NUMBER(3,0), 
	GROUP_C NUMBER(3,0), 
	RefClient NUMBER(10,0), 
	C_KO NUMBER(3,0), 
	K040 CHAR(3), 
	ID_RGU NUMBER(10,0), 
	PlanAcc NUMBER(3,0), 
	Iden CHAR(4), 
	DaCloseAP DATE, 
	DaClosePAP DATE, 
	PrCloseAP NUMBER(3,0), 
	VID_DOCUM NUMBER(3,0), 
	ISP_OWNER NUMBER(5,0), 
	DA_START DATE, 
	SyncrDoc NUMBER(5,0), 
	PeriodProc NUMBER(5,0), 
	MaskAdjustPay NUMBER(5,0), 
	NoUpdOutside NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_GROUP_U ***
 exec bpa.alter_policies('S6_GROUP_U');


COMMENT ON TABLE BARS.S6_GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.ID IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.NAME IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.BIC IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.REF_GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.NAM_REF_GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.ID_FOLDER IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.VID_OPER IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.SYM_GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.RefClient IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.C_KO IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.K040 IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.ID_RGU IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.PlanAcc IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.Iden IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.DaCloseAP IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.DaClosePAP IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.PrCloseAP IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.VID_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.DA_START IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.SyncrDoc IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.PeriodProc IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.MaskAdjustPay IS '';
COMMENT ON COLUMN BARS.S6_GROUP_U.NoUpdOutside IS '';




PROMPT *** Create  constraint SYS_C0097441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (NoUpdOutside NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097440 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (PrCloseAP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097439 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (DaClosePAP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097438 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (DaCloseAP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097437 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (PlanAcc NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097436 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (C_KO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097435 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097434 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_GROUP_U MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_GROUP_U.sql =========*** End *** ==
PROMPT ===================================================================================== 
