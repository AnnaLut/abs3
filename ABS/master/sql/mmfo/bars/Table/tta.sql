

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTA.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TTA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTA 
   (	TTA VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTA ***
 exec bpa.alter_policies('TTA');


COMMENT ON TABLE BARS.TTA IS '';
COMMENT ON COLUMN BARS.TTA.TTA IS '';



PROMPT *** Create  grants  TTA ***
grant SELECT                                                                 on TTA             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTA             to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTA             to START1;
grant SELECT                                                                 on TTA             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTA.sql =========*** End *** =========
PROMPT ===================================================================================== 
