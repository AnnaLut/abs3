

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FILE_TYPES_REPORTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FILE_TYPES_REPORTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FILE_TYPES_REPORTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FILE_TYPES_REPORTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FILE_TYPES_REPORTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FILE_TYPES_REPORTS 
   (	ID NUMBER, 
	NAME VARCHAR2(10), 
	DESCRIPTION VARCHAR2(100), 
	STATUS NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FILE_TYPES_REPORTS ***
 exec bpa.alter_policies('FILE_TYPES_REPORTS');


COMMENT ON TABLE BARS.FILE_TYPES_REPORTS IS 'ФОРМАТИ ДРУКУ ЗВІТІВ';
COMMENT ON COLUMN BARS.FILE_TYPES_REPORTS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.FILE_TYPES_REPORTS.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.FILE_TYPES_REPORTS.DESCRIPTION IS 'Опис';
COMMENT ON COLUMN BARS.FILE_TYPES_REPORTS.STATUS IS 'Статус: 1-активний; 0- не використовується';



PROMPT *** Create  grants  FILE_TYPES_REPORTS ***
grant DELETE,SELECT,UPDATE                                                   on FILE_TYPES_REPORTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FILE_TYPES_REPORTS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FILE_TYPES_REPORTS.sql =========*** En
PROMPT ===================================================================================== 
