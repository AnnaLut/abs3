

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_D.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_D ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_D'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_D'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_D'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_D ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_D 
   (	NBS NUMBER(*,0), 
	PR NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_D ***
 exec bpa.alter_policies('NBS_D');


COMMENT ON TABLE BARS.NBS_D IS '';
COMMENT ON COLUMN BARS.NBS_D.NBS IS '';
COMMENT ON COLUMN BARS.NBS_D.PR IS '';



PROMPT *** Create  grants  NBS_D ***
grant SELECT                                                                 on NBS_D           to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on NBS_D           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_D           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_D.sql =========*** End *** =======
PROMPT ===================================================================================== 
