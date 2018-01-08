

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REC_QUE_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REC_QUE_BAK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REC_QUE_BAK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REC_QUE_BAK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REC_QUE_BAK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REC_QUE_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.REC_QUE_BAK 
   (	REC NUMBER(38,0), 
	OTM NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REC_QUE_BAK ***
 exec bpa.alter_policies('REC_QUE_BAK');


COMMENT ON TABLE BARS.REC_QUE_BAK IS '';
COMMENT ON COLUMN BARS.REC_QUE_BAK.REC IS '';
COMMENT ON COLUMN BARS.REC_QUE_BAK.OTM IS '';



PROMPT *** Create  grants  REC_QUE_BAK ***
grant SELECT                                                                 on REC_QUE_BAK     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REC_QUE_BAK     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REC_QUE_BAK     to START1;
grant SELECT                                                                 on REC_QUE_BAK     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REC_QUE_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
