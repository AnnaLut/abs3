

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_IMMOBILE_OB22.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_IMMOBILE_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_IMMOBILE_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_IMMOBILE_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_IMMOBILE_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_IMMOBILE_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_IMMOBILE_OB22 
   (	R020 CHAR(4), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_IMMOBILE_OB22 ***
 exec bpa.alter_policies('DPT_IMMOBILE_OB22');


COMMENT ON TABLE BARS.DPT_IMMOBILE_OB22 IS 'Довідник параметрів ОБ22 консолідаційних рахунків нерухомих депозитів';
COMMENT ON COLUMN BARS.DPT_IMMOBILE_OB22.R020 IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.DPT_IMMOBILE_OB22.OB22 IS 'Параметер ОБ22';




PROMPT *** Create  constraint PK_DPTIMMOBILEOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_IMMOBILE_OB22 ADD CONSTRAINT PK_DPTIMMOBILEOB22 PRIMARY KEY (R020)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTIMMOBILEOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTIMMOBILEOB22 ON BARS.DPT_IMMOBILE_OB22 (R020) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_IMMOBILE_OB22 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_IMMOBILE_OB22 to ABS_ADMIN;
grant SELECT                                                                 on DPT_IMMOBILE_OB22 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_IMMOBILE_OB22 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_IMMOBILE_OB22 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_IMMOBILE_OB22 to DPT_ADMIN;
grant SELECT                                                                 on DPT_IMMOBILE_OB22 to START1;
grant SELECT                                                                 on DPT_IMMOBILE_OB22 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_IMMOBILE_OB22.sql =========*** End
PROMPT ===================================================================================== 
