PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_CLOSE_SDI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_CLOSE_SDI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_CLOSE_SDI'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_CLOSE_SDI'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_CLOSE_SDI ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_CLOSE_SDI 
   (	fdat  date, 
        sos   number, 
        nd    number, 
        acc   number, 
        nls   VARCHAR2(15), 
        kv    number, 
        tip   char(3), 
        ostc  number, 
        dazs  date,
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to REZ_CLOSE_SDI ***
 exec bpa.alter_policies('REZ_CLOSE_SDI');


COMMENT ON TABLE  BARS.REZ_CLOSE_SDI        IS 'Звіт Договора, по яким відсутня заборгованість та ризикові позабалансові зобов"язання, але сформовано SNA, дисконт,премію та уцінку,дооцінку';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.FDAT   IS 'Дата формування';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.SOS    IS 'Стан коредитного договору';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.ND     IS 'Рефюдоговору';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.acc    IS 'Внутрішній номер разунку';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.NLS    IS 'Номер рахунку';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.KV     IS 'Код валюти';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.TIP    IS 'Тип рахунку';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.OSTC   IS 'Залишок на рахунку';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.dazs   IS 'Дата закриття';
COMMENT ON COLUMN BARS.REZ_CLOSE_SDI.KF     IS 'Код філіала';


PROMPT *** Create  constraint CC_PRVNOSAQ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_CLOSE_SDI MODIFY (KF CONSTRAINT CC_REZCLOSESDI_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  REZ_CLOSE_SDI ***
grant SELECT,UPDATE                                                          on REZ_CLOSE_SDI       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on REZ_CLOSE_SDI       to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_CLOSE_SDI.sql =========*** End *** ===
PROMPT ===================================================================================== 
