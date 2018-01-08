

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPU.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPU'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLPU'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPU'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPU ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPU 
   (	NBW VARCHAR2(38), 
	MFO VARCHAR2(12), 
	SAB CHAR(4), 
	OP CHAR(1), 
	OTM CHAR(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPU ***
 exec bpa.alter_policies('KLPU');


COMMENT ON TABLE BARS.KLPU IS '';
COMMENT ON COLUMN BARS.KLPU.NBW IS '';
COMMENT ON COLUMN BARS.KLPU.MFO IS '';
COMMENT ON COLUMN BARS.KLPU.SAB IS '';
COMMENT ON COLUMN BARS.KLPU.OP IS '';
COMMENT ON COLUMN BARS.KLPU.OTM IS '';
COMMENT ON COLUMN BARS.KLPU.KF IS '';




PROMPT *** Create  constraint FK_KLPU_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPU ADD CONSTRAINT FK_KLPU_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPU_NBW_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPU MODIFY (NBW CONSTRAINT CC_KLPU_NBW_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPU_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPU MODIFY (MFO CONSTRAINT CC_KLPU_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPU_SAB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPU MODIFY (SAB CONSTRAINT CC_KLPU_SAB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPU_OP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPU MODIFY (OP CONSTRAINT CC_KLPU_OP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPU_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPU MODIFY (KF CONSTRAINT CC_KLPU_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPU ***
grant DELETE,SELECT,UPDATE                                                   on KLPU            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLPU            to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on KLPU            to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPU            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPU.sql =========*** End *** ========
PROMPT ===================================================================================== 
