

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_REF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_REF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OIC_REF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OIC_REF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_REF 
   (	ID NUMBER(22,0), 
	REF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OIC_REF ***
 exec bpa.alter_policies('OW_OIC_REF');


COMMENT ON TABLE BARS.OW_OIC_REF IS 'W4. Документы файлов';
COMMENT ON COLUMN BARS.OW_OIC_REF.ID IS 'Ид.файла';
COMMENT ON COLUMN BARS.OW_OIC_REF.REF IS 'Реф.';
COMMENT ON COLUMN BARS.OW_OIC_REF.KF IS '';




PROMPT *** Create  constraint CC_OWOICREF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF MODIFY (KF CONSTRAINT CC_OWOICREF_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT CC_OWOICREF_ID_NN CHECK (id is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICREF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT FK_OWOICREF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWOICREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT PK_OWOICREF PRIMARY KEY (ID, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREF_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT CC_OWOICREF_REF_NN CHECK (ref is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICREF ON BARS.OW_OIC_REF (ID, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWOICREF_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWOICREF_REF ON BARS.OW_OIC_REF (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table ow_oic_ref add sign_state number ';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table ow_oic_ref modify sign_state number default 0 ';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

PROMPT *** Create  grants  OW_OIC_REF ***
grant SELECT                                                                 on OW_OIC_REF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OIC_REF      to BARS_DM;
grant SELECT                                                                 on OW_OIC_REF      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_REF.sql =========*** End *** ==
PROMPT ===================================================================================== 
