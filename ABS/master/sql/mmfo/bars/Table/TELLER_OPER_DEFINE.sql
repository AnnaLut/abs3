PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_OPER_DEFINE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_OPER_DEFINE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_OPER_DEFINE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_OPER_DEFINE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_OPER_DEFINE 
   (	OPER_CODE CHAR(3), 
	MAX_AMOUNT NUMBER(24,0), 
	CUR_CODE NUMBER(*,0), 
	EQUIP_REF NUMBER(2,0), 
	NEED_REQ VARCHAR2(4) DEFAULT ''NONE'', 
	SW_FLAG integer DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

declare
  v_num integer;
begin
  select count(1) into v_num
    from user_tab_columns
    where table_name = 'TELLER_OPER_DEFINE'
      and column_name = 'SW_FLAG';
  if v_num = 0 then
    execute immediate 'alter table teller_oper_define add sw_flag integer default 0';
  end if;
end;
/


PROMPT *** ALTER_POLICIES to TELLER_OPER_DEFINE ***
 exec bpa.alter_policies('TELLER_OPER_DEFINE');


COMMENT ON TABLE BARS.TELLER_OPER_DEFINE IS 'Перелік операцій, які можуть виконувати теллери';
COMMENT ON COLUMN BARS.TELLER_OPER_DEFINE.SW_FLAG IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_DEFINE.OPER_CODE IS 'Код операції (посилання на tts)';
COMMENT ON COLUMN BARS.TELLER_OPER_DEFINE.MAX_AMOUNT IS 'Ліміт операції';
COMMENT ON COLUMN BARS.TELLER_OPER_DEFINE.CUR_CODE IS 'Валюта операції';
COMMENT ON COLUMN BARS.TELLER_OPER_DEFINE.EQUIP_REF IS 'Посилання на обладнання';
COMMENT ON COLUMN BARS.TELLER_OPER_DEFINE.NEED_REQ IS 'Необхідність роботи з веб-сервісами (IN - приймання готівки, OUT -видача готівки, ALL - приймання/видача в одній операції, NONE(або пусто) - не касова операція)';






PROMPT *** Create  constraint SYS_C0027369 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_OPER_DEFINE MODIFY (OPER_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_OPER_DEFINE MODIFY (MAX_AMOUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027371 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_OPER_DEFINE MODIFY (EQUIP_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_OPER_DEFINE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TELLER_OPER_DEFINE to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on TELLER_OPER_DEFINE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_OPER_DEFINE.sql =========*** En
PROMPT ===================================================================================== 
