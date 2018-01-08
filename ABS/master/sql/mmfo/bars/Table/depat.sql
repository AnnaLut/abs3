

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEPAT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEPAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEPAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEPAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEPAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEPAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEPAT 
   (	KOD_P NUMBER(*,0), 
	NAZ_P VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEPAT ***
 exec bpa.alter_policies('DEPAT');


COMMENT ON TABLE BARS.DEPAT IS '';
COMMENT ON COLUMN BARS.DEPAT.KOD_P IS '';
COMMENT ON COLUMN BARS.DEPAT.NAZ_P IS '';



PROMPT *** Create  grants  DEPAT ***
grant SELECT                                                                 on DEPAT           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPAT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEPAT           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPAT           to START1;
grant SELECT                                                                 on DEPAT           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEPAT.sql =========*** End *** =======
PROMPT ===================================================================================== 
