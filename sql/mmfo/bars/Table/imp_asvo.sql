

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IMP_ASVO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IMP_ASVO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IMP_ASVO'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''IMP_ASVO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''IMP_ASVO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IMP_ASVO ***
begin 
  execute immediate '
  CREATE TABLE BARS.IMP_ASVO
   (
      nd        NUMBER(38,0),
      branch    VARCHAR2(30) default sys_context(''bars_context'',''user_branch''),
      kf        VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
      datte     DATE default sysdate,
      filename  VARCHAR2(255),
      nnomer    NUMBER(38,0),
      doneby    VARCHAR2(50),
      file_clob CLOB,
      file_blob BLOB,
      tvbv      CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to IMP_ASVO ***
 exec bpa.alter_policies('IMP_ASVO');

COMMENT ON COLUMN BARS.IMP_ASVO.ND        is 'Номер по порядку';
COMMENT ON COLUMN BARS.IMP_ASVO.BRANCH    is 'Відділення де вносили';
COMMENT ON COLUMN BARS.IMP_ASVO.DATTE     is 'Дата внесення';
COMMENT ON COLUMN BARS.IMP_ASVO.FILENAME  is 'Назва файлу,що завантажили';
COMMENT ON COLUMN BARS.IMP_ASVO.NNOMER    is 'Номер відповідного завантаження';
COMMENT ON COLUMN BARS.IMP_ASVO.DONEBY    is 'Хто вніс';
COMMENT ON COLUMN BARS.IMP_ASVO.TVBV      is 'Код відділення АСВО';

PROMPT *** Create  index IMP_ASVO  ***
begin   
 execute immediate '
  CREATE INDEX BARS.IMP_ASVO_NNOMER ON BARS.IMP_ASVO (NNOMER)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  IMP_ASVO ***
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER                                  ON IMP_ASVO        TO BARS_ACCESS_DEFROLE;
GRANT SELECT                                                                 ON IMP_ASVO        TO BARSR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IMP_ASVO .sql =========*** End *** ===
PROMPT ===================================================================================== 
