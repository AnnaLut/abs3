

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FD5_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FD5_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FD5_DOCS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FD5_DOCS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FD5_DOCS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FD5_DOCS 
   (	ACC NUMBER(38,0), 
	NBS VARCHAR2(4), 
	REF NUMBER(38,0), 
	FDAT DATE, 
	S NUMBER(24,0), 
	NAZN VARCHAR2(160)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FD5_DOCS ***
 exec bpa.alter_policies('OTCN_FD5_DOCS');


COMMENT ON TABLE BARS.OTCN_FD5_DOCS IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_DOCS.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_DOCS.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_DOCS.REF IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_DOCS.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_DOCS.S IS '';
COMMENT ON COLUMN BARS.OTCN_FD5_DOCS.NAZN IS '';




PROMPT *** Create  constraint OTCN_FD5_DOCS_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_DOCS ADD CONSTRAINT OTCN_FD5_DOCS_PK PRIMARY KEY (ACC, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955633 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_DOCS MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955632 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_DOCS MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955631 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_DOCS MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955630 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FD5_DOCS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTCN_FD5_DOCS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OTCN_FD5_DOCS_PK ON BARS.OTCN_FD5_DOCS (ACC, REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FD5_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
