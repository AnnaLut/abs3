

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ATTORNEY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ATTORNEY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ATTORNEY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ATTORNEY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ATTORNEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ATTORNEY 
   (	ND NUMBER, 
	RNK NUMBER(38,0), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	CANCEL_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ATTORNEY ***
 exec bpa.alter_policies('SKRYNKA_ATTORNEY');


COMMENT ON TABLE BARS.SKRYNKA_ATTORNEY IS 'Довіреності депозитних сейфів';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.RNK IS 'Номер довіреної особи';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.DATE_FROM IS 'Дата початку';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.DATE_TO IS 'Дата завершення';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.CANCEL_DATE IS 'Дата дострокового завершення';




PROMPT *** Create  constraint FK_ATTORN_REF_SKRYNKA_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY ADD CONSTRAINT FK_ATTORN_REF_SKRYNKA_ND FOREIGN KEY (ND)
	  REFERENCES BARS.SKRYNKA_ND (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKR_ATTORN_REF_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY ADD CONSTRAINT FK_SKR_ATTORN_REF_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834883 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (DATE_TO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834882 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834881 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834880 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ATTORNEY ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on SKRYNKA_ATTORNEY to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on SKRYNKA_ATTORNEY to DEP_SKRN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ATTORNEY.sql =========*** End 
PROMPT ===================================================================================== 
