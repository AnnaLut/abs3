

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EN_ATOM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EN_ATOM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EN_ATOM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EN_ATOM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EN_ATOM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EN_ATOM ***
begin 
  execute immediate '
  CREATE TABLE BARS.EN_ATOM 
   (	KOD_EN_AT NUMBER(*,0), 
	NAME_EN_AT VARCHAR2(46)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EN_ATOM ***
 exec bpa.alter_policies('EN_ATOM');


COMMENT ON TABLE BARS.EN_ATOM IS '';
COMMENT ON COLUMN BARS.EN_ATOM.KOD_EN_AT IS '';
COMMENT ON COLUMN BARS.EN_ATOM.NAME_EN_AT IS '';



PROMPT *** Create  grants  EN_ATOM ***
grant SELECT                                                                 on EN_ATOM         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EN_ATOM         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EN_ATOM         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EN_ATOM         to START1;
grant SELECT                                                                 on EN_ATOM         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EN_ATOM.sql =========*** End *** =====
PROMPT ===================================================================================== 
