

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK16_Z.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK16_Z ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK16_Z'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK16_Z'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK16_Z'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK16_Z ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK16_Z 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK16_Z ***
 exec bpa.alter_policies('EK16_Z');


COMMENT ON TABLE BARS.EK16_Z IS '';
COMMENT ON COLUMN BARS.EK16_Z.NBS IS '';
COMMENT ON COLUMN BARS.EK16_Z.NAME IS '';
COMMENT ON COLUMN BARS.EK16_Z.PAP IS '';



PROMPT *** Create  grants  EK16_Z ***
grant SELECT                                                                 on EK16_Z          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK16_Z          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK16_Z          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK16_Z          to EK16_Z;
grant SELECT                                                                 on EK16_Z          to UPLD;
grant FLASHBACK,SELECT                                                       on EK16_Z          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK16_Z.sql =========*** End *** ======
PROMPT ===================================================================================== 
