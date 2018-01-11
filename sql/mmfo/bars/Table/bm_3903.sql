

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BM_3903.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BM_3903 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BM_3903'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BM_3903'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BM_3903'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BM_3903 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BM_3903 
   (	NLS VARCHAR2(15), 
	NLS_3907 VARCHAR2(15), 
	NMS VARCHAR2(38)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BM_3903 ***
 exec bpa.alter_policies('BM_3903');


COMMENT ON TABLE BARS.BM_3903 IS '';
COMMENT ON COLUMN BARS.BM_3903.NLS IS '';
COMMENT ON COLUMN BARS.BM_3903.NLS_3907 IS '';
COMMENT ON COLUMN BARS.BM_3903.NMS IS '';



PROMPT *** Create  grants  BM_3903 ***
grant SELECT                                                                 on BM_3903         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BM_3903         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BM_3903         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BM_3903         to START1;
grant SELECT                                                                 on BM_3903         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BM_3903.sql =========*** End *** =====
PROMPT ===================================================================================== 
