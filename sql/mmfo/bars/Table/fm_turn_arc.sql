

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_TURN_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_TURN_ARC ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_TURN_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FM_TURN_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_TURN_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_TURN_ARC 
   (	DAT DATE, 
	RNK NUMBER, 
	KV NUMBER, 
	TURN_IN NUMBER, 
	TURN_INQ NUMBER, 
	TURN_OUT NUMBER, 
	TURN_OUTQ NUMBER, KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
  execute immediate 'alter table bars.fm_turn_arc add kf varchar2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')';
exception
  when others then
     if sqlcode = -1430 then null; else raise; end if;
end;
/



PROMPT *** ALTER_POLICIES to FM_TURN_ARC ***
 exec bpa.alter_policies('FM_TURN_ARC');


COMMENT ON TABLE BARS.FM_TURN_ARC IS 'Архив оборотов по клиентам за квартал (для ФМ)';
COMMENT ON COLUMN BARS.FM_TURN_ARC.DAT IS 'Отчетная дата (первая дата квартала)';
COMMENT ON COLUMN BARS.FM_TURN_ARC.RNK IS 'Рег.номер клиента';
COMMENT ON COLUMN BARS.FM_TURN_ARC.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.FM_TURN_ARC.TURN_IN IS 'Сумма вх.оборотов за квартал';
COMMENT ON COLUMN BARS.FM_TURN_ARC.TURN_INQ IS 'Сумма вх.оборотов за квартал в экв.';
COMMENT ON COLUMN BARS.FM_TURN_ARC.TURN_OUT IS 'Сумма исх.оборотов за квартал';
COMMENT ON COLUMN BARS.FM_TURN_ARC.TURN_OUTQ IS 'Сумма исх.оборотов за квартал в экв.';




PROMPT *** Create  constraint PK_FMTURNARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_TURN_ARC ADD CONSTRAINT PK_FMTURNARC PRIMARY KEY (DAT, RNK, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMTURNARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMTURNARC ON BARS.FM_TURN_ARC (DAT, RNK, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_TURN_ARC ***
grant SELECT                                                                 on FM_TURN_ARC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_TURN_ARC     to BARS_DM;
grant SELECT                                                                 on FM_TURN_ARC     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_TURN_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
