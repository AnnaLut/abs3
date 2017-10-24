

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_DocParam_Y.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_DocParam_Y ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_DocParam_Y ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_DocParam_Y 
   (	DA_OD DATE, 
	ID_OPER NUMBER(10,0), 
	ID_DOCUM NUMBER(3,0), 
	Param VARCHAR2(20), 
	ParamVal VARCHAR2(200), 
	ISP_Modify NUMBER(5,0), 
	D_Modify DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_DocParam_Y ***
 exec bpa.alter_policies('S6_DocParam_Y');


COMMENT ON TABLE BARS.S6_DocParam_Y IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.DA_OD IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.ID_OPER IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.ID_DOCUM IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.Param IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.ParamVal IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_DocParam_Y.D_Modify IS '';




PROMPT *** Create  constraint SYS_C007398 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (DA_OD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007399 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (ID_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007400 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (ID_DOCUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007401 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (Param NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007402 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (ParamVal NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007403 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (ISP_Modify NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007404 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DocParam_Y MODIFY (D_Modify NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_DocParam_Y.sql =========*** End ***
PROMPT ===================================================================================== 
