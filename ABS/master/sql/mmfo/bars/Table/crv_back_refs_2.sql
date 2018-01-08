

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRV_BACK_REFS_2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRV_BACK_REFS_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRV_BACK_REFS_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CRV_BACK_REFS_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRV_BACK_REFS_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRV_BACK_REFS_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRV_BACK_REFS_2 
   (	BACK_REF NUMBER, 
	PAYMENT_REF NUMBER, 
	TODO VARCHAR2(200)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRV_BACK_REFS_2 ***
 exec bpa.alter_policies('CRV_BACK_REFS_2');


COMMENT ON TABLE BARS.CRV_BACK_REFS_2 IS '';
COMMENT ON COLUMN BARS.CRV_BACK_REFS_2.BACK_REF IS '';
COMMENT ON COLUMN BARS.CRV_BACK_REFS_2.PAYMENT_REF IS '';
COMMENT ON COLUMN BARS.CRV_BACK_REFS_2.TODO IS '';




PROMPT *** Create  constraint SYS_C009044 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRV_BACK_REFS_2 MODIFY (BACK_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRV_BACK_REFS_2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CRV_BACK_REFS_2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CRV_BACK_REFS_2 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CRV_BACK_REFS_2 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRV_BACK_REFS_2.sql =========*** End *
PROMPT ===================================================================================== 
