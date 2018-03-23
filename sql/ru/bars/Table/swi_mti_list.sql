

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SWI_MTI_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SWI_MTI_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SWI_MTI_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_MTI_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SWI_MTI_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SWI_MTI_LIST 
   (	NUM NUMBER, 
	ID VARCHAR2(2), 
	NAME VARCHAR2(60), 
	DESCRIPTION VARCHAR2(256), 
	OB22_2909 CHAR(2), 
	OB22_2809 CHAR(2), 
	OB22_KOM CHAR(2), 
	CDOG VARCHAR2(20), 
	DDOG DATE, 
	KOD_NBU VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SWI_MTI_LIST ***
 exec bpa.alter_policies('SWI_MTI_LIST');



PROMPT *** Create  constraint PK_SWIMTILIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST ADD CONSTRAINT PK_SWIMTILIST PRIMARY KEY (NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTILIST_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST MODIFY (NUM CONSTRAINT CC_SWIMTILIST_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTILIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST MODIFY (ID CONSTRAINT CC_SWIMTILIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTILIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST MODIFY (NAME CONSTRAINT CC_SWIMTILIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTILIST_DESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST MODIFY (DESCRIPTION CONSTRAINT CC_SWIMTILIST_DESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTILIST_OB2229_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST MODIFY (OB22_2909 CONSTRAINT CC_SWIMTILIST_OB2229_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTILIST_OB22KOM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_LIST MODIFY (OB22_KOM CONSTRAINT CC_SWIMTILIST_OB22KOM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWIMTILIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWIMTILIST ON BARS.SWI_MTI_LIST (NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin EXECUTE IMMEDIATE 'alter TABLE SWI_MTI_LIST add ( kod_nbu varchar2(5) )' ;
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin EXECUTE IMMEDIATE 'alter TABLE SWI_MTI_LIST add ( CDOG VARCHAR2(20) )' ;
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin EXECUTE IMMEDIATE 'alter TABLE SWI_MTI_LIST add ( DDOG DATE )' ;
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/



COMMENT ON TABLE BARS.SWI_MTI_LIST IS 'Список систем грошових переказів';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.NUM IS 'Порядковий номер системи';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.ID IS 'Ідентифікатор системи';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.NAME IS 'Назва системи';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.DESCRIPTION IS 'Опис системи';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.OB22_2909 IS 'Код ob22 для прийому платежів';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.OB22_2809 IS 'Код ob22 для виплати платежів';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.OB22_KOM IS '';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.CDOG IS 'Номер договора банка с системой';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.DDOG IS 'Дата договора банка с системой';
COMMENT ON COLUMN BARS.SWI_MTI_LIST.KOD_NBU IS '';

PROMPT *** Create  grants  SWI_MTI_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_MTI_LIST    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_MTI_LIST    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SWI_MTI_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
