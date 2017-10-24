

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONCLUSION_LINK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONCLUSION_LINK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONCLUSION_LINK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONCLUSION_LINK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONCLUSION_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONCLUSION_LINK 
   (	CNC_ID NUMBER, 
	PAYMENT_ID NUMBER, 
	FANTOM_ID NUMBER, 
	VMD_ID NUMBER, 
	ACT_ID NUMBER, 
	S NUMBER, 
	CREATE_DATE DATE, 
	CREATE_UID NUMBER, 
	DELETE_DATE DATE, 
	DELETE_UID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONCLUSION_LINK ***
 exec bpa.alter_policies('CIM_CONCLUSION_LINK');


COMMENT ON TABLE BARS.CIM_CONCLUSION_LINK IS 'прив`язки висновків до первинних документів';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.FANTOM_ID IS 'ідентифікатор фантома';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.VMD_ID IS 'ідентифікатор вмд';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.ACT_ID IS 'ідентифікатор акта';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.S IS 'Сума зв`язку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.CREATE_DATE IS 'дата введення зв`язку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.CREATE_UID IS 'користувач, який ввів зв`язок';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.DELETE_DATE IS 'дата видалення зв`язку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.DELETE_UID IS 'користувач, який видалив зв`язок';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.CNC_ID IS 'ідентифікатор ';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_LINK.PAYMENT_ID IS 'ідентифікатор платежа';




PROMPT *** Create  constraint FK_CIMCNCLINK_ACTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK ADD CONSTRAINT FK_CIMCNCLINK_ACTID FOREIGN KEY (ACT_ID)
	  REFERENCES BARS.CIM_ACT_BOUND (BOUND_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCNCLINK_VMDID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK ADD CONSTRAINT FK_CIMCNCLINK_VMDID FOREIGN KEY (VMD_ID)
	  REFERENCES BARS.CIM_VMD_BOUND (BOUND_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCNCLINK_FANTOMID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK ADD CONSTRAINT FK_CIMCNCLINK_FANTOMID FOREIGN KEY (FANTOM_ID)
	  REFERENCES BARS.CIM_FANTOMS_BOUND (BOUND_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCNCLINK_PAYMENTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK ADD CONSTRAINT FK_CIMCNCLINK_PAYMENTID FOREIGN KEY (PAYMENT_ID)
	  REFERENCES BARS.CIM_PAYMENTS_BOUND (BOUND_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCNCLINK_CNCID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK ADD CONSTRAINT FK_CIMCNCLINK_CNCID FOREIGN KEY (CNC_ID)
	  REFERENCES BARS.CIM_CONCLUSION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCNCLINK_DOC_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK ADD CONSTRAINT CC_CIMCNCLINK_DOC_CHECK CHECK (payment_id is not null and fantom_id is null and vmd_id is null and act_id is null or
                                            payment_id is null and fantom_id is not null and vmd_id is null and act_id is null or
                                            payment_id is null and fantom_id is null and vmd_id is not null and act_id is null or
                                            payment_id is null and fantom_id is null and vmd_id is null and act_id is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCNCLINK_CREATEUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK MODIFY (CREATE_UID CONSTRAINT CC_CIMCNCLINK_CREATEUID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCNCLINK_CREATEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK MODIFY (CREATE_DATE CONSTRAINT CC_CIMCNCLINK_CREATEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCNCLINK_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK MODIFY (S CONSTRAINT CC_CIMCNCLINK_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCNCLINK_CNCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_LINK MODIFY (CNC_ID CONSTRAINT CC_CIMCNCLINK_CNCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONCLUSION_LINK ***
grant SELECT                                                                 on CIM_CONCLUSION_LINK to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONCLUSION_LINK to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONCLUSION_LINK.sql =========*** E
PROMPT ===================================================================================== 
