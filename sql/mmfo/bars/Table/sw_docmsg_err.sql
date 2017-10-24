

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_DOCMSG_ERR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_DOCMSG_ERR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_DOCMSG_ERR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_DOCMSG_ERR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_DOCMSG_ERR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_DOCMSG_ERR ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_DOCMSG_ERR 
   (	REF NUMBER(38,0), 
	ERRMSG VARCHAR2(2048), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_DOCMSG_ERR ***
 exec bpa.alter_policies('SW_DOCMSG_ERR');


COMMENT ON TABLE BARS.SW_DOCMSG_ERR IS 'SWT. Документы с ошибками формирования';
COMMENT ON COLUMN BARS.SW_DOCMSG_ERR.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.SW_DOCMSG_ERR.ERRMSG IS 'Текст ошибки при формировании сообщения';
COMMENT ON COLUMN BARS.SW_DOCMSG_ERR.KF IS '';




PROMPT *** Create  constraint FK_SWDOCMSGERR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_DOCMSG_ERR ADD CONSTRAINT FK_SWDOCMSGERR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWDOCMSGERR_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_DOCMSG_ERR MODIFY (REF CONSTRAINT CC_SWDOCMSGERR_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWDOCMSGERR_ERRMSG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_DOCMSG_ERR MODIFY (ERRMSG CONSTRAINT CC_SWDOCMSGERR_ERRMSG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWDOCMSGERR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_DOCMSG_ERR MODIFY (KF CONSTRAINT CC_SWDOCMSGERR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWDOCMSGERR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_DOCMSG_ERR ADD CONSTRAINT PK_SWDOCMSGERR PRIMARY KEY (KF, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWDOCMSGERR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWDOCMSGERR ON BARS.SW_DOCMSG_ERR (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_DOCMSG_ERR ***
grant SELECT                                                                 on SW_DOCMSG_ERR   to BARS013;
grant SELECT                                                                 on SW_DOCMSG_ERR   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_DOCMSG_ERR   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_DOCMSG_ERR   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_DOCMSG_ERR ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_DOCMSG_ERR FOR BARS.SW_DOCMSG_ERR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_DOCMSG_ERR.sql =========*** End ***
PROMPT ===================================================================================== 
