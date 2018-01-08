

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIZ_NLS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIZ_NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIZ_NLS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BIZ_NLS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BIZ_NLS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIZ_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIZ_NLS 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLS VARCHAR2(15), 
	 CONSTRAINT PK_BIZNLS PRIMARY KEY (KF, NLS) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BIZ_NLS ***
 exec bpa.alter_policies('BIZ_NLS');


COMMENT ON TABLE BARS.BIZ_NLS IS 'Лицевые счета для бизнес-правил';
COMMENT ON COLUMN BARS.BIZ_NLS.KF IS '';
COMMENT ON COLUMN BARS.BIZ_NLS.NLS IS '';




PROMPT *** Create  constraint CC_BIZNLS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZ_NLS MODIFY (KF CONSTRAINT CC_BIZNLS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIZNLS_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZ_NLS MODIFY (NLS CONSTRAINT CC_BIZNLS_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BIZNLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZ_NLS ADD CONSTRAINT PK_BIZNLS PRIMARY KEY (KF, NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BIZNLS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZ_NLS ADD CONSTRAINT FK_BIZNLS_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIZNLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIZNLS ON BARS.BIZ_NLS (KF, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIZ_NLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BIZ_NLS         to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZ_NLS         to BARS014;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZ_NLS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIZ_NLS         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZ_NLS         to START1;
grant FLASHBACK,SELECT                                                       on BIZ_NLS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIZ_NLS.sql =========*** End *** =====
PROMPT ===================================================================================== 
