

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_MANY_DAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_MANY_DAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_MANY_DAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_MANY_DAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_MANY_DAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_MANY_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_MANY_DAT 
   (	REF1 NUMBER(*,0), 
	REF2 NUMBER(*,0), 
	VDAT DATE, 
	SS NUMBER, 
	SN NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_MANY_DAT ***
 exec bpa.alter_policies('CP_MANY_DAT');


COMMENT ON TABLE BARS.CP_MANY_DAT IS '';
COMMENT ON COLUMN BARS.CP_MANY_DAT.REF1 IS '';
COMMENT ON COLUMN BARS.CP_MANY_DAT.REF2 IS '';
COMMENT ON COLUMN BARS.CP_MANY_DAT.VDAT IS '';
COMMENT ON COLUMN BARS.CP_MANY_DAT.SS IS '';
COMMENT ON COLUMN BARS.CP_MANY_DAT.SN IS '';




PROMPT *** Create  constraint PK_CPMANYDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_DAT ADD CONSTRAINT PK_CPMANYDAT PRIMARY KEY (REF1, REF2)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPMANYDAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPMANYDAT ON BARS.CP_MANY_DAT (REF1, REF2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_MANY_DAT ***
grant SELECT                                                                 on CP_MANY_DAT     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_MANY_DAT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_MANY_DAT     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_MANY_DAT     to START1;
grant SELECT                                                                 on CP_MANY_DAT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_MANY_DAT.sql =========*** End *** =
PROMPT ===================================================================================== 
