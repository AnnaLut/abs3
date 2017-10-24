

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REFAPP_BAK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REFAPP_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REFAPP_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.REFAPP_BAK 
   (	TABID NUMBER(38,0), 
	CODEAPP VARCHAR2(30 CHAR), 
	ACODE VARCHAR2(8), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REFAPP_BAK ***
 exec bpa.alter_policies('REFAPP_BAK');


COMMENT ON TABLE BARS.REFAPP_BAK IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.TABID IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.CODEAPP IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.ACODE IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.REVERSE IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.REFAPP_BAK.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C0025766 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP_BAK MODIFY (TABID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025768 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP_BAK MODIFY (ACODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025767 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP_BAK MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REFAPP_BAK.sql =========*** End *** ==
PROMPT ===================================================================================== 
