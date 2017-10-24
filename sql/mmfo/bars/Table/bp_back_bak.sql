

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BP_BACK_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BP_BACK_BAK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BP_BACK_BAK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BP_BACK_BAK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BP_BACK_BAK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BP_BACK_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BP_BACK_BAK 
   (	REC_IN NUMBER(*,0), 
	REC_OUT NUMBER(*,0), 
	ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BP_BACK_BAK ***
 exec bpa.alter_policies('BP_BACK_BAK');


COMMENT ON TABLE BARS.BP_BACK_BAK IS '';
COMMENT ON COLUMN BARS.BP_BACK_BAK.REC_IN IS '';
COMMENT ON COLUMN BARS.BP_BACK_BAK.REC_OUT IS '';
COMMENT ON COLUMN BARS.BP_BACK_BAK.ID IS '';



PROMPT *** Create  grants  BP_BACK_BAK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_BACK_BAK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BP_BACK_BAK     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_BACK_BAK     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BP_BACK_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
