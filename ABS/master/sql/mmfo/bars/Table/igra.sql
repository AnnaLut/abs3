

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IGRA.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IGRA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IGRA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IGRA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IGRA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IGRA ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.IGRA 
   (	KVD NUMBER, 
	DEB VARCHAR2(15), 
	KVK NUMBER, 
	KRD VARCHAR2(15), 
	S NUMBER, 
	S1 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IGRA ***
 exec bpa.alter_policies('IGRA');


COMMENT ON TABLE BARS.IGRA IS '';
COMMENT ON COLUMN BARS.IGRA.KVD IS '';
COMMENT ON COLUMN BARS.IGRA.DEB IS '';
COMMENT ON COLUMN BARS.IGRA.KVK IS '';
COMMENT ON COLUMN BARS.IGRA.KRD IS '';
COMMENT ON COLUMN BARS.IGRA.S IS '';
COMMENT ON COLUMN BARS.IGRA.S1 IS '';



PROMPT *** Create  grants  IGRA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on IGRA            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IGRA            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on IGRA            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IGRA.sql =========*** End *** ========
PROMPT ===================================================================================== 
