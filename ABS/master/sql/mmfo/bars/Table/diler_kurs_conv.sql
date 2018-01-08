

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DILER_KURS_CONV.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DILER_KURS_CONV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DILER_KURS_CONV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DILER_KURS_CONV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DILER_KURS_CONV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DILER_KURS_CONV ***
begin 
  execute immediate '
  CREATE TABLE BARS.DILER_KURS_CONV 
   (	KV1 NUMBER(3,0), 
	KV2 NUMBER(3,0), 
	DAT DATE, 
	KURS_I NUMBER(35,8), 
	KURS_F NUMBER(35,8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DILER_KURS_CONV ***
 exec bpa.alter_policies('DILER_KURS_CONV');


COMMENT ON TABLE BARS.DILER_KURS_CONV IS 'Предварит.курсы конверсии';
COMMENT ON COLUMN BARS.DILER_KURS_CONV.KV1 IS 'Код валюты-1';
COMMENT ON COLUMN BARS.DILER_KURS_CONV.KV2 IS 'Код валюты-2';
COMMENT ON COLUMN BARS.DILER_KURS_CONV.DAT IS 'Дата установки (банковская)';
COMMENT ON COLUMN BARS.DILER_KURS_CONV.KURS_I IS 'Курс индикативный';
COMMENT ON COLUMN BARS.DILER_KURS_CONV.KURS_F IS 'Курс фактический';




PROMPT *** Create  constraint PK_DILERKURSCONV ***
begin   
 execute immediate '
  ALTER TABLE BARS.DILER_KURS_CONV ADD CONSTRAINT PK_DILERKURSCONV PRIMARY KEY (KV1, KV2, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DILERKURSCONV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DILERKURSCONV ON BARS.DILER_KURS_CONV (KV1, KV2, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DILER_KURS_CONV ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DILER_KURS_CONV to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DILER_KURS_CONV to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DILER_KURS_CONV to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DILER_KURS_CONV.sql =========*** End *
PROMPT ===================================================================================== 
