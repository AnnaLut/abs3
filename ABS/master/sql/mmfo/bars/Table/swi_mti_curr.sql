

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SWI_MTI_CURR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SWI_MTI_CURR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SWI_MTI_CURR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_MTI_CURR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_MTI_CURR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SWI_MTI_CURR ***
begin 
  execute immediate '
  CREATE TABLE BARS.SWI_MTI_CURR 
   (	NUM NUMBER, 
	KV NUMBER(3,0), 
	PCOMB NUMBER, 
	ALG NUMBER, 
	CCLC NUMBER DEFAULT NULL, 
	NLSK VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SWI_MTI_CURR ***
 exec bpa.alter_policies('SWI_MTI_CURR');


COMMENT ON TABLE BARS.SWI_MTI_CURR IS 'Таблиця допустимих валют для систем грошових переказів ';
COMMENT ON COLUMN BARS.SWI_MTI_CURR.NUM IS 'Порядковий номер системи';
COMMENT ON COLUMN BARS.SWI_MTI_CURR.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.SWI_MTI_CURR.PCOMB IS 'Процент (например 20.2%) комиссии банка от общей суммы комиссии';
COMMENT ON COLUMN BARS.SWI_MTI_CURR.ALG IS 'Признак используемого алгоритма округления';
COMMENT ON COLUMN BARS.SWI_MTI_CURR.CCLC IS 'Признак расчетов по комиссии в национальной валюте (1 - расчет в нац. валюте)';
COMMENT ON COLUMN BARS.SWI_MTI_CURR.NLSK IS 'Расчетный счет для зачислениЯ комиссии оператора системы';




PROMPT *** Create  constraint CC_SWICURR_PCOMB ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_CURR ADD CONSTRAINT CC_SWICURR_PCOMB CHECK (pcomb <= 100 and pcomb >=0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWIMTICURR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_CURR ADD CONSTRAINT PK_SWIMTICURR PRIMARY KEY (NUM, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTICURR_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_CURR MODIFY (NUM CONSTRAINT CC_SWIMTICURR_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIMTICURR_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_MTI_CURR MODIFY (KV CONSTRAINT CC_SWIMTICURR_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWIMTICURR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWIMTICURR ON BARS.SWI_MTI_CURR (NUM, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SWI_MTI_CURR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_MTI_CURR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SWI_MTI_CURR    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_MTI_CURR    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SWI_MTI_CURR.sql =========*** End *** 
PROMPT ===================================================================================== 
