

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_QUE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REF_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REF_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REF_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.REF_QUE 
   (	REF NUMBER(38,0), 
	FMCHECK NUMBER(38,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	OTM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_QUE ***
 exec bpa.alter_policies('REF_QUE');


COMMENT ON TABLE BARS.REF_QUE IS 'Очередь визирования документов';
COMMENT ON COLUMN BARS.REF_QUE.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.REF_QUE.FMCHECK IS '1-проверено фин.мониторингом';
COMMENT ON COLUMN BARS.REF_QUE.KF IS '';
COMMENT ON COLUMN BARS.REF_QUE.OTM IS 'Признак возврата на пред.визу';




PROMPT *** Create  constraint PK_REFQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_QUE ADD CONSTRAINT PK_REFQUE PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_QUE ADD CONSTRAINT FK_REFQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008704 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_QUE MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_QUE MODIFY (KF CONSTRAINT CC_REFQUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REFQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REFQUE ON BARS.REF_QUE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REF_QUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_QUE         to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REF_QUE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REF_QUE         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REF_QUE         to START1;
grant SELECT                                                                 on REF_QUE         to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REF_QUE         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_QUE.sql =========*** End *** =====
PROMPT ===================================================================================== 
