PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_DICT_NBS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_DICT_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_DICT_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_DICT_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_DICT_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_DICT_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_DICT_NBS 
   (NBS VARCHAR2(4), 
    NBS_NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORP_DICT_NBS ***
 exec bpa.alter_policies('OB_CORP_DICT_NBS');


COMMENT ON TABLE BARS.OB_CORP_DICT_NBS IS 'Перелік балансових рахунків корпоративних клієнтів';
COMMENT ON COLUMN BARS.OB_CORP_DICT_NBS.NBS IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.OB_CORP_DICT_NBS.NBS_NAME IS 'Назва балансового рахуноку';




PROMPT *** Create  constraint PK_OB_CORP_DICT_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_DICT_NBS ADD CONSTRAINT PK_OB_CORP_DICT_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORP_DICT_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_DICT_NBS ON BARS.OB_CORP_DICT_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_DICT_NBS.sql =========*** End 
PROMPT ===================================================================================== 