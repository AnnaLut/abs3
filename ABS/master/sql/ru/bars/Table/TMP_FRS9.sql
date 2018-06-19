

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FRS9.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FRS9 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_FRS9'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_FRS9'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FRS9 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FRS9 
   (TTS VARCHAR2(3), 
	NAME VARCHAR2(255), 
	DATV VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
alter table TMP_FRS9
  add constraint TMP_FRS9_PK primary key (TTS)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );';
exception when others then       
  null;
end; 
/



PROMPT *** ALTER_POLICIES to TMP_FRS9 ***
 exec bpa.alter_policies('TMP_FRS9');


COMMENT ON TABLE BARS.TMP_FRS9 IS '';
COMMENT ON COLUMN BARS.TMP_FRS9.TTS IS '';
COMMENT ON COLUMN BARS.TMP_FRS9.NAME IS '';
COMMENT ON COLUMN BARS.TMP_FRS9.DATV IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FRS9.sql =========*** End *** ==
PROMPT ===================================================================================== 
