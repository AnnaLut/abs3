

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRSETUP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRSETUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRSETUP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRSETUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRSETUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRSETUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRSETUP 
   (	ID NUMBER, 
	ACC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRSETUP ***
 exec bpa.alter_policies('CONTRSETUP');


COMMENT ON TABLE BARS.CONTRSETUP IS '';
COMMENT ON COLUMN BARS.CONTRSETUP.ID IS '';
COMMENT ON COLUMN BARS.CONTRSETUP.ACC IS '';




PROMPT *** Create  constraint XPK_CONTRSETUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRSETUP ADD CONSTRAINT XPK_CONTRSETUP PRIMARY KEY (ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CONTRSETUP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CONTRSETUP ON BARS.CONTRSETUP (ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRSETUP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTRSETUP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONTRSETUP      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTRSETUP      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRSETUP.sql =========*** End *** ==
PROMPT ===================================================================================== 
