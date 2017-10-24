# PLSQL.AWK version 2.1
#
# _trace - флаг трассировки 0/1
# out[]  - 0-макрос не найден, >0-найден (на уровне i)
# b      - переключитель #case / #other
# f      - флаг первого условия "#case" или "#casedef"
# p[]    - массив флагов(0,1) вывода по уровню вложенности
# i      - текущий размер массива p[]
BEGIN {_trace=0;
       for(i=0;i<10;i++) out[i]=1;
       b=0; i=0; f=0}
{    if ($1 == "#define") {v=v "+" $2} 
else if ($1 == "#ifdef"||$1 == "#if")  
	{if(_trace==1) print "$2=",$2,"$3=",$3,"$4=",$4,"$5=",$5,"$6=",$6,"$7=",$7,"$8=",$8,"$9=",$9,"v=",v
         i=i+1; 
         out[i]=index(v,$2); if(out[i]>0) p[i]=1; else p[i]=0; 
         if($3!="" && $3!="OR" && $3!="or" && $3!="||" && p[i]==0){
            out[i]=index(v,$3); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
         if($4!="" && $4!="OR" && $4!="or" && $4!="||" && p[i]==0){
            out[i]=index(v,$4); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
         if($5!="" && $5!="OR" && $5!="or" && $5!="||" && p[i]==0){
            out[i]=index(v,$5); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
         if($6!="" && $6!="OR" && $6!="or" && $6!="||" && p[i]==0){
            out[i]=index(v,$6); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
         if($7!="" && $7!="OR" && $7!="or" && $7!="||" && p[i]==0){
            out[i]=index(v,$7); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
         if($8!="" && $8!="OR" && $8!="or" && $8!="||" && p[i]==0){
            out[i]=index(v,$8); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
         if($9!="" && $9!="OR" && $9!="or" && $9!="||" && p[i]==0){
            out[i]=index(v,$9); if(out[i]>0) p[i]=1; else p[i]=0; 
         }
	 if(_trace==1) print "out[i]=",out[i],"i=",i,"p[i]=",p[i],$0
	}
else if ($1 == "#ifndef") 
	{i=i+1; 
         out[i]=1-index(v,$2); if(out[i]>0) p[i]=1; else p[i]=0;
	 if(_trace==1) print "i=",i,"p[i]=",p[i],$0
	}
else if ($1 == "#else") 
	{if (out[i]>0) out[i]=0; else out[i]=1; if(out[i]>0) p[i]=1; else p[i]=0;
	 if(_trace==1) print "i=",i,"p[i]=",p[i],$0
	}
else if ($1 == "#case"|| $1 == "#casedef") 
	{f=f+1; if (f==1) i=i+1;
         out[i] = index(v,$2); if (out[i]>0) b=1; 
	 if(out[i]>0) p[i]=1; else p[i]=0;
	}
else if ($1 == "#othe"|| $1 == "#other") 
	{if (b>0) out[i]=0; else out[i]=1;
	 if(out[i]>0) p[i]=1; else p[i]=0;
	}
else if ($1 == "#end" || $1 == "#endif") 
	{out[i]=1; b=0; f=0; 
         i=i-1;
	 if(_trace==1) print "i=",i,"out[",i,"]=",out[i],$0
	}
if(_trace==1) for(j=1;j<=i;j++) print "p[",j,"]=",p[j]
j=1
while(j<=i && p[j]==1) j++
if(_trace==1) print "j=",j
if (j>i && out[i]>0 && substr($0,1,1)!= "#") {print $0};  
}

