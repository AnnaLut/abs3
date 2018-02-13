PROMPT *** ALTER_POLICY_INFO to ND_TXT ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_TXT'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ND_TXT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_TXT'', ''WHOLE'' , ''E'', ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** ALTER_POLICIES to ND_TXT ***
 exec bpa.alter_policies('ND_TXT');

COMMIT;