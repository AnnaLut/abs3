

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CA_DEPT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CA_DEPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CA_DEPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CA_DEPT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CA_DEPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CA_DEPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CA_DEPT 
   (	ID NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CA_DEPT ***
 exec bpa.alter_policies('CA_DEPT');


COMMENT ON TABLE BARS.CA_DEPT IS '';
COMMENT ON COLUMN BARS.CA_DEPT.ID IS 'код департамента';
COMMENT ON COLUMN BARS.CA_DEPT.NAME IS 'наименование департамента';




PROMPT *** Create  constraint GOU_DEPT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CA_DEPT ADD CONSTRAINT GOU_DEPT_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index GOU_DEPT_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.GOU_DEPT_PK ON BARS.CA_DEPT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CA_DEPT ***
grant SELECT                                                                 on CA_DEPT         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CA_DEPT.sql =========*** End *** =====
PROMPT ===================================================================================== 
