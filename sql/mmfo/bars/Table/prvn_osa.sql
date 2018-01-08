

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_OSA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_OSA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_OSA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_OSA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_OSA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_OSA ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_OSA 
   (	RNK NUMBER, 
	TIP NUMBER(*,0), 
	ND NUMBER, 
	KV NUMBER(*,0), 
	REZB NUMBER(24,2), 
	REZ9 NUMBER(24,2), 
	AIRC_CCY NUMBER(24,2), 
	IRC_CCY NUMBER(24,2), 
	ID_PROV_TYPE VARCHAR2(2), 
	IS_DEFAULT NUMBER(*,0), 
	COMM VARCHAR2(100), 
	REZB_R NUMBER, 
	REZ9_R NUMBER, 
	FV_ABS NUMBER, 
	VIDD NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_OSA ***
 exec bpa.alter_policies('PRVN_OSA');


COMMENT ON TABLE BARS.PRVN_OSA IS 'Стиснена Вітрина "Резерв-МСФЗ"';
COMMENT ON COLUMN BARS.PRVN_OSA.RNK IS 'RNK_CLIENT~РНК~клиента';
COMMENT ON COLUMN BARS.PRVN_OSA.TIP IS 'UNIQUE_BARS_IS~Ключ/*~в АБС';
COMMENT ON COLUMN BARS.PRVN_OSA.ND IS 'UNIQUE_BARS_IS~*/Ключ~в АБС';
COMMENT ON COLUMN BARS.PRVN_OSA.KV IS 'ID_CURRENCY~Код~вал';
COMMENT ON COLUMN BARS.PRVN_OSA.REZB IS 'PROV_BALANCE_CCY~Резерв по~бал.акт';
COMMENT ON COLUMN BARS.PRVN_OSA.REZ9 IS 'PROV_OFFBALANCE_CCY~Резерв по~вне/бал.акт';
COMMENT ON COLUMN BARS.PRVN_OSA.AIRC_CCY IS 'AIRC_CCY~Итого~НЕприз.дох';
COMMENT ON COLUMN BARS.PRVN_OSA.IRC_CCY IS '';
COMMENT ON COLUMN BARS.PRVN_OSA.ID_PROV_TYPE IS 'ID_PROV_TYPE~Кол/Инд~основа';
COMMENT ON COLUMN BARS.PRVN_OSA.IS_DEFAULT IS 'Метка~дефолта';
COMMENT ON COLUMN BARS.PRVN_OSA.COMM IS 'COMM~Протокол обр~NBU23_REZ';
COMMENT ON COLUMN BARS.PRVN_OSA.REZB_R IS 'Ручной резерв по балансу';
COMMENT ON COLUMN BARS.PRVN_OSA.REZ9_R IS 'Ручной резерв по внебалансу';
COMMENT ON COLUMN BARS.PRVN_OSA.FV_ABS IS 'FV-ABS~НЕ прийнято~резерву';
COMMENT ON COLUMN BARS.PRVN_OSA.VIDD IS 'Вид кредиту';
COMMENT ON COLUMN BARS.PRVN_OSA.KF IS '';




PROMPT *** Create  constraint CC_PRVNOSA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_OSA MODIFY (KF CONSTRAINT CC_PRVNOSA_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_OSA ***
grant SELECT                                                                 on PRVN_OSA        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on PRVN_OSA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_OSA        to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_OSA        to START1;
grant SELECT                                                                 on PRVN_OSA        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_OSA.sql =========*** End *** ====
PROMPT ===================================================================================== 
