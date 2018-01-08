

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TAX_TRANSFER_DETAILS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TAX_TRANSFER_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TAX_TRANSFER_DETAILS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TAX_TRANSFER_DETAILS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TAX_TRANSFER_DETAILS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TAX_TRANSFER_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TAX_TRANSFER_DETAILS 
   (	BRANCH VARCHAR2(30), 
	NLS_TAX VARCHAR2(30), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	NMS VARCHAR2(38), 
	OKPO VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TAX_TRANSFER_DETAILS ***
 exec bpa.alter_policies('DPT_TAX_TRANSFER_DETAILS');


COMMENT ON TABLE BARS.DPT_TAX_TRANSFER_DETAILS IS 'Реквізити для перерахування утриманого прибуткового податку';
COMMENT ON COLUMN BARS.DPT_TAX_TRANSFER_DETAILS.BRANCH IS 'Код підрозділу';
COMMENT ON COLUMN BARS.DPT_TAX_TRANSFER_DETAILS.NLS_TAX IS 'Рахунок утримання податку';
COMMENT ON COLUMN BARS.DPT_TAX_TRANSFER_DETAILS.MFO IS 'МФО отримувача';
COMMENT ON COLUMN BARS.DPT_TAX_TRANSFER_DETAILS.NLS IS 'Рахунок отримувача';
COMMENT ON COLUMN BARS.DPT_TAX_TRANSFER_DETAILS.NMS IS 'Назва отримувача';
COMMENT ON COLUMN BARS.DPT_TAX_TRANSFER_DETAILS.OKPO IS 'Код ЄДРПУО отримувача';




PROMPT *** Create  constraint FK_DPTTAXTRANSFDET_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS ADD CONSTRAINT FK_DPTTAXTRANSFDET_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTAXTRANSFDET_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS ADD CONSTRAINT FK_DPTTAXTRANSFDET_MFO FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTTAXTRANSFERDETAILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS ADD CONSTRAINT PK_DPTTAXTRANSFERDETAILS PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAXTRANSDET_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS MODIFY (OKPO CONSTRAINT CC_TAXTRANSDET_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAXTRANSDET_NMS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS MODIFY (NMS CONSTRAINT CC_TAXTRANSDET_NMS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAXTRANSDET_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS MODIFY (NLS CONSTRAINT CC_TAXTRANSDET_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAXTRANSDET_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS MODIFY (MFO CONSTRAINT CC_TAXTRANSDET_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAXTRANSDET_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS MODIFY (BRANCH CONSTRAINT CC_TAXTRANSDET_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAXTRANSDET_NLSTAX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS MODIFY (NLS_TAX CONSTRAINT CC_TAXTRANSDET_NLSTAX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTTAXTRANSFERDETAILS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTTAXTRANSFERDETAILS ON BARS.DPT_TAX_TRANSFER_DETAILS (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TAX_TRANSFER_DETAILS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TAX_TRANSFER_DETAILS to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TAX_TRANSFER_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TAX_TRANSFER_DETAILS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TAX_TRANSFER_DETAILS to DPT_ADMIN;
grant SELECT                                                                 on DPT_TAX_TRANSFER_DETAILS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TAX_TRANSFER_DETAILS.sql =========
PROMPT ===================================================================================== 
