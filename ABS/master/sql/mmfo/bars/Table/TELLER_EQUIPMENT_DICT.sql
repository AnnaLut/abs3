PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_EQUIPMENT_DICT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_EQUIPMENT_DICT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_EQUIPMENT_DICT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_EQUIPMENT_DICT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_EQUIPMENT_DICT 
   (	EQUIP_CODE NUMBER(2,0), 
	EQUIP_NAME VARCHAR2(60), 
	EQUIP_LIMIT NUMBER(24,0), 
	IS_BLOCKED NUMBER(*,0), 
	EQUIP_TYPE VARCHAR2(1) DEFAULT ''A''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_EQUIPMENT_DICT ***
 exec bpa.alter_policies('TELLER_EQUIPMENT_DICT');


COMMENT ON TABLE BARS.TELLER_EQUIPMENT_DICT IS 'Довідник обладнання для роботи теллерів';
COMMENT ON COLUMN BARS.TELLER_EQUIPMENT_DICT.EQUIP_CODE IS 'Код обладнання (заповнюється автоматично)';
COMMENT ON COLUMN BARS.TELLER_EQUIPMENT_DICT.EQUIP_NAME IS 'Назва обладнання';
COMMENT ON COLUMN BARS.TELLER_EQUIPMENT_DICT.EQUIP_LIMIT IS 'Ліміт  на залишок готівки';
COMMENT ON COLUMN BARS.TELLER_EQUIPMENT_DICT.IS_BLOCKED IS 'Ознака блокування';
COMMENT ON COLUMN BARS.TELLER_EQUIPMENT_DICT.EQUIP_TYPE IS 'Тип обладнання ("A" - автоматичне, спілкуємось через веб-сервіси, "M" - ручне, все контролюється тільки оператором)';




PROMPT *** Create  constraint SYS_C0027567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_EQUIPMENT_DICT MODIFY (EQUIP_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_EQUIPMENT_DICT MODIFY (EQUIP_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027569 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_EQUIPMENT_DICT MODIFY (EQUIP_LIMIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_TELLER_QUIP_DICT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_EQUIPMENT_DICT ADD CONSTRAINT XPK_TELLER_QUIP_DICT PRIMARY KEY (EQUIP_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TELLER_EQUIP_DICT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_EQUIPMENT_DICT ADD CONSTRAINT CC_TELLER_EQUIP_DICT CHECK (equip_limit>0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TELLE_EQUIP_TYPE_CHK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_EQUIPMENT_DICT ADD CONSTRAINT CC_TELLE_EQUIP_TYPE_CHK CHECK (equip_type in (''A'',''M'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TELLER_QUIP_DICT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TELLER_QUIP_DICT ON BARS.TELLER_EQUIPMENT_DICT (EQUIP_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_EQUIPMENT_DICT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TELLER_EQUIPMENT_DICT to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on TELLER_EQUIPMENT_DICT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_EQUIPMENT_DICT.sql =========***
PROMPT ===================================================================================== 
