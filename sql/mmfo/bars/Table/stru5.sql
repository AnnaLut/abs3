

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU5.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU5 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU5'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU5'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU5'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU5 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU5 
   (	TYPE CHAR(7), 
	R020 CHAR(8), 
	OB22 CHAR(8), 
	TXT VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU5 ***
 exec bpa.alter_policies('STRU5');


COMMENT ON TABLE BARS.STRU5 IS '';
COMMENT ON COLUMN BARS.STRU5.TYPE IS '';
COMMENT ON COLUMN BARS.STRU5.R020 IS '';
COMMENT ON COLUMN BARS.STRU5.OB22 IS '';
COMMENT ON COLUMN BARS.STRU5.TXT IS '';



PROMPT *** Create  grants  STRU5 ***
grant SELECT                                                                 on STRU5           to BARSREADER_ROLE;
grant SELECT                                                                 on STRU5           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU5           to BARS_DM;
grant SELECT                                                                 on STRU5           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU5           to STRU5;
grant SELECT                                                                 on STRU5           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU5           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU5.sql =========*** End *** =======
PROMPT ===================================================================================== 
