

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_KAZ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_KAZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_KAZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BR_KAZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BR_KAZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BR_KAZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.BR_KAZ 
   (	FDAT DATE, 
	KV NUMBER(38,0), 
	PAP NUMBER(38,0), 
	S_MIN NUMBER, 
	S_MAX NUMBER, 
	IR NUMBER, 
	DNI NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BR_KAZ ***
 exec bpa.alter_policies('BR_KAZ');


COMMENT ON TABLE BARS.BR_KAZ IS 'Заявка казначейства на ресурс и его цену';
COMMENT ON COLUMN BARS.BR_KAZ.FDAT IS 'Дата~установки';
COMMENT ON COLUMN BARS.BR_KAZ.KV IS 'Код~вал';
COMMENT ON COLUMN BARS.BR_KAZ.PAP IS 'Код~АП';
COMMENT ON COLUMN BARS.BR_KAZ.S_MIN IS 'Сумма_MIN';
COMMENT ON COLUMN BARS.BR_KAZ.S_MAX IS 'Сумма_MAX';
COMMENT ON COLUMN BARS.BR_KAZ.IR IS 'Ставка';
COMMENT ON COLUMN BARS.BR_KAZ.DNI IS 'MAX Кол.дней брони';




PROMPT *** Create  constraint CC_BRKAZ_DNI ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_KAZ ADD CONSTRAINT CC_BRKAZ_DNI CHECK (dni>0 ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BR_KAZ_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_KAZ ADD CONSTRAINT FK_BR_KAZ_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BR_KAZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_KAZ ADD CONSTRAINT XPK_BR_KAZ PRIMARY KEY (FDAT, KV, DNI, PAP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BR_KAZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BR_KAZ ON BARS.BR_KAZ (FDAT, KV, DNI, PAP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_KAZ ***
grant DELETE,INSERT,SELECT                                                   on BR_KAZ          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_KAZ          to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on BR_KAZ          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_KAZ.sql =========*** End *** ======
PROMPT ===================================================================================== 
