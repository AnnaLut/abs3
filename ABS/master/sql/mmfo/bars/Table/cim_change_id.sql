

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CHANGE_ID.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CHANGE_ID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CHANGE_ID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CHANGE_ID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CHANGE_ID ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CHANGE_ID 
   (	TABLE_WITH_PK VARCHAR2(60), 
	ID_OLD NUMBER, 
	ID_NEW NUMBER, 
	TABLE_FK VARCHAR2(60), 
	CNT_CHANGE NUMBER, 
	R_DATE DATE DEFAULT sysdate, 
	INFO VARCHAR2(1024)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CHANGE_ID ***
 exec bpa.alter_policies('CIM_CHANGE_ID');


COMMENT ON TABLE BARS.CIM_CHANGE_ID IS 'Історія змін ІДшніків для модуля CIM, щоб можливо було виконувати міграцію інших областей';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.TABLE_WITH_PK IS '';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.ID_OLD IS '';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.ID_NEW IS '';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.TABLE_FK IS '';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.CNT_CHANGE IS 'Змінено записів в дочірній таблиці';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.R_DATE IS '';
COMMENT ON COLUMN BARS.CIM_CHANGE_ID.INFO IS 'Інформація';



PROMPT *** Create  grants  CIM_CHANGE_ID ***
grant SELECT                                                                 on CIM_CHANGE_ID   to BARSREADER_ROLE;
grant SELECT                                                                 on CIM_CHANGE_ID   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CHANGE_ID.sql =========*** End ***
PROMPT ===================================================================================== 
