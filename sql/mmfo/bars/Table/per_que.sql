

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PER_QUE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PER_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PER_QUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PER_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PER_QUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PER_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PER_QUE 
   (	REF NUMBER, 
	REFX NUMBER, 
	 CONSTRAINT XPK_PER_QUE PRIMARY KEY (REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PER_QUE ***
 exec bpa.alter_policies('PER_QUE');


COMMENT ON TABLE BARS.PER_QUE IS '';
COMMENT ON COLUMN BARS.PER_QUE.REF IS '';
COMMENT ON COLUMN BARS.PER_QUE.REFX IS '';




PROMPT *** Create  constraint CC_PER_QUE_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PER_QUE MODIFY (REF CONSTRAINT CC_PER_QUE_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PER_QUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PER_QUE ADD CONSTRAINT XPK_PER_QUE PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PER_QUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PER_QUE ON BARS.PER_QUE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PER_QUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PER_QUE         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PER_QUE         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PER_QUE.sql =========*** End *** =====
PROMPT ===================================================================================== 
