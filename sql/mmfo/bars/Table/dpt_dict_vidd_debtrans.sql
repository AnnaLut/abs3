

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DICT_VIDD_DEBTRANS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DICT_VIDD_DEBTRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DICT_VIDD_DEBTRANS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_VIDD_DEBTRANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DICT_VIDD_DEBTRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DICT_VIDD_DEBTRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DICT_VIDD_DEBTRANS 
   (	VIDD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DICT_VIDD_DEBTRANS ***
 exec bpa.alter_policies('DPT_DICT_VIDD_DEBTRANS');


COMMENT ON TABLE BARS.DPT_DICT_VIDD_DEBTRANS IS '—правочник дл€ настройки видов вкладов, дл€ которых наличие дебетового оборота не останавливает начислени€ процентов.';
COMMENT ON COLUMN BARS.DPT_DICT_VIDD_DEBTRANS.VIDD IS ' од вида депозита';




PROMPT *** Create  constraint SYS_C006240 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_VIDD_DEBTRANS MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DICT_VIDD_DEBTRANS ***
grant SELECT                                                                 on DPT_DICT_VIDD_DEBTRANS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DICT_VIDD_DEBTRANS.sql =========**
PROMPT ===================================================================================== 
