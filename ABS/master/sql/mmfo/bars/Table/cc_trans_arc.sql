

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TRANS_ARC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TRANS_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TRANS_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_TRANS_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_TRANS_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TRANS_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TRANS_ARC 
   (	NPP NUMBER(38,0), 
	REF NUMBER(38,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	SV NUMBER, 
	SZ NUMBER, 
	D_PLAN DATE, 
	D_FAKT DATE, 
	DAPP DATE, 
	REFP NUMBER(38,0), 
	COMM VARCHAR2(100), 
	ID0 NUMBER, 
	MDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TRANS_ARC ***
 exec bpa.alter_policies('CC_TRANS_ARC');


COMMENT ON TABLE BARS.CC_TRANS_ARC IS 'Транши выдачи кредита';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.NPP IS '№ пп - первичный ключ';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.REF IS 'Реф.операции выдачи';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.ACC IS 'ACC счета SS';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.FDAT IS 'Дата выдачи';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.SV IS 'Сумма факт.выдачи';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.SZ IS 'Сумма факт.погашення';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.D_PLAN IS 'План-дата погашения';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.D_FAKT IS 'Факт-дата погашения';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.DAPP IS 'Дата последнего разбора';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.REFP IS 'Реф.погашения';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.ID0 IS 'Iд.Поч.Траншу(Ід.)';
COMMENT ON COLUMN BARS.CC_TRANS_ARC.MDAT IS 'дата модиф.';

exec bars_policy_adm.add_column_kf(p_table_name => 'CC_TRANS_ARC');
exec bars_policy_adm.alter_policy_info(p_table_name => 'CC_TRANS_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'CC_TRANS_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'CC_TRANS_ARC');

PROMPT *** Create  constraint PK_CCTRANSARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_ARC ADD CONSTRAINT PK_CCTRANSARC PRIMARY KEY (MDAT, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTRANSARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTRANSARC ON BARS.CC_TRANS_ARC (MDAT, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCTRANSARC_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CCTRANSARC_IDX ON BARS.CC_TRANS_ARC (MDAT, ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TRANS_ARC ***
grant SELECT                                                                 on CC_TRANS_ARC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TRANS_ARC    to BARS_DM;
grant SELECT                                                                 on CC_TRANS_ARC    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TRANS_ARC.sql =========*** End *** 
PROMPT ===================================================================================== 
