

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPRINT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPRINT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPRINT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPRINT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPRINT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPRINT ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPRINT 
   (	ID NUMBER(38,0), 
	DVC VARCHAR2(40), 
	CSE VARCHAR2(160), 
	CHR12 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPRINT ***
 exec bpa.alter_policies('REPRINT');


COMMENT ON TABLE BARS.REPRINT IS 'Типы принтеров для номеров отчетов';
COMMENT ON COLUMN BARS.REPRINT.ID IS 'номер отчета';
COMMENT ON COLUMN BARS.REPRINT.DVC IS 'тип принтера';
COMMENT ON COLUMN BARS.REPRINT.CSE IS 'ESC-последовательность';
COMMENT ON COLUMN BARS.REPRINT.CHR12 IS '';




PROMPT *** Create  constraint PK_REPRINT ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPRINT ADD CONSTRAINT PK_REPRINT PRIMARY KEY (ID, DVC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REPRINT_REPORTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPRINT ADD CONSTRAINT FK_REPRINT_REPORTS FOREIGN KEY (ID)
	  REFERENCES BARS.REPORTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPRINT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPRINT MODIFY (ID CONSTRAINT CC_REPRINT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPRINT_DVC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPRINT MODIFY (DVC CONSTRAINT CC_REPRINT_DVC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REPRINT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REPRINT ON BARS.REPRINT (ID, DVC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPRINT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPRINT         to ABS_ADMIN;
grant SELECT                                                                 on REPRINT         to BARS009;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on REPRINT         to BARS010;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on REPRINT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPRINT         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPRINT         to RCC_DEAL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REPRINT         to RPBN001;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REPRINT         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REPRINT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPRINT.sql =========*** End *** =====
PROMPT ===================================================================================== 
