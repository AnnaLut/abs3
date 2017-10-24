

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KASS_V_POP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KASS_V_POP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KASS_V_POP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KASS_V_POP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KASS_V_POP ***
begin 
  execute immediate '
  CREATE TABLE BARS.KASS_V_POP 
   (	IDM NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KASS_V_POP ***
 exec bpa.alter_policies('KASS_V_POP');


COMMENT ON TABLE BARS.KASS_V_POP IS '';
COMMENT ON COLUMN BARS.KASS_V_POP.IDM IS '';



PROMPT *** Create  grants  KASS_V_POP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KASS_V_POP      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KASS_V_POP      to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KASS_V_POP.sql =========*** End *** ==
PROMPT ===================================================================================== 
