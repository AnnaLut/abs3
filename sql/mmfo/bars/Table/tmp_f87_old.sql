

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_F87_OLD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_F87_OLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_F87_OLD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_F87_OLD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_F87_OLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_F87_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_F87_OLD 
   (	KODP VARCHAR2(11), 
	ZNAP NUMBER(15,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_F87_OLD ***
 exec bpa.alter_policies('TMP_F87_OLD');


COMMENT ON TABLE BARS.TMP_F87_OLD IS '';
COMMENT ON COLUMN BARS.TMP_F87_OLD.KODP IS '';
COMMENT ON COLUMN BARS.TMP_F87_OLD.ZNAP IS '';



PROMPT *** Create  grants  TMP_F87_OLD ***
grant SELECT                                                                 on TMP_F87_OLD     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_F87_OLD     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_F87_OLD     to START1;
grant SELECT                                                                 on TMP_F87_OLD     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_F87_OLD.sql =========*** End *** =
PROMPT ===================================================================================== 
