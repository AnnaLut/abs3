

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DICT_PENSION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DICT_PENSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DICT_PENSION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_PENSION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_PENSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DICT_PENSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DICT_PENSION 
   (	SEX CHAR(1), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	AGE NUMBER(*,0), 
	BDATE_START DATE, 
	BDATE_END DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DICT_PENSION ***
 exec bpa.alter_policies('DPT_DICT_PENSION');


COMMENT ON TABLE BARS.DPT_DICT_PENSION IS 'Справочник градации пенсионного возраста';
COMMENT ON COLUMN BARS.DPT_DICT_PENSION.SEX IS 'Пол';
COMMENT ON COLUMN BARS.DPT_DICT_PENSION.DATE_ON IS 'Дата начала действия';
COMMENT ON COLUMN BARS.DPT_DICT_PENSION.DATE_OFF IS 'Дата окончания действия';
COMMENT ON COLUMN BARS.DPT_DICT_PENSION.AGE IS 'Возраст (если не указано bdate_start, bdat_end)';
COMMENT ON COLUMN BARS.DPT_DICT_PENSION.BDATE_START IS 'Дата рождения "С"';
COMMENT ON COLUMN BARS.DPT_DICT_PENSION.BDATE_END IS 'Дата рождения "по"';




PROMPT *** Create  constraint UK_DPT_DICT_PENSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_PENSION ADD CONSTRAINT UK_DPT_DICT_PENSION UNIQUE (SEX, AGE, BDATE_END, BDATE_START)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_DICT_PENSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_PENSION ADD CONSTRAINT FK_DPT_DICT_PENSION FOREIGN KEY (SEX)
	  REFERENCES BARS.SEX (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008143 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_PENSION MODIFY (SEX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPT_DICT_PENSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPT_DICT_PENSION ON BARS.DPT_DICT_PENSION (SEX, AGE, BDATE_END, BDATE_START) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DICT_PENSION ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_DICT_PENSION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DICT_PENSION to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DICT_PENSION.sql =========*** End 
PROMPT ===================================================================================== 
