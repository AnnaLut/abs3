

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_ValPosEqv.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_ValPosEqv ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_ValPosEqv'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_ValPosEqv ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_ValPosEqv 
   (	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	NLS_3800 VARCHAR2(25), 
	NLS_3801 VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_ValPosEqv ***
 exec bpa.alter_policies('S6_ValPosEqv');


COMMENT ON TABLE BARS.S6_ValPosEqv IS '';
COMMENT ON COLUMN BARS.S6_ValPosEqv.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_ValPosEqv.I_VA IS '';
COMMENT ON COLUMN BARS.S6_ValPosEqv.NLS_3800 IS '';
COMMENT ON COLUMN BARS.S6_ValPosEqv.NLS_3801 IS '';




PROMPT *** Create  constraint SYS_C0097527 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ValPosEqv MODIFY (NLS_3801 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097526 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ValPosEqv MODIFY (NLS_3800 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097525 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ValPosEqv MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097524 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_ValPosEqv MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_ValPosEqv.sql =========*** End *** 
PROMPT ===================================================================================== 
