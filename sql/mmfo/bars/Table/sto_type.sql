

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_TYPE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_TYPE 
   (	ID NUMBER(5,0), 
	TYPE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_TYPE ***
 exec bpa.alter_policies('STO_TYPE');


COMMENT ON TABLE BARS.STO_TYPE IS '';
COMMENT ON COLUMN BARS.STO_TYPE.ID IS '';
COMMENT ON COLUMN BARS.STO_TYPE.TYPE_NAME IS '';




PROMPT *** Create  constraint SYS_C006775 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006776 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_TYPE MODIFY (TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STO_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_TYPE ADD CONSTRAINT PK_STO_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_TYPE ON BARS.STO_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_TYPE ***
grant SELECT                                                                 on STO_TYPE        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_TYPE.sql =========*** End *** ====
PROMPT ===================================================================================== 
