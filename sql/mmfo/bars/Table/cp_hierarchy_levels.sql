

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_LEVELS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_HIERARCHY_LEVELS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_HIERARCHY_LEVELS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY_LEVELS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_HIERARCHY_LEVELS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_HIERARCHY_LEVELS 
   (	ID NUMBER, 
	TITLE VARCHAR2(100), 
	FIGURE VARCHAR2(100), 
	VALUE VARCHAR2(4000), 
	DESCRIPTION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_HIERARCHY_LEVELS ***
 exec bpa.alter_policies('CP_HIERARCHY_LEVELS');


COMMENT ON TABLE BARS.CP_HIERARCHY_LEVELS IS 'Отчет по уровням иерархии за период';
COMMENT ON COLUMN BARS.CP_HIERARCHY_LEVELS.ID IS 'Номер строки';
COMMENT ON COLUMN BARS.CP_HIERARCHY_LEVELS.TITLE IS 'Заголовок раздела';
COMMENT ON COLUMN BARS.CP_HIERARCHY_LEVELS.FIGURE IS 'Показатель';
COMMENT ON COLUMN BARS.CP_HIERARCHY_LEVELS.VALUE IS 'Значение показателя';
COMMENT ON COLUMN BARS.CP_HIERARCHY_LEVELS.DESCRIPTION IS '';



PROMPT *** Create  grants  CP_HIERARCHY_LEVELS ***
grant SELECT                                                                 on CP_HIERARCHY_LEVELS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_HIERARCHY_LEVELS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_HIERARCHY_LEVELS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_HIERARCHY_LEVELS to CP_ROLE;
grant SELECT                                                                 on CP_HIERARCHY_LEVELS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_LEVELS.sql =========*** E
PROMPT ===================================================================================== 
