

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_RCIF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_RCIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_RCIF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EBK_RCIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''EBK_RCIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_RCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_RCIF 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RCIF NUMBER(38,0), 
	SEND NUMBER(1,0), 
	 CONSTRAINT PK_EBKRCIF PRIMARY KEY (KF, RCIF, SEND) ENABLE
   ) ORGANIZATION INDEX COMPRESS 1 PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_RCIF ***
 exec bpa.alter_policies('EBK_RCIF');


COMMENT ON TABLE BARS.EBK_RCIF IS 'Ідентифікатори майстер-картки на рівні РУ (рівні РНК)';
COMMENT ON COLUMN BARS.EBK_RCIF.KF IS '';
COMMENT ON COLUMN BARS.EBK_RCIF.RCIF IS '';
COMMENT ON COLUMN BARS.EBK_RCIF.SEND IS '';




PROMPT *** Create  constraint SYS_C0034003 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_RCIF MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0034004 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_RCIF MODIFY (RCIF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0034005 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_RCIF MODIFY (SEND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EBKRCIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_RCIF ADD CONSTRAINT PK_EBKRCIF PRIMARY KEY (KF, RCIF, SEND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKRCIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKRCIF ON BARS.EBK_RCIF (KF, RCIF, SEND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_RCIF ***
grant SELECT                                                                 on EBK_RCIF        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_RCIF        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_RCIF.sql =========*** End *** ====
PROMPT ===================================================================================== 
