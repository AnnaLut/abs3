

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_INTX.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_INTX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_INTX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_INTX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_INTX ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_INTX 
   (	CDAT DATE, 
	ACC8 NUMBER, 
	SAL8 NUMBER, 
	IP8 NUMBER, 
	IA8 NUMBER, 
	PAS8 NUMBER, 
	AKT8 NUMBER, 
	ACC NUMBER, 
	OST2 NUMBER, 
	IP2 NUMBER, 
	IA2 NUMBER, 
	KP NUMBER(38,10), 
	KA NUMBER(38,10), 
	S2 NUMBER(38,10), 
	S8 NUMBER(38,10), 
	PR2 NUMBER(38,10), 
	PR8 NUMBER(38,10), 
	PR NUMBER(38,10), 
	NPP NUMBER(*,0), 
	VN NUMBER(*,0), 
	RNK NUMBER, 
	MOD1 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_INTX ***
 exec bpa.alter_policies('OVR_INTX');


COMMENT ON TABLE BARS.OVR_INTX IS 'Протокол розрахунку проц по солідарному ОВР';
COMMENT ON COLUMN BARS.OVR_INTX.CDAT IS 'Календ.дата';
COMMENT ON COLUMN BARS.OVR_INTX.ACC8 IS 'рах-консолідат';
COMMENT ON COLUMN BARS.OVR_INTX.SAL8 IS 'Сальдо консол.';
COMMENT ON COLUMN BARS.OVR_INTX.IP8 IS 'Ставка на 8999 пас= П8 (льготная ставка)';
COMMENT ON COLUMN BARS.OVR_INTX.IA8 IS 'Ставка на 8999 акт = A8 (льготная ставка)';
COMMENT ON COLUMN BARS.OVR_INTX.PAS8 IS 'сума пас зал';
COMMENT ON COLUMN BARS.OVR_INTX.AKT8 IS 'сума акт зал';
COMMENT ON COLUMN BARS.OVR_INTX.ACC IS 'рах-участник 2600';
COMMENT ON COLUMN BARS.OVR_INTX.OST2 IS 'Власне сальдо учасника';
COMMENT ON COLUMN BARS.OVR_INTX.IP2 IS 'Ставка на пас 2600.i П2 (стандартная ставка)';
COMMENT ON COLUMN BARS.OVR_INTX.IA2 IS 'Ставка на акт 2600.i А2 (стандартная ставка)';
COMMENT ON COLUMN BARS.OVR_INTX.KP IS 'Коеф=сальдо ПАС/Сума пас';
COMMENT ON COLUMN BARS.OVR_INTX.KA IS 'Коеф=сальдо АКТ/Сума акт';
COMMENT ON COLUMN BARS.OVR_INTX.S2 IS 'Базовая сумма для собст (стандартной ставки)';
COMMENT ON COLUMN BARS.OVR_INTX.S8 IS 'Базовая сумма для солидар.(льготной ставки)';
COMMENT ON COLUMN BARS.OVR_INTX.PR2 IS 'Сума проц по собст (стандартной ставке)';
COMMENT ON COLUMN BARS.OVR_INTX.PR8 IS 'Сума проц по солидар.(льготной ставке)';
COMMENT ON COLUMN BARS.OVR_INTX.PR IS 'общ Сума проц за день';
COMMENT ON COLUMN BARS.OVR_INTX.NPP IS '0,1,2 - идентивикатор для раскраски строк';
COMMENT ON COLUMN BARS.OVR_INTX.VN IS 'Вид нач 0-проц. 1 - комиссия ОВР 1 дня';
COMMENT ON COLUMN BARS.OVR_INTX.RNK IS 'РНК учасника';
COMMENT ON COLUMN BARS.OVR_INTX.MOD1 IS '=1-признак реального начисления';



PROMPT *** Create  grants  OVR_INTX ***
grant SELECT                                                                 on OVR_INTX        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVR_INTX        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_INTX.sql =========*** End *** ====
PROMPT ===================================================================================== 
