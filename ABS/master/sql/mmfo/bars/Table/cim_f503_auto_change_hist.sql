

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F503_AUTO_CHANGE_HIST.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F503_AUTO_CHANGE_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F503_AUTO_CHANGE_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F503_AUTO_CHANGE_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F503_AUTO_CHANGE_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F503_AUTO_CHANGE_HIST 
   (	F503_ID NUMBER, 
	INDICATOR_CODE VARCHAR2(10), 
	INDICATOR_NAME VARCHAR2(70), 
	REP_VALUE VARCHAR2(108), 
	VK_VALUE VARCHAR2(108), 
	DATE_CHANGE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F503_AUTO_CHANGE_HIST ***
 exec bpa.alter_policies('CIM_F503_AUTO_CHANGE_HIST');


COMMENT ON TABLE BARS.CIM_F503_AUTO_CHANGE_HIST IS 'Історія автоматичних змін при формуванні звіту Ф503(6А)';
COMMENT ON COLUMN BARS.CIM_F503_AUTO_CHANGE_HIST.F503_ID IS '';
COMMENT ON COLUMN BARS.CIM_F503_AUTO_CHANGE_HIST.INDICATOR_CODE IS '';
COMMENT ON COLUMN BARS.CIM_F503_AUTO_CHANGE_HIST.INDICATOR_NAME IS '';
COMMENT ON COLUMN BARS.CIM_F503_AUTO_CHANGE_HIST.REP_VALUE IS 'Було(Звіт)';
COMMENT ON COLUMN BARS.CIM_F503_AUTO_CHANGE_HIST.VK_VALUE IS 'Стало(з Валютного ктонтролю у Звіт)';
COMMENT ON COLUMN BARS.CIM_F503_AUTO_CHANGE_HIST.DATE_CHANGE IS '';




PROMPT *** Create  index F503_ID_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.F503_ID_IDX ON BARS.CIM_F503_AUTO_CHANGE_HIST (F503_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CIM_F503_AUTO_CHANGE_HIST modify rep_value VARCHAR2(200)';
 end;
/

begin   
 execute immediate 'alter table CIM_F503_AUTO_CHANGE_HIST modify vk_value VARCHAR2(200)';
 end;
/


PROMPT *** Create  grants  CIM_F503_AUTO_CHANGE_HIST ***
grant SELECT                                                                 on CIM_F503_AUTO_CHANGE_HIST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F503_AUTO_CHANGE_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F503_AUTO_CHANGE_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F503_AUTO_CHANGE_HIST.sql ========
PROMPT ===================================================================================== 
