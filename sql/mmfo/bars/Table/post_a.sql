

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POST_A.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POST_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POST_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POST_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''POST_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POST_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.POST_A 
   (	FN CHAR(12), 
	CR DATE, 
	PACK DATE, 
	UNPACK DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POST_A ***
 exec bpa.alter_policies('POST_A');


COMMENT ON TABLE BARS.POST_A IS '';
COMMENT ON COLUMN BARS.POST_A.FN IS '';
COMMENT ON COLUMN BARS.POST_A.CR IS '';
COMMENT ON COLUMN BARS.POST_A.PACK IS '';
COMMENT ON COLUMN BARS.POST_A.UNPACK IS '';



PROMPT *** Create  grants  POST_A ***
grant SELECT                                                                 on POST_A          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on POST_A          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on POST_A          to START1;
grant SELECT                                                                 on POST_A          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POST_A.sql =========*** End *** ======
PROMPT ===================================================================================== 
