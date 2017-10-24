

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DCP_B.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DCP_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DCP_B'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_B'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_B'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DCP_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.DCP_B 
   (	REC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DCP_B ***
 exec bpa.alter_policies('DCP_B');


COMMENT ON TABLE BARS.DCP_B IS '';
COMMENT ON COLUMN BARS.DCP_B.REC IS '';




PROMPT *** Create  constraint XPK_DCP_B ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_B ADD CONSTRAINT XPK_DCP_B PRIMARY KEY (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DCP_B ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DCP_B ON BARS.DCP_B (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DCP_B ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_B           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DCP_B           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_B           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DCP_B.sql =========*** End *** =======
PROMPT ===================================================================================== 
