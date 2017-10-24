

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_OPERW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_OPERW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STO_OPERW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_OPERW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_OPERW 
   (	IDD NUMBER(*,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(200), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_OPERW ***
 exec bpa.alter_policies('STO_OPERW');


COMMENT ON TABLE BARS.STO_OPERW IS 'Предустановленные доп.реквизиты 1-й деталт гер.пл';
COMMENT ON COLUMN BARS.STO_OPERW.IDD IS 'Код детали';
COMMENT ON COLUMN BARS.STO_OPERW.TAG IS 'ТЕГ доп.рекв.';
COMMENT ON COLUMN BARS.STO_OPERW.VALUE IS 'Значение доп.рекв.';
COMMENT ON COLUMN BARS.STO_OPERW.KF IS '';




PROMPT *** Create  constraint PK_STOOPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_OPERW ADD CONSTRAINT PK_STOOPERW PRIMARY KEY (IDD, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOOPERW_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_OPERW ADD CONSTRAINT FK_STOOPERW_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOOPERW_IDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_OPERW ADD CONSTRAINT FK_STOOPERW_IDD FOREIGN KEY (IDD)
	  REFERENCES BARS.STO_DET (IDD) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOOPERW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_OPERW MODIFY (KF CONSTRAINT CC_STOOPERW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STOOPERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STOOPERW ON BARS.STO_OPERW (IDD, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_OPERW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_OPERW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_OPERW       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_OPERW       to STO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_OPERW.sql =========*** End *** ===
PROMPT ===================================================================================== 
