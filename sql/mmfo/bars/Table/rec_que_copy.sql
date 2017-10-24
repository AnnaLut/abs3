

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REC_QUE_COPY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REC_QUE_COPY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REC_QUE_COPY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REC_QUE_COPY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REC_QUE_COPY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REC_QUE_COPY ***
begin 
  execute immediate '
  CREATE TABLE BARS.REC_QUE_COPY 
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




PROMPT *** ALTER_POLICIES to REC_QUE_COPY ***
 exec bpa.alter_policies('REC_QUE_COPY');


COMMENT ON TABLE BARS.REC_QUE_COPY IS '';
COMMENT ON COLUMN BARS.REC_QUE_COPY.REC IS '';
COMMENT ON COLUMN BARS.REC_QUE_COPY.OTM IS '';



PROMPT *** Create  grants  REC_QUE_COPY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REC_QUE_COPY    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REC_QUE_COPY    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REC_QUE_COPY.sql =========*** End *** 
PROMPT ===================================================================================== 
