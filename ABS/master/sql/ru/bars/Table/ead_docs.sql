prompt -------------------------------------
prompt  создание таблицы EAD_DOCS
prompt  Надруковані документи
prompt -------------------------------------

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Table/EAD_DOCS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_DOCS ***


execute bpa.alter_policy_info('EAD_DOCS', 'WHOLE' , null, null, null, null); 
execute bpa.alter_policy_info('EAD_DOCS', 'FILIAL', null, null, null, null);





PROMPT *** Create  table EAD_DOCS ***
begin 
  execute immediate '
create table EAD_DOCS
(
  id           NUMBER,
  crt_date     DATE,
  crt_staff_id NUMBER,
  crt_branch   VARCHAR2(30),
  type_id      VARCHAR2(100),
  template_id  VARCHAR2(100),
  scan_data    BLOB,
  ea_struct_id VARCHAR2(20),
  sign_date    DATE,
  rnk          NUMBER,
  agr_id       NUMBER,
  page_count   NUMBER,
  kf           VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  acc          NUMBER(38)
) tablespace BRSBIGD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Add/modify columns table EAD_DOCS ***
begin
  for i in (select 1 from dual where not exists (select 1 from user_tab_cols where TABLE_NAME = 'EAD_DOCS' and COLUMN_NAME = 'KF')) loop
    execute immediate 'alter table bars.ead_docs add kf VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')';
  end loop;
  for i in (select 1 from dual where not exists (select 1 from user_tab_cols where TABLE_NAME = 'EAD_DOCS' and COLUMN_NAME = 'ACC')) loop
    execute immediate 'alter table bars.ead_docs add acc number(38)';
  end loop;
end;
/


PROMPT *** Change column EAD_DOCS.EA_STRUCT_ID from NUMBER to VARCHAR2 ***
begin
  for i in (select * from user_tab_cols where table_name = 'EAD_DOCS' and column_name = 'EA_STRUCT_ID' and data_type = 'NUMBER') loop
    execute immediate 'create table bars.tmp_ead_docs (id primary key , ea_struct_id) as select id, ea_struct_id from bars.ead_docs';
    begin
      execute immediate 'alter table bars.EAD_DOCS drop constraint СС_EADDOCS_TYPEID';
      execute immediate 'alter table BARS.EAD_DOCS drop constraint CC_EADDOCS_EASTRCID_NN';
    exception
    when others then null;
    end;
    for j in (select * from mv_kf) loop
      bars.bc.go(j.kf);
      update bars.ead_docs set ea_struct_id = null;
    end loop;
    execute immediate 'alter table bars.ead_docs modify ea_struct_id VARCHAR2(20)';
    execute immediate '
    merge into bars.ead_docs d
    using (select * from bars.tmp_ead_docs) s
    on (s.id = d.id)
    when matched then update set d.ea_struct_id = s.ea_struct_id';
    execute immediate 'drop table bars.tmp_ead_docs';
  end loop;
end;
/


PROMPT *** ALTER_POLICIES to EAD_DOCS ***
exec bpa.alter_policies('EAD_DOCS');


COMMENT ON TABLE BARS.EAD_DOCS IS 'Надруковані документи';
COMMENT ON COLUMN BARS.EAD_DOCS.ID IS 'Ідентифікатор (10... - АБС)';
COMMENT ON COLUMN BARS.EAD_DOCS.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.EAD_DOCS.CRT_STAFF_ID IS 'Ід. користувача';
COMMENT ON COLUMN BARS.EAD_DOCS.CRT_BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS.EAD_DOCS.TYPE_ID IS 'Ід. типу';
COMMENT ON COLUMN BARS.EAD_DOCS.TEMPLATE_ID IS 'Ід. шаблону';
COMMENT ON COLUMN BARS.EAD_DOCS.SCAN_DATA IS 'Данні сканкопії';
COMMENT ON COLUMN BARS.EAD_DOCS.EA_STRUCT_ID IS 'Код структури документу за ЕА';
COMMENT ON COLUMN BARS.EAD_DOCS.SIGN_DATE IS 'Дата встановлення відмітки про підписання';
COMMENT ON COLUMN BARS.EAD_DOCS.RNK IS 'РНК клієнта';
COMMENT ON COLUMN BARS.EAD_DOCS.AGR_ID IS 'Ід. угоди';
COMMENT ON COLUMN BARS.EAD_DOCS.PAGE_COUNT IS 'Кіл-ть сторінок';
COMMENT ON COLUMN BARS.EAD_DOCS.KF IS 'МФО';
COMMENT ON COLUMN BARS.EAD_DOCS.ACC IS 'Счет документа';



PROMPT *** Create  constraint PK_EADDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT PK_EADDOCS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  constraint СС_EADDOCS_TYPEID ***
begin   
 execute immediate q'#
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT СС_EADDOCS_TYPEID CHECK ((type_id = 'DOC' and template_id is not null and scan_data is null)
          or (type_id = 'SCAN' and template_id is null and
          ((scan_data is not null and  EA_STRUCT_ID<>'143') or (scan_data is null and  EA_STRUCT_ID='143')
          ))) ENABLE NOVALIDATE #';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


/*
PROMPT *** DUMMY Create  constraint FK_EADDOCS_AGRID_DPTDEPOSIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_AGRID_DPTDEPOSIT FOREIGN KEY (AGR_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
*/

-- 06.02.2018  В поле ead_docs.AgrID теперь будут жыть не только депозиты, но и другие экзотические зверьки
PROMPT *** Disable constraint FK_EADDOCS_AGRID_DPTDEPOSIT ***
alter table bars.ead_docs modify constraint FK_EADDOCS_AGRID_DPTDEPOSIT disable;



PROMPT *** Create  constraint FK_EADDOCS_RNK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_RNK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EADDOCS_EASTRCID_STRCS ***
begin
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_EASTRCID_STRCS FOREIGN KEY (EA_STRUCT_ID)
	  REFERENCES BARS.EAD_STRUCT_CODES (ID) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/




PROMPT *** Create  constraint FK_EADDOCS_TPLID_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_TPLID_DOCSCHEME FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  constraint FK_EADDOCS_SID_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_SID_STAFF FOREIGN KEY (CRT_STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  constraint FK_EADDOCS_TID_DOCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_TID_DOCTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.EAD_DOC_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/




PROMPT *** Create  constraint FK_EADDOCS_BRCH_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT FK_EADDOCS_BRCH_BRANCH FOREIGN KEY (CRT_BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/







PROMPT *** Create  constraint CC_EADDOCS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (RNK CONSTRAINT CC_EADDOCS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_EASTRCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (EA_STRUCT_ID CONSTRAINT CC_EADDOCS_EASTRCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (TYPE_ID CONSTRAINT CC_EADDOCS_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_CRTB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (CRT_BRANCH CONSTRAINT CC_EADDOCS_CRTB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_CRTSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (CRT_STAFF_ID CONSTRAINT CC_EADDOCS_CRTSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (CRT_DATE CONSTRAINT CC_EADDOCS_CRTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (ID CONSTRAINT CC_EADDOCS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADDOCS ON BARS.EAD_DOCS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_DOCS ***
grant SELECT on EAD_DOCS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_DOCS.sql =========*** End *** ====
PROMPT ===================================================================================== 
