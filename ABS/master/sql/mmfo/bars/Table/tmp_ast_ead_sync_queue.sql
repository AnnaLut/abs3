

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AST_EAD_SYNC_QUEUE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AST_EAD_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AST_EAD_SYNC_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AST_EAD_SYNC_QUEUE 
   (	TYPE_ID VARCHAR2(100), 
	OBJ_ID VARCHAR2(100), 
	M_ID NUMBER, 
	C NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AST_EAD_SYNC_QUEUE ***
 exec bpa.alter_policies('TMP_AST_EAD_SYNC_QUEUE');


COMMENT ON TABLE BARS.TMP_AST_EAD_SYNC_QUEUE IS '';
COMMENT ON COLUMN BARS.TMP_AST_EAD_SYNC_QUEUE.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_AST_EAD_SYNC_QUEUE.OBJ_ID IS '';
COMMENT ON COLUMN BARS.TMP_AST_EAD_SYNC_QUEUE.M_ID IS '';
COMMENT ON COLUMN BARS.TMP_AST_EAD_SYNC_QUEUE.C IS '';




PROMPT *** Create  constraint SYS_C009815 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_AST_EAD_SYNC_QUEUE MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009816 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_AST_EAD_SYNC_QUEUE MODIFY (OBJ_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AST_EAD_SYNC_QUEUE.sql =========**
PROMPT ===================================================================================== 
