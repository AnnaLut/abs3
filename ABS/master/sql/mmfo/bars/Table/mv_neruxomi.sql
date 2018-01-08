

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MV_NERUXOMI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MV_NERUXOMI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MV_NERUXOMI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MV_NERUXOMI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MV_NERUXOMI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MV_NERUXOMI ***
begin 
  execute immediate '
  CREATE TABLE BARS.MV_NERUXOMI 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NBS CHAR(4), 
	NMS VARCHAR2(70), 
	BRANCH VARCHAR2(30), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MV_NERUXOMI ***
 exec bpa.alter_policies('MV_NERUXOMI');


COMMENT ON COLUMN BARS.MV_NERUXOMI.ACC IS '';
COMMENT ON COLUMN BARS.MV_NERUXOMI.NLS IS '';
COMMENT ON COLUMN BARS.MV_NERUXOMI.NBS IS '';
COMMENT ON COLUMN BARS.MV_NERUXOMI.NMS IS '';
COMMENT ON COLUMN BARS.MV_NERUXOMI.BRANCH IS '';
COMMENT ON COLUMN BARS.MV_NERUXOMI.OB22 IS '';




PROMPT *** Create  constraint PK_ACCOUNTS1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MV_NERUXOMI ADD CONSTRAINT PK_ACCOUNTS1 PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010222 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MV_NERUXOMI MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010223 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MV_NERUXOMI MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010224 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MV_NERUXOMI MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010225 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MV_NERUXOMI MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTS1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTS1 ON BARS.MV_NERUXOMI (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MV_NERUXOMI.sql =========*** End *** =
PROMPT ===================================================================================== 
