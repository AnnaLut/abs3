

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEP_SIMBOL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEP_SIMBOL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEP_SIMBOL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEP_SIMBOL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEP_SIMBOL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEP_SIMBOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEP_SIMBOL 
   (	SIMBOL CHAR(2), 
	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEP_SIMBOL ***
 exec bpa.alter_policies('DEP_SIMBOL');


COMMENT ON TABLE BARS.DEP_SIMBOL IS '';
COMMENT ON COLUMN BARS.DEP_SIMBOL.SIMBOL IS '';
COMMENT ON COLUMN BARS.DEP_SIMBOL.NBS IS '';




PROMPT *** Create  constraint XPK_DEP_SIMBOL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEP_SIMBOL ADD CONSTRAINT XPK_DEP_SIMBOL PRIMARY KEY (SIMBOL, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DEP_SIMBOL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DEP_SIMBOL ON BARS.DEP_SIMBOL (SIMBOL, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEP_SIMBOL ***
grant SELECT                                                                 on DEP_SIMBOL      to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on DEP_SIMBOL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEP_SIMBOL      to BARS_DM;
grant SELECT                                                                 on DEP_SIMBOL      to UPLD;
grant FLASHBACK,SELECT                                                       on DEP_SIMBOL      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEP_SIMBOL.sql =========*** End *** ==
PROMPT ===================================================================================== 
