

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_QUEUEA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_QUEUEA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_QUEUEA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_QUEUEA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_QUEUEA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_QUEUEA ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_QUEUEA 
   (	SAB VARCHAR2(6), 
	ACC NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_QUEUEA ***
 exec bpa.alter_policies('KLP_QUEUEA');


COMMENT ON TABLE BARS.KLP_QUEUEA IS 'ќчередь дл€ автоматического отбора файлов A';
COMMENT ON COLUMN BARS.KLP_QUEUEA.SAB IS 'Ёлектронный код клиента';
COMMENT ON COLUMN BARS.KLP_QUEUEA.ACC IS 'ACC счЄта';
COMMENT ON COLUMN BARS.KLP_QUEUEA.KF IS '';




PROMPT *** Create  constraint PK_KLPQUEUEA ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_QUEUEA ADD CONSTRAINT PK_KLPQUEUEA PRIMARY KEY (KF, SAB, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008057 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_QUEUEA MODIFY (SAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008058 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_QUEUEA MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPQUEUEA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_QUEUEA MODIFY (KF CONSTRAINT CC_KLPQUEUEA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPQUEUEA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPQUEUEA ON BARS.KLP_QUEUEA (KF, SAB, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_KLPQUEUEA_SAB ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_KLPQUEUEA_SAB ON BARS.KLP_QUEUEA (SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_QUEUEA ***
grant SELECT                                                                 on KLP_QUEUEA      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_QUEUEA      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_QUEUEA      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_QUEUEA      to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_QUEUEA      to TECH_MOM1;
grant SELECT                                                                 on KLP_QUEUEA      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_QUEUEA.sql =========*** End *** ==
PROMPT ===================================================================================== 
