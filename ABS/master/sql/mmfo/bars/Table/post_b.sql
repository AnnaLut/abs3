

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POST_B.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POST_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POST_B'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POST_B'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''POST_B'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POST_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.POST_B 
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




PROMPT *** ALTER_POLICIES to POST_B ***
 exec bpa.alter_policies('POST_B');


COMMENT ON TABLE BARS.POST_B IS '';
COMMENT ON COLUMN BARS.POST_B.FN IS '';
COMMENT ON COLUMN BARS.POST_B.CR IS '';
COMMENT ON COLUMN BARS.POST_B.PACK IS '';
COMMENT ON COLUMN BARS.POST_B.UNPACK IS '';



PROMPT *** Create  grants  POST_B ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POST_B          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on POST_B          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POST_B.sql =========*** End *** ======
PROMPT ===================================================================================== 
