

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GR_DOK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GR_DOK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GR_DOK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GR_DOK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GR_DOK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GR_DOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.GR_DOK 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GR_DOK ***
 exec bpa.alter_policies('GR_DOK');


COMMENT ON TABLE BARS.GR_DOK IS '';
COMMENT ON COLUMN BARS.GR_DOK.ID IS '';
COMMENT ON COLUMN BARS.GR_DOK.NAME IS '';



PROMPT *** Create  grants  GR_DOK ***
grant SELECT                                                                 on GR_DOK          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GR_DOK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GR_DOK          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GR_DOK          to SALGL;
grant SELECT                                                                 on GR_DOK          to UPLD;
grant FLASHBACK,SELECT                                                       on GR_DOK          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GR_DOK.sql =========*** End *** ======
PROMPT ===================================================================================== 
