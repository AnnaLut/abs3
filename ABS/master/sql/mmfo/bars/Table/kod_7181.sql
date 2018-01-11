

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_7181.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_7181 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_7181'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_7181'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_7181'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_7181 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_7181 
   (	K071 CHAR(1), 
	K081 CHAR(1), 
	K030 CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_7181 ***
 exec bpa.alter_policies('KOD_7181');


COMMENT ON TABLE BARS.KOD_7181 IS '';
COMMENT ON COLUMN BARS.KOD_7181.K071 IS '';
COMMENT ON COLUMN BARS.KOD_7181.K081 IS '';
COMMENT ON COLUMN BARS.KOD_7181.K030 IS '';
COMMENT ON COLUMN BARS.KOD_7181.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_7181.D_CLOSE IS '';



PROMPT *** Create  grants  KOD_7181 ***
grant SELECT                                                                 on KOD_7181        to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on KOD_7181        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_7181        to UPLD;
grant FLASHBACK,SELECT                                                       on KOD_7181        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_7181.sql =========*** End *** ====
PROMPT ===================================================================================== 
