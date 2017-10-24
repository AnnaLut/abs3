

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NP.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NP 
   (	ID NUMBER(38,0), 
	NP VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NP ***
 exec bpa.alter_policies('NP');


COMMENT ON TABLE BARS.NP IS 'Пользовательский спр-к назначений платежей';
COMMENT ON COLUMN BARS.NP.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.NP.NP IS 'Назначение платежа';




PROMPT *** Create  constraint FK_NP_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NP ADD CONSTRAINT FK_NP_STAFF$BASE FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NP ADD CONSTRAINT PK_NP PRIMARY KEY (ID, NP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NP_NP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NP MODIFY (NP CONSTRAINT CC_NP_NP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NP MODIFY (ID CONSTRAINT CC_NP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NP ON BARS.NP (ID, NP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NP              to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT                                                          on NP              to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on NP              to PYOD001;
grant INSERT                                                                 on NP              to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NP              to WR_ALL_RIGHTS;
grant INSERT,SELECT                                                          on NP              to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NP.sql =========*** End *** ==========
PROMPT ===================================================================================== 
