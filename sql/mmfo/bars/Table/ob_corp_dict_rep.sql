

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_DICT_REP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_DICT_REP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_DICT_REP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_DICT_REP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_DICT_REP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_DICT_REP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_DICT_REP 
   (REP_ID NUMBER, 
    REP_NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORP_DICT_REP ***
 exec bpa.alter_policies('OB_CORP_DICT_REP');


COMMENT ON TABLE BARS.OB_CORP_DICT_REP IS 'Перелік звітів корпоративних клієнтів';
COMMENT ON COLUMN BARS.OB_CORP_DICT_REP.REP_ID IS 'Номер звіту';
COMMENT ON COLUMN BARS.OB_CORP_DICT_REP.REP_NAME IS 'Назва звіту';




PROMPT *** Create  constraint PK_OB_CORP_DICT_REP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_DICT_REP ADD CONSTRAINT PK_OB_CORP_DICT_REP PRIMARY KEY (REP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORP_DICT_REP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_DICT_REP ON BARS.OB_CORP_DICT_REP (REP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORP_DICT_REP ***
grant FLASHBACK,SELECT                                                       on OB_CORP_DICT_REP to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_DICT_REP.sql =========*** End 
PROMPT ===================================================================================== 

