PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IFRS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IFRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IFRS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IFRS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IFRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.IFRS 
   (	IFRS_ID VARCHAR2(15), 
	IFRS_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to IFRS ***
 exec bpa.alter_policies('IFRS');


COMMENT ON TABLE  BARS.IFRS           IS 'Класифікатор принципів обліку Активів по МСФЗ-9';
COMMENT ON COLUMN BARS.IFRS.IFRS_ID   IS 'Символьний код по IFRS корзины'  ;
COMMENT ON COLUMN BARS.IFRS.IFRS_NAME IS 'Опис принципу обліку Активів по МСФЗ-9';

PROMPT *** Create  constraint SYS_C00139604 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IFRS MODIFY (IFRS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin 
  execute immediate 'ALTER TABLE BARS.IFRS DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/
begin   
 execute immediate 'drop index PK_IFRS';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_IFRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.IFRS ADD CONSTRAINT PK_IFRS PRIMARY KEY (IFRS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_IFRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IFRS ON BARS.IFRS (IFRS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin 
   EXECUTE IMMEDIATE 'update IFRS set K9 = null' ;
   EXECUTE IMMEDIATE 'alter table IFRS drop column  K9 ';
exception when others then  null;
end;
/

PROMPT *** Create  grants  IFRS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on IFRS            to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IFRS.sql =========*** End *** ========
PROMPT ===================================================================================== 
