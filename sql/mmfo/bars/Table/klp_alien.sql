

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ALIEN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ALIEN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_ALIEN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ALIEN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ALIEN 
   (	SAB VARCHAR2(6), 
	RNK NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_ALIEN ***
 exec bpa.alter_policies('KLP_ALIEN');


COMMENT ON TABLE BARS.KLP_ALIEN IS 'Справочник "чужих" клиентов КБ';
COMMENT ON COLUMN BARS.KLP_ALIEN.SAB IS 'Электронный код "своего" клиента';
COMMENT ON COLUMN BARS.KLP_ALIEN.RNK IS 'Регистрационный номер "чужого" клиента';
COMMENT ON COLUMN BARS.KLP_ALIEN.KF IS '';




PROMPT *** Create  constraint PK_KLPALIEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ALIEN ADD CONSTRAINT PK_KLPALIEN PRIMARY KEY (KF, SAB, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPALIEN_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ALIEN ADD CONSTRAINT FK_KLPALIEN_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPALIEN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ALIEN ADD CONSTRAINT FK_KLPALIEN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPALIEN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ALIEN MODIFY (KF CONSTRAINT CC_KLPALIEN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_KLPALIEN_SAB ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_KLPALIEN_SAB ON BARS.KLP_ALIEN (SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPALIEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPALIEN ON BARS.KLP_ALIEN (KF, SAB, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ALIEN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ALIEN       to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_ALIEN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_ALIEN       to BARS_DM;
grant SELECT,UPDATE                                                          on KLP_ALIEN       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_ALIEN       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KLP_ALIEN       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ALIEN.sql =========*** End *** ===
PROMPT ===================================================================================== 
