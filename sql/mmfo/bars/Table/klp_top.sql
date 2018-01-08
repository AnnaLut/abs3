

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_TOP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_TOP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_TOP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_TOP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_TOP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_TOP ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_TOP 
   (	RNK NUMBER, 
	RNKP NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_TOP ***
 exec bpa.alter_policies('KLP_TOP');


COMMENT ON TABLE BARS.KLP_TOP IS 'Справочник вышестоящих клиентов КБ';
COMMENT ON COLUMN BARS.KLP_TOP.RNK IS 'Регистрационный номер клиента';
COMMENT ON COLUMN BARS.KLP_TOP.RNKP IS 'Регистрационный номер вышестоящего клиента';
COMMENT ON COLUMN BARS.KLP_TOP.KF IS '';




PROMPT *** Create  constraint FK_KLPTOP_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP ADD CONSTRAINT FK_KLPTOP_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPTOP_RNKP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP ADD CONSTRAINT FK_KLPTOP_RNKP FOREIGN KEY (RNKP)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KLPTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP ADD CONSTRAINT PK_KLPTOP PRIMARY KEY (KF, RNK, RNKP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006563 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006564 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP MODIFY (RNKP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPTOP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP MODIFY (KF CONSTRAINT CC_KLPTOP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPTOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPTOP ON BARS.KLP_TOP (KF, RNK, RNKP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_TOP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_TOP         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_TOP         to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_TOP         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_TOP         to TECH_MOM1;
grant FLASHBACK,SELECT                                                       on KLP_TOP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_TOP.sql =========*** End *** =====
PROMPT ===================================================================================== 
