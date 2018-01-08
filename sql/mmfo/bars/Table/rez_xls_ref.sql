

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_XLS_REF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_XLS_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_XLS_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_XLS_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_XLS_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_XLS_REF 
   (	ORD NUMBER, 
	PN VARCHAR2(2048), 
	NAME VARCHAR2(2048), 
	NAME_SHEET CHAR(8), 
	SHEET NUMBER, 
	FIN NUMBER, 
	TIPS NUMBER, 
	TXT_SQL CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (TXT_SQL) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_XLS_REF ***
 exec bpa.alter_policies('REZ_XLS_REF');


COMMENT ON TABLE BARS.REZ_XLS_REF IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.ORD IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.PN IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.NAME IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.NAME_SHEET IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.SHEET IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.FIN IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.TIPS IS '';
COMMENT ON COLUMN BARS.REZ_XLS_REF.TXT_SQL IS '';




PROMPT *** Create  constraint PK_REZ_XLS_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_XLS_REF ADD CONSTRAINT PK_REZ_XLS_REF PRIMARY KEY (ORD, SHEET)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_XLS_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_XLS_REF ON BARS.REZ_XLS_REF (ORD, SHEET) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_XLS_REF.sql =========*** End *** =
PROMPT ===================================================================================== 
