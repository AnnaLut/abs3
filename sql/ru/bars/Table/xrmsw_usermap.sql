

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_USERMAP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_USERMAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_USERMAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_USERMAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_USERMAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_USERMAP 
   (	ID NUMBER(38,0), 
	LOGNAME VARCHAR2(50), 
	ADLOGNAME VARCHAR2(150), 
	LASTNAME VARCHAR2(150), 
	MIDDLENAME VARCHAR2(150), 
	FIRSTNAME VARCHAR2(150), 
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(30), 
	E_MAIL VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XRMSW_USERMAP ***
 exec bpa.alter_policies('XRMSW_USERMAP');


COMMENT ON TABLE BARS.XRMSW_USERMAP IS 'Мапінг коритувачів AD - ABS';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.ID IS '';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.LOGNAME IS 'Логін в АБС БАРС';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.ADLOGNAME IS 'Логін в домені Ощадбанк';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.LASTNAME IS 'Прізвище';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.MIDDLENAME IS 'По-батькові';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.FIRSTNAME IS 'Ім'я';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.KF IS 'РУ';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.XRMSW_USERMAP.E_MAIL IS 'Email';




PROMPT *** Create  constraint PK_XRMSW_USERMAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_USERMAP ADD CONSTRAINT PK_XRMSW_USERMAP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XRMSW_USERMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XRMSW_USERMAP ON BARS.XRMSW_USERMAP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_USERMAP.sql =========*** End ***
PROMPT ===================================================================================== 
