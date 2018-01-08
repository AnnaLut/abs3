

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INHERIT_TAX.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_INHERIT_TAX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INHERIT_TAX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INHERIT_TAX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INHERIT_TAX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INHERIT_TAX ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_INHERIT_TAX 
   (	DPT_ID NUMBER(38,0), 
	INHERIT_CUSTID NUMBER(38,0), 
	TAX_REF NUMBER(38,0), 
	TAX_DATE DATE, 
	TAX_NUM VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INHERIT_TAX ***
 exec bpa.alter_policies('DPT_INHERIT_TAX');


COMMENT ON TABLE BARS.DPT_INHERIT_TAX IS 'Дані про сплату податку спадкоємцями';
COMMENT ON COLUMN BARS.DPT_INHERIT_TAX.DPT_ID IS 'Ідентифікатор деп.договору';
COMMENT ON COLUMN BARS.DPT_INHERIT_TAX.INHERIT_CUSTID IS 'РНК фізособи - спадкоємця';
COMMENT ON COLUMN BARS.DPT_INHERIT_TAX.TAX_REF IS 'Референс документа сплати податку спадоємцем';
COMMENT ON COLUMN BARS.DPT_INHERIT_TAX.TAX_DATE IS 'Дата докум. сплати податку спадоємцем-нерезидентом';
COMMENT ON COLUMN BARS.DPT_INHERIT_TAX.TAX_NUM IS 'Номер докум. сплати податку спадоємцем-нерезидентом';




PROMPT *** Create  constraint FK_DPTINHERITTAX ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERIT_TAX ADD CONSTRAINT FK_DPTINHERITTAX FOREIGN KEY (DPT_ID, INHERIT_CUSTID)
	  REFERENCES BARS.DPT_INHERITORS (DPT_ID, INHERIT_CUSTID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERITTAX_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERIT_TAX MODIFY (DPT_ID CONSTRAINT CC_DPTINHERITTAX_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERITTAX_CUST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERIT_TAX MODIFY (INHERIT_CUSTID CONSTRAINT CC_DPTINHERITTAX_CUST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTINHERITTAX ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERIT_TAX ADD CONSTRAINT PK_DPTINHERITTAX PRIMARY KEY (DPT_ID, INHERIT_CUSTID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTINHERITTAX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTINHERITTAX ON BARS.DPT_INHERIT_TAX (DPT_ID, INHERIT_CUSTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_INHERIT_TAX ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INHERIT_TAX to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INHERIT_TAX to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_INHERIT_TAX to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INHERIT_TAX to DPT_ADMIN;
grant SELECT                                                                 on DPT_INHERIT_TAX to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INHERIT_TAX.sql =========*** End *
PROMPT ===================================================================================== 
