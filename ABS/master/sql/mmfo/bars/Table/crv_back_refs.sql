

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRV_BACK_REFS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRV_BACK_REFS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRV_BACK_REFS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CRV_BACK_REFS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRV_BACK_REFS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRV_BACK_REFS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRV_BACK_REFS 
   (	BACK_REF NUMBER, 
	PAYMENT_REF NUMBER, 
	TODO VARCHAR2(200), 
	 CONSTRAINT PK_CRVBACKREFS PRIMARY KEY (BACK_REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRV_BACK_REFS ***
 exec bpa.alter_policies('CRV_BACK_REFS');


COMMENT ON TABLE BARS.CRV_BACK_REFS IS '';
COMMENT ON COLUMN BARS.CRV_BACK_REFS.BACK_REF IS '';
COMMENT ON COLUMN BARS.CRV_BACK_REFS.PAYMENT_REF IS '';
COMMENT ON COLUMN BARS.CRV_BACK_REFS.TODO IS '';




PROMPT *** Create  constraint CC_CRVBACKREFS_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRV_BACK_REFS MODIFY (BACK_REF CONSTRAINT CC_CRVBACKREFS_BR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CRVBACKREFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRV_BACK_REFS ADD CONSTRAINT PK_CRVBACKREFS PRIMARY KEY (BACK_REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CRVBACKREFS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CRVBACKREFS ON BARS.CRV_BACK_REFS (BACK_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRV_BACK_REFS ***
grant SELECT                                                                 on CRV_BACK_REFS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CRV_BACK_REFS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CRV_BACK_REFS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CRV_BACK_REFS   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRV_BACK_REFS.sql =========*** End ***
PROMPT ===================================================================================== 
