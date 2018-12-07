PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_INST_STATUS_DICT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_INST_STATUS_DICT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_INST_STATUS_DICT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_INST_STATUS_DICT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_INST_STATUS_DICT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_INST_STATUS_DICT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_INST_STATUS_DICT 
   (ST_ID NUMBER, 
	ST_SID VARCHAR2(50), 
	ST_NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_INST_STATUS_DICT ***
 exec bpa.alter_policies('OW_INST_STATUS_DICT');


COMMENT ON TABLE BARS.OW_INST_STATUS_DICT IS 'Довідник статусів договорів Instolment';
COMMENT ON COLUMN BARS.OW_INST_STATUS_DICT.ST_ID IS 'Ід статусу';
COMMENT ON COLUMN BARS.OW_INST_STATUS_DICT.ST_SID IS 'Текст статусу';
COMMENT ON COLUMN BARS.OW_INST_STATUS_DICT.ST_NAME IS 'Назва статусу';
/
begin   
 execute immediate 'ALTER TABLE BARS.OW_INST_STATUS_DICT ADD 
CONSTRAINT PK_OW_INST_STATUS_DICT
 PRIMARY KEY (ST_SID)
 ENABLE
 VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
grant select on OW_INST_STATUS_DICT to bars_access_defrole;
/



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_INST_STATUS_DICT.sql =========*** E
PROMPT ===================================================================================== 