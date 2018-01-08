

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KODY.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KODY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KODY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KODY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.KODY 
   (	KOD NUMBER(10,0), 
	T CHAR(4), 
	OPERACIA VARCHAR2(48), 
	N NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KODY ***
 exec bpa.alter_policies('KODY');


COMMENT ON TABLE BARS.KODY IS '';
COMMENT ON COLUMN BARS.KODY.KOD IS '';
COMMENT ON COLUMN BARS.KODY.T IS '';
COMMENT ON COLUMN BARS.KODY.OPERACIA IS '';
COMMENT ON COLUMN BARS.KODY.N IS '';



PROMPT *** Create  grants  KODY ***
grant SELECT                                                                 on KODY            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KODY            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KODY            to START1;
grant SELECT                                                                 on KODY            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KODY.sql =========*** End *** ========
PROMPT ===================================================================================== 
