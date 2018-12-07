PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_TRANSNLSMASK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_TRANSNLSMASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_TRANSNLSMASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_TRANSNLSMASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_TRANSNLSMASK 
   (MASK VARCHAR2(50), 
	A_W4_ACC VARCHAR2(15), 
	A_W4_NBS_OB22 VARCHAR2(15), 
	NBS CHAR(4), 
	TIP CHAR(3), 
	NMS VARCHAR2(400),
    TAB_NAME VARCHAR2(30 BYTE)    
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
execute immediate'alter table OW_TRANSNLSMASK add TAB_NAME VARCHAR2(30 BYTE)';
exception when others then
if sqlcode = -01430 then null; else raise; end if;
end;
/


PROMPT *** ALTER_POLICIES to OW_TRANSNLSMASK ***
 exec bpa.alter_policies('OW_TRANSNLSMASK');


COMMENT ON TABLE BARS.OW_TRANSNLSMASK IS 'Маски NLS та полів рахунків W4_ACC та W4_NBS_OB22 ';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.MASK IS 'Маска NLS';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.A_W4_ACC IS 'Поле таблиці W4_ACC ';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.A_W4_NBS_OB22 IS 'Поле таблиці W4_NBS_OB22';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.NBS IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.TIP IS 'Тип рахунку';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.NMS IS 'Маска назви рахунку';
COMMENT ON COLUMN BARS.OW_TRANSNLSMASK.TAB_NAME IS 'Назва таблиці зберігання номерів рахунків';

begin   
 execute immediate 'ALTER TABLE BARS.OW_TRANSNLSMASK ADD 
CONSTRAINT PK_OW_TRANSNLSMASK
 PRIMARY KEY (MASK)
 ENABLE
 VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint SYS_C0025967 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_TRANSNLSMASK MODIFY (MASK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_TRANSNLSMASK.sql =========*** End *
PROMPT ===================================================================================== 
