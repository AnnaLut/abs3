

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_PF_DETAILS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_PF_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_PF_DETAILS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_PF_DETAILS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_PF_DETAILS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_PF_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_PF_DETAILS 
   (	ND NUMBER(38,0), 
	DAT_TRANSFER_PF DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_PF_DETAILS ***
 exec bpa.alter_policies('W4_PF_DETAILS');


COMMENT ON TABLE BARS.W4_PF_DETAILS IS 'Таблиця додаткових параметрів пенс.2625';
COMMENT ON COLUMN BARS.W4_PF_DETAILS.ND IS '№ контракту карткового рахунку';
COMMENT ON COLUMN BARS.W4_PF_DETAILS.DAT_TRANSFER_PF IS 'Дата останнього зарахування на картрахунок від ПФ';




PROMPT *** Create  constraint CC_W4_PF_DETAILSPDETAILS_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PF_DETAILS MODIFY (ND CONSTRAINT CC_W4_PF_DETAILSPDETAILS_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_PF_DETAILS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PF_DETAILS   to ABS_ADMIN;
grant SELECT                                                                 on W4_PF_DETAILS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PF_DETAILS   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PF_DETAILS   to DPT_ADMIN;
grant SELECT                                                                 on W4_PF_DETAILS   to START1;
grant SELECT                                                                 on W4_PF_DETAILS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_PF_DETAILS.sql =========*** End ***
PROMPT ===================================================================================== 
