

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_DICT_OKPO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_DICT_OKPO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_DICT_OKPO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_DICT_OKPO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_DICT_OKPO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_DICT_OKPO ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_DICT_OKPO 
   (    REP_ID NUMBER, 
    OKPO VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORP_DICT_OKPO ***
 exec bpa.alter_policies('OB_CORP_DICT_OKPO');


COMMENT ON TABLE BARS.OB_CORP_DICT_OKPO IS 'Перелік ОКПО для звітів корпоративних клієнтів';
COMMENT ON COLUMN BARS.OB_CORP_DICT_OKPO.REP_ID IS 'ІД Звіту';
COMMENT ON COLUMN BARS.OB_CORP_DICT_OKPO.OKPO IS 'Перелік ОКПО';




PROMPT *** Create  constraint PK_OB_CORP_DICT_OKPO ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_DICT_OKPO ADD CONSTRAINT PK_OB_CORP_DICT_OKPO PRIMARY KEY (REP_ID, OKPO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORP_DICT_OKPO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_DICT_OKPO ON BARS.OB_CORP_DICT_OKPO (REP_ID, OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORP_DICT_OKPO ***
grant FLASHBACK,SELECT                                                       on OB_CORP_DICT_OKPO to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_DICT_OKPO.sql =========*** End
PROMPT ===================================================================================== 

