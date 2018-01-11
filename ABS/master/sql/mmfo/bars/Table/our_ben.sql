

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OUR_BEN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OUR_BEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OUR_BEN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OUR_BEN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OUR_BEN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OUR_BEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.OUR_BEN 
   (	SID CHAR(3), 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OUR_BEN ***
 exec bpa.alter_policies('OUR_BEN');


COMMENT ON TABLE BARS.OUR_BEN IS '';
COMMENT ON COLUMN BARS.OUR_BEN.SID IS '';
COMMENT ON COLUMN BARS.OUR_BEN.NAME IS '';



PROMPT *** Create  grants  OUR_BEN ***
grant SELECT                                                                 on OUR_BEN         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BEN         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_BEN         to START1;
grant SELECT                                                                 on OUR_BEN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OUR_BEN.sql =========*** End *** =====
PROMPT ===================================================================================== 
