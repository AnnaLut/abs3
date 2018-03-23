PROMPT ===================================================================================== 
PROMPT *** Run *** ============= Scripts /Sql/BARS/Table/INV_CCK.sql ============*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK ***


BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''INV_CCK'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''INV_CCK'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
       '; 
END; 
/

PROMPT *** Create  table NBS_OB22_TIP ***
begin 

     EXECUTE IMMEDIATE 'create table BARS.INV_CCK'||
      '(FDAT        date         ,
        RNK         INTEGER      ,   
        NMK         VARCHAR2 (70),  
        OKPO        VARCHAR2 (14),   
        ND          NUMBER       ,       
        CC_ID       VARCHAR2(50) ,
        SDATE       DATE         ,
        WDATE       DATE         ,    
        KV          NUMBER (3)   ,       
        CUR         NUMBER       ,
        IR          NUMBER       ,
        IRR         NUMBER       ,
        ACC_SS      INTEGER      ,
        OST_SS      NUMBER       , 
        ACC_SP      INTEGER      ,
        OST_SP      NUMBER       , 
        ACC_SN      INTEGER      ,
        OST_SN      NUMBER       , 
        ACC_SNO     INTEGER      ,
        OST_SNO     NUMBER       , 
        ACC_SPN     INTEGER      ,
        OST_SPN     NUMBER       , 
        KOL_SS      INTEGER      ,
        KOL_SN      INTEGER      ,
        ACC_SDI     INTEGER      ,
        OST_SDI     NUMBER       , 
        ACC_SPI     INTEGER      ,
        OST_SPI     NUMBER       , 
        OST_9129_9  NUMBER       ,
        OST_9129_1  NUMBER       ,
        OST_SK0_SK9 NUMBER       ,
        ACC_SNA     INTEGER      ,
        OST_SNA     NUMBER       , 
        BV          NUMBER       ,
        VNCRP       VARCHAR2(3)  ,
        VNCRR       VARCHAR2(3)  )
     SEGMENT CREATION IMMEDIATE 
     PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
     NOCOMPRESS LOGGING
     TABLESPACE BRSBIGD ';      

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to INV_CCK ***
 exec bpa.alter_policies('INV_CCK');

-------------------------------------------------------------
COMMENT ON TABLE   BARS.INV_CCK             IS 'Кредитний ризик за активними банківськими операціями';  
COMMENT ON COLUMN  BARS.INV_CCK.FDAT        IS 'Звітна дата';
COMMENT ON COLUMN  BARS.INV_CCK.RNK         IS 'Код (номер) контрагента';	
COMMENT ON COLUMN  BARS.INV_CCK.NMK         IS 'Назва клієнта'; 
COMMENT ON COLUMN  BARS.INV_CCK.ND          IS 'Реф.  договору'; 	
COMMENT ON COLUMN  BARS.INV_CCK.CC_ID       IS 'Номер договору';	
COMMENT ON COLUMN  BARS.INV_CCK.SDATE       IS 'Дата укладання договору';	
COMMENT ON COLUMN  BARS.INV_CCK.OKPO        IS 'ЕДРПОУ';	
COMMENT ON COLUMN  BARS.INV_CCK.WDATE       IS 'Чинна дата закінчення дії кредитного договору';	
COMMENT ON COLUMN  BARS.INV_CCK.KV          IS 'Код валюти'; 
COMMENT ON COLUMN  BARS.INV_CCK.CUR         IS 'Курс';
COMMENT ON COLUMN  BARS.INV_CCK.IR          IS 'Номінальна % ставка';
COMMENT ON COLUMN  BARS.INV_CCK.IRR         IS 'Ефективна  % ставка';
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SS      IS 'acc_ss';
COMMENT ON COLUMN  BARS.INV_CCK.OST_SS      IS 'Основний борг, строковий (SS)';	
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SP      IS 'ACC_SP';
COMMENT ON COLUMN  BARS.INV_CCK.OST_SP      IS 'Основний борг, прострочений (SP)';
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SN      IS 'ACC_SN';
COMMENT ON COLUMN  BARS.INV_CCK.OST_SN      IS 'Нараховані доходи та не сплачені протягом 30 днів (SN)';
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SNO     IS 'ACC_SNO';
COMMENT ON COLUMN  BARS.INV_CCK.OST_SNO     IS 'Нараховані доходи та не сплачені понад 30 днів (SNO)';
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SPN     IS 'ACC_SPN';
COMMENT ON COLUMN  BARS.INV_CCK.OST_SPN     IS 'Нараховані доходи, прострочені (SPN)';	
COMMENT ON COLUMN  BARS.INV_CCK.KOL_SS      IS 'Кількість днів прострочення сплати основного боргу';	
COMMENT ON COLUMN  BARS.INV_CCK.KOL_SN      IS 'Кількість днів прострочення сплати нарахованих доходів';	
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SDI     IS 'ACC_SDI';	
COMMENT ON COLUMN  BARS.INV_CCK.OST_SDI     IS 'Дисконт (SDI)';	
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SPI     IS 'ACC_SPI';	
COMMENT ON COLUMN  BARS.INV_CCK.OST_SPI     IS 'Премія (SPI)';	
COMMENT ON COLUMN  BARS.INV_CCK.OST_9129_9  IS 'Відкличні позабалансові зобов"язання';	
COMMENT ON COLUMN  BARS.INV_CCK.OST_9129_1  IS 'Безвідкличні позабалансові зобов"язання';	
COMMENT ON COLUMN  BARS.INV_CCK.OST_SK0_SK9 IS 'Фінансова дебіторська заборгованість (SK0+SK9)'; 				
COMMENT ON COLUMN  BARS.INV_CCK.ACC_SNA     IS 'ACC_SNA';	
COMMENT ON COLUMN  BARS.INV_CCK.OST_SNA     IS 'Сума накопленого коригування процентного доходу (SNA)';
COMMENT ON COLUMN  BARS.INV_CCK.BV          IS 'Балансова вартість';	
COMMENT ON COLUMN  BARS.INV_CCK.VNCRP       IS 'ВКР на дату надання кредиту (початковий)';	
COMMENT ON COLUMN  BARS.INV_CCK.VNCRR       IS 'ВКР** на звітну дату'; 	

COMMIT;

PROMPT *** Create  index PK_INV_CCK ***
begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE INV_CCK ADD CONSTRAINT PK_INV_CCK PRIMARY KEY (FDAT,ND,KV)
  USING INDEX  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';

exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/
--exec bars_policy_adm.add_column_kf(p_table_name => 'INV_CCK');
--exec bars_policy_adm.alter_policy_info(p_table_name => 'INV_CCK', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
--exec bars_policy_adm.alter_policy_info(p_table_name => 'INV_CCK', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
--exec bars_policy_adm.alter_policies(p_table_name => 'INV_CCK');

GRANT SELECT ON BARS.INV_CCK TO RCC_DEAL;
GRANT SELECT ON BARS.INV_CCK TO START1;
GRANT SELECT ON BARS.INV_CCK TO BARS_ACCESS_DEFROLE;

/