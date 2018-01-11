

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NLS_2017.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NLS_2017 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NLS_2017'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NLS_2017'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NLS_2017 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NLS_2017 
   (	NLS_OLD VARCHAR2(15), 
	NLS_NEW VARCHAR2(15), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NLS_2017 ***
 exec bpa.alter_policies('NLS_2017');


COMMENT ON TABLE BARS.NLS_2017 IS 'Майбутны рах	';
COMMENT ON COLUMN BARS.NLS_2017.NLS_OLD IS '';
COMMENT ON COLUMN BARS.NLS_2017.NLS_NEW IS '';
COMMENT ON COLUMN BARS.NLS_2017.KF IS '';




PROMPT *** Create  constraint XPK_NLS2017 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLS_2017 ADD CONSTRAINT XPK_NLS2017 PRIMARY KEY (KF, NLS_OLD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NLS2017 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NLS2017 ON BARS.NLS_2017 (KF, NLS_OLD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NLS_2017 ***
grant SELECT                                                                 on NLS_2017        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NLS_2017.sql =========*** End *** ====
PROMPT ===================================================================================== 
