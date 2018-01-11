

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_DEB_POG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_DEB_POG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_DEB_POG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_DEB_POG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_DEB_POG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_DEB_POG ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_DEB_POG 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_DEB_POG ***
 exec bpa.alter_policies('NBS_DEB_POG');


COMMENT ON TABLE BARS.NBS_DEB_POG IS '';
COMMENT ON COLUMN BARS.NBS_DEB_POG.NBS IS '';



PROMPT *** Create  grants  NBS_DEB_POG ***
grant SELECT                                                                 on NBS_DEB_POG     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_DEB_POG     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_DEB_POG     to SALGL;
grant SELECT                                                                 on NBS_DEB_POG     to UPLD;
grant FLASHBACK,SELECT                                                       on NBS_DEB_POG     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_DEB_POG.sql =========*** End *** =
PROMPT ===================================================================================== 
