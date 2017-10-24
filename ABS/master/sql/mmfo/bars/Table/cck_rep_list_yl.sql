

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_REP_LIST_YL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_REP_LIST_YL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_REP_LIST_YL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_REP_LIST_YL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_REP_LIST_YL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_REP_LIST_YL 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(70), 
	FUNCNAME VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_REP_LIST_YL ***
 exec bpa.alter_policies('CCK_REP_LIST_YL');


COMMENT ON TABLE BARS.CCK_REP_LIST_YL IS '';
COMMENT ON COLUMN BARS.CCK_REP_LIST_YL.ID IS '';
COMMENT ON COLUMN BARS.CCK_REP_LIST_YL.NAME IS '';
COMMENT ON COLUMN BARS.CCK_REP_LIST_YL.FUNCNAME IS '';




PROMPT *** Create  constraint SYS_C00119426 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_REP_LIST_YL MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119425 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_REP_LIST_YL MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_REP_LIST_YL.sql =========*** End *
PROMPT ===================================================================================== 
