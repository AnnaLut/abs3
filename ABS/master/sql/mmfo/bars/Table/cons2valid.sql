

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONS2VALID.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONS2VALID ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONS2VALID ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONS2VALID 
   (	NUM NUMBER, 
	OWNER VARCHAR2(30), 
	CONSTRAINT_NAME VARCHAR2(30), 
	CONSTRAINT_TYPE VARCHAR2(1), 
	TABLE_NAME VARCHAR2(30), 
	R_OWNER VARCHAR2(30), 
	R_CONSTRAINT_NAME VARCHAR2(30), 
	DELETE_RULE VARCHAR2(9), 
	STATUS VARCHAR2(8), 
	DEFERRABLE VARCHAR2(14), 
	DEFERRED VARCHAR2(9), 
	VALIDATED VARCHAR2(13), 
	GENERATED VARCHAR2(14), 
	BAD VARCHAR2(3), 
	RELY VARCHAR2(4), 
	LAST_CHANGE DATE, 
	INDEX_OWNER VARCHAR2(30), 
	INDEX_NAME VARCHAR2(30), 
	INVALID VARCHAR2(7), 
	VIEW_RELATED VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONS2VALID ***
 exec bpa.alter_policies('CONS2VALID');


COMMENT ON TABLE BARS.CONS2VALID IS '';
COMMENT ON COLUMN BARS.CONS2VALID.NUM IS '';
COMMENT ON COLUMN BARS.CONS2VALID.OWNER IS '';
COMMENT ON COLUMN BARS.CONS2VALID.CONSTRAINT_NAME IS '';
COMMENT ON COLUMN BARS.CONS2VALID.CONSTRAINT_TYPE IS '';
COMMENT ON COLUMN BARS.CONS2VALID.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.CONS2VALID.R_OWNER IS '';
COMMENT ON COLUMN BARS.CONS2VALID.R_CONSTRAINT_NAME IS '';
COMMENT ON COLUMN BARS.CONS2VALID.DELETE_RULE IS '';
COMMENT ON COLUMN BARS.CONS2VALID.STATUS IS '';
COMMENT ON COLUMN BARS.CONS2VALID.DEFERRABLE IS '';
COMMENT ON COLUMN BARS.CONS2VALID.DEFERRED IS '';
COMMENT ON COLUMN BARS.CONS2VALID.VALIDATED IS '';
COMMENT ON COLUMN BARS.CONS2VALID.GENERATED IS '';
COMMENT ON COLUMN BARS.CONS2VALID.BAD IS '';
COMMENT ON COLUMN BARS.CONS2VALID.RELY IS '';
COMMENT ON COLUMN BARS.CONS2VALID.LAST_CHANGE IS '';
COMMENT ON COLUMN BARS.CONS2VALID.INDEX_OWNER IS '';
COMMENT ON COLUMN BARS.CONS2VALID.INDEX_NAME IS '';
COMMENT ON COLUMN BARS.CONS2VALID.INVALID IS '';
COMMENT ON COLUMN BARS.CONS2VALID.VIEW_RELATED IS '';




PROMPT *** Create  constraint SYS_C0010062 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONS2VALID MODIFY (CONSTRAINT_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010063 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONS2VALID MODIFY (TABLE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONS2VALID ***
grant SELECT                                                                 on CONS2VALID      to BARSREADER_ROLE;
grant SELECT                                                                 on CONS2VALID      to BARS_DM;
grant SELECT                                                                 on CONS2VALID      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONS2VALID.sql =========*** End *** ==
PROMPT ===================================================================================== 
