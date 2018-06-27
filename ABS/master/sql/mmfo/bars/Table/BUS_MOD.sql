

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BUS_MOD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BUS_MOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BUS_MOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BUS_MOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BUS_MOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BUS_MOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.BUS_MOD 
   (	BUS_MOD_ID NUMBER, 
	BUS_MOD_NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
  execute immediate 
  'alter table bus_mod add (bus_mod_id_ifrs varchar2(3))';
exception
  when others then
   if (sqlcode = -1430) then null; else raise; end if; 
end;
/ 

COMMENT ON COLUMN BARS.BUS_MOD.BUS_MOD_ID_IFRS IS 'Код параметра согл.методике';

PROMPT *** ALTER_POLICIES to BUS_MOD ***
 exec bpa.alter_policies('BUS_MOD');


COMMENT ON TABLE BARS.BUS_MOD IS 'Тип бізнес моделі для договору';
COMMENT ON COLUMN BARS.BUS_MOD.BUS_MOD_ID IS 'Код параметра';
COMMENT ON COLUMN BARS.BUS_MOD.BUS_MOD_NAME IS 'Наименование параметра';




PROMPT *** Create  constraint SYS_C00139602 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BUS_MOD MODIFY (BUS_MOD_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BUS_MOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BUS_MOD ADD CONSTRAINT PK_BUS_MOD PRIMARY KEY (BUS_MOD_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BUS_MOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BUS_MOD ON BARS.BUS_MOD (BUS_MOD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BUS_MOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BUS_MOD         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BUS_MOD.sql =========*** End *** =====
PROMPT ===================================================================================== 
